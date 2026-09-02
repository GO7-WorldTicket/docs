#!/usr/bin/env ruby

require "json"
require "pathname"
require "set"
require "uri"
require "yaml"

ENTRY_PAGES = [
  ["normal", "_site/ota/OTA_API_SAR.html"],
  ["partner", "_site/ota-partner/OTA_API_SAR.html"]
].freeze

PUBLIC_PLACEHOLDER_PATTERNS = [
  /\A\{\{[a-zA-Z0-9_]+\}\}\z/,
  /\A\{[a-z_]+\}(\/.*)?\z/
].freeze

LOCAL_REFERENCE_PATTERN = /
  (?<attr>href|src)\s*=\s*(?<quote>["'])(?<target>[^"']+)\k<quote>
/x.freeze

ANCHOR_PATTERN = /
  \bid\s*=\s*(?<quote>["'])(?<id>[^"']+)\k<quote>|
  \bname\s*=\s*(?<quote2>["'])(?<name>[^"']+)\k<quote2>
/x.freeze

JWT_PATTERN = /
  \beyJ[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\b
/x.freeze

CREDENTIAL_PATTERN = /
  \b(api[_ -]?key|client[_ -]?secret|username|password|access[_ -]?token|refresh[_ -]?token)\b
  [^<\n:=]{0,20}
  [:=]
  \s*
  (?<value>[^<\n]+)
/ix.freeze

UNRESOLVED_LIQUID_PATTERN = /
  \{\{\s*[^}]+\s*\}\}|
  \{%\s*[^%]+\s*%\}
/x.freeze

class SarProfileVerifier
  def initialize(site_arg, docs_root: Dir.pwd)
    @docs_root = Pathname.new(docs_root)
    @site_root = @docs_root.join(site_arg)
    @findings = []
    @visited_html = Set.new
    @normal_hosts = load_normal_hosts
  end

  def run
    ENTRY_PAGES.each do |profile, relative_entry|
      crawl_entry(profile, relative_entry)
    end

    print_findings
    @findings.empty? ? 0 : 1
  end

  private

  def crawl_entry(profile, relative_entry)
    entry_path = @docs_root.join(relative_entry)
    unless entry_path.file?
      add_finding("missing-file", relative_entry, 1)
      return
    end

    crawl_html(profile, entry_path)
  end

  def crawl_html(profile, path)
    relative_path = relative_to_docs(path)
    return if @visited_html.include?(relative_path)

    @visited_html << relative_path
    content = path.read
    scan_html_content(profile, relative_path, content)
    traverse_local_references(profile, path, content)
  end

  def scan_html_content(profile, relative_path, content)
    scan_unresolved_liquid(relative_path, content)
    return unless profile == "partner"

    scan_partner_sensitive_content(relative_path, content)
  end

  def scan_unresolved_liquid(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      next unless line.match?(UNRESOLVED_LIQUID_PATTERN)
      next if line.scan(UNRESOLVED_LIQUID_PATTERN).all? { |expression| allowed_literal_placeholder?(expression) }

      add_finding("unresolved-liquid", relative_path, line_no)
    end
  end

  def scan_partner_sensitive_content(relative_path, content)
    scan_partner_hosts(relative_path, content)
    scan_partner_credentials(relative_path, content)
    scan_partner_jwts(relative_path, content)
  end

  def scan_partner_hosts(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      @normal_hosts.each do |host|
        add_finding("partner-host", relative_path, line_no) if line.include?(host)
      end
    end
  end

  def scan_partner_credentials(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      match = line.match(CREDENTIAL_PATTERN)
      next unless match
      next if placeholder_or_blank?(match[:value])

      add_finding("partner-credential", relative_path, line_no)
    end
  end

  def scan_partner_jwts(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      add_finding("partner-jwt", relative_path, line_no) if line.match?(JWT_PATTERN)
    end
  end

  def traverse_local_references(profile, current_path, content)
    content.each_line.with_index(1) do |line, _line_no|
      line.scan(LOCAL_REFERENCE_PATTERN) do
        target = Regexp.last_match[:target]
        handle_reference(profile, current_path, target)
      end
    end
  end

  def handle_reference(profile, current_path, target)
    return if target.nil? || target.empty? || target.start_with?("mailto:", "javascript:")

    uri = URI.parse(target)
    if uri.scheme
      check_external_reference(profile, current_path, target)
      return
    end

    check_local_reference(profile, current_path, target)
  rescue URI::InvalidURIError
    add_finding("invalid-link", relative_to_docs(current_path), 1)
  end

  def check_external_reference(profile, current_path, target)
    return unless profile == "partner"

    host = URI.parse(target).host
    return unless host && @normal_hosts.include?(host)

    add_finding_for_match("partner-host", relative_to_docs(current_path), current_path.read, target)
  end

  def check_local_reference(profile, current_path, target)
    path_part, anchor = target.split("#", 2)
    if path_part.nil? || path_part.empty?
      assert_anchor_exists(current_path, anchor)
      return
    end

    resolved = resolve_local_target(current_path, path_part)
    relative_target = relative_to_docs(resolved)

    if profile == "partner" && relative_target.start_with?("_site/ota/")
      add_finding_for_match("partner-cross-link", relative_to_docs(current_path), current_path.read, target)
      return
    end

    unless resolved.file?
      add_finding("missing-file", relative_target, 1)
      return
    end

    if anchor
      assert_anchor_exists(resolved, anchor)
    end

    if resolved.extname == ".html"
      crawl_html(profile, resolved)
    elsif profile == "partner" && resolved.extname == ".json"
      scan_partner_postman_file(resolved)
    end
  end

  def assert_anchor_exists(path, anchor)
    return if anchor.nil? || anchor.empty?

    content = path.read
    return if anchor_exists?(content, anchor)

    add_finding("missing-anchor", relative_to_docs(path), 1)
  end

  def anchor_exists?(content, anchor)
    content.scan(ANCHOR_PATTERN).any? do |_full_id_quote, id, _full_name_quote, name|
      id == anchor || name == anchor
    end
  end

  def scan_partner_postman_file(path)
    content = path.read
    data = JSON.parse(content)
    scan_partner_sensitive_content(relative_to_docs(path), content)
    scan_postman_object(data, content, path)
  rescue JSON::ParserError
    add_finding("invalid-json", relative_to_docs(path), 1)
  end

  def scan_postman_object(object, content, path)
    case object
    when Hash
      if object["key"].is_a?(String) && object.key?("value")
        value = object["value"]
        if populated_partner_variable?(object["key"], value)
          add_finding_for_match(
            "partner-postman-variable",
            relative_to_docs(path),
            content,
            %("#{object["key"]}"),
            fallback: 1
          )
        end
      end
      object.each_value { |value| scan_postman_object(value, content, path) }
    when Array
      object.each { |value| scan_postman_object(value, content, path) }
    end
  end

  def populated_partner_variable?(key, value)
    return false unless sensitive_key?(key)
    return false unless value.is_a?(String)
    return false if placeholder_or_blank?(value)

    true
  end

  def sensitive_key?(key)
    key.match?(/\A(api[-_ ]?key|client[-_ ]?secret|username|password|access[-_ ]?token|refresh[-_ ]?token)\z/i)
  end

  def placeholder_or_blank?(value)
    stripped = value.to_s.strip
    return true if stripped.empty?

    PUBLIC_PLACEHOLDER_PATTERNS.any? { |pattern| stripped.match?(pattern) }
  end

  def allowed_literal_placeholder?(expression)
    stripped = expression.strip
    PUBLIC_PLACEHOLDER_PATTERNS.any? { |pattern| stripped.match?(pattern) }
  end

  def resolve_local_target(current_path, path_part)
    clean_path =
      if path_part.start_with?("/docs/")
        path_part.delete_prefix("/docs/")
      elsif path_part.start_with?("/")
        path_part.delete_prefix("/")
      else
        return current_path.dirname.join(path_part).cleanpath
      end

    @site_root.join(clean_path).cleanpath
  end

  def load_normal_hosts
    profile_path = @docs_root.join("_data/sar_profiles.yml")
    return Set.new unless profile_path.file?

    data = YAML.load_file(profile_path.to_s)
    profile = data.is_a?(Hash) ? data["sar"] || data[:sar] : nil
    return Set.new unless profile.is_a?(Hash)

    profile.values.each_with_object(Set.new) do |value, hosts|
      next unless value.is_a?(String)

      uri = URI.parse(value)
      hosts << uri.host if uri.host
    rescue URI::InvalidURIError
      next
    end
  end

  def add_finding_for_match(category, relative_path, content, needle, fallback: 1)
    line_no = content.each_line.with_index(1).find { |line, _index| line.include?(needle) }&.last || fallback
    add_finding(category, relative_path, line_no)
  end

  def add_finding(category, relative_path, line_no)
    finding = [category, relative_path, line_no]
    @findings << finding unless @findings.include?(finding)
  end

  def relative_to_docs(path)
    path.relative_path_from(@docs_root).to_s
  end

  def print_findings
    @findings.sort.each do |category, relative_path, line_no|
      puts "#{category} #{relative_path}:#{line_no}"
    end
  end
end

exit(
  SarProfileVerifier.new(ARGV.fetch(0, "_site")).run
)
