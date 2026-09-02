#!/usr/bin/env ruby

require "digest"
require "json"
require "pathname"
require "set"
require "uri"
require "yaml"

ENTRY_PAGES = [
  ["normal", "ota/OTA_API_SAR.html"],
  ["partner", "ota-partner/OTA_API_SAR.html"]
].freeze

PROFILE_DATA_PATH = "_data/sar_profiles.yml"

REQUIRED_PROFILE_FIELDS = %w[
  documentation_root
  test_auth_origin
  test_api_origin
  test_gateway_origin
  production_origin
  legacy_api_origin
  api_key_example
  client_id_example
  client_secret_example
  username_example
  password_example
  access_token_example
  refresh_token_example
  id_token_example
  tenant_example
  tenant_skywork_example
  tenant_mservice_example
  sample_email
  named_sample_email
  cancellation_to_email
  cancellation_cc_email
  cancellation_bcc_email
  test_com_email
  new_email_example
  onboarding_notice
  postman_download
].freeze

PROFILE_PATH_FIELDS = %w[documentation_root postman_download].freeze

PARTNER_PLACEHOLDER_FIELDS = %w[
  test_auth_origin
  test_api_origin
  test_gateway_origin
  production_origin
  legacy_api_origin
  api_key_example
  client_id_example
  client_secret_example
  username_example
  password_example
  access_token_example
  refresh_token_example
  id_token_example
  tenant_example
  tenant_skywork_example
  tenant_mservice_example
].freeze

APPROVED_PARTNER_PLACEHOLDERS = Set.new(%w[
  base_url
  production_base_url
  auth_base_url
  service_base_url
  api_key
  api-key
  client_id
  client_secret
  username
  password
  access_token
  refresh_token
  id_token
  tenant
  tenant-name
]).freeze

DOWNLOAD_EXTENSIONS = Set.new(%w[.json .zip .pdf .yaml .yml .xml .csv]).freeze

APPROVED_BINARY_DOWNLOAD_SHA256 = {
  "assets/resources/ota-xmlbeans-2015B.zip" => "48dca034679e58096edb80df19616061d78e22d04e4ee09a7c08d76115c8619e"
}.freeze

SENSITIVE_NORMAL_PROFILE_KEYS = %w[
  api_key_example
  client_id_example
  client_secret_example
  username_example
  password_example
  access_token_example
  refresh_token_example
  id_token_example
  tenant_example
  tenant_skywork_example
  tenant_mservice_example
  sample_email
  named_sample_email
  cancellation_to_email
  cancellation_cc_email
  cancellation_bcc_email
  test_com_email
  new_email_example
].freeze

NON_SENSITIVE_NORMAL_PROFILE_VALUES = Set.new([
  "username",
  "********"
]).freeze

SENSITIVE_POSTMAN_VARIABLE_KEYS = %w[
  apiurl
  apikey
  agentid
  agentname
  tenant
  token
  idtoken
  accesstoken
  refreshtoken
  username
  password
  clientsecret
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
  (?:["']\s*)?
  (?<value>[^<\n\s&'\"]+)
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
    @visited_downloads = Set.new
    @profile_schema_valid = load_profiles
    @normal_hosts = @profile_schema_valid ? load_normal_hosts : Set.new
    @normal_sensitive_values = @profile_schema_valid ? load_normal_sensitive_values : Set.new
  end

  def run
    unless @profile_schema_valid
      print_findings
      return 1
    end

    ENTRY_PAGES.each do |profile, relative_entry|
      crawl_entry(profile, relative_entry)
    end

    print_findings
    @findings.empty? ? 0 : 1
  end

  private

  def crawl_entry(profile, relative_entry)
    entry_path = @site_root.join(relative_entry)
    unless entry_path.file?
      add_finding("missing-file", relative_to_docs(entry_path), 1)
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
    scan_partner_normal_values(relative_path, content)
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

  def scan_partner_normal_values(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      @normal_sensitive_values.each do |value|
        add_finding("partner-normal-value", relative_path, line_no) if line.include?(value)
      end
    end
  end

  def scan_partner_credentials(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      line.scan(CREDENTIAL_PATTERN) do
        match = Regexp.last_match
        next if placeholder_or_blank?(match[:value])

        add_finding("partner-credential", relative_path, line_no)
      end
    end
  end

  def scan_partner_jwts(relative_path, content)
    content.each_line.with_index(1) do |line, line_no|
      add_finding("partner-jwt", relative_path, line_no) if line.match?(JWT_PATTERN)
    end
  end

  def traverse_local_references(profile, current_path, content)
    content.each_line.with_index(1) do |line, line_no|
      line.scan(LOCAL_REFERENCE_PATTERN) do
        attr = Regexp.last_match[:attr]
        target = Regexp.last_match[:target]
        handle_reference(profile, current_path, target, line_no, attr)
      end
    end
  end

  def handle_reference(profile, current_path, target, line_no, attr)
    return if target.nil? || target.empty? || target.start_with?("mailto:", "javascript:")

    if external_reference?(target)
      check_external_reference(profile, current_path, target, line_no)
      return
    end

    check_local_reference(profile, current_path, target, attr)
  rescue URI::InvalidURIError
    add_finding("invalid-link", relative_to_docs(current_path), line_no)
  end

  def check_external_reference(profile, current_path, target, line_no)
    uri = URI.parse(target)
    if invalid_http_authority?(uri, target)
      add_finding("invalid-link", relative_to_docs(current_path), line_no)
      return
    end

    return unless profile == "partner"

    host = uri.host
    return unless host && @normal_hosts.include?(host)

    add_finding("partner-host", relative_to_docs(current_path), line_no)
  end

  def check_local_reference(profile, current_path, target, attr)
    path_part, anchor = target.split("#", 2)
    path_part = path_part.split("?", 2).first unless path_part.nil?
    if path_part.nil? || path_part.empty?
      assert_anchor_exists(current_path, anchor)
      return
    end

    resolved = resolve_local_target(current_path, path_part)
    relative_target = relative_to_docs(resolved)

    if profile == "partner" && normal_profile_path?(resolved)
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

    scan_partner_download(resolved) if profile == "partner" && attr == "href" && download_reference?(resolved)

    if resolved.extname == ".html"
      crawl_html(profile, resolved)
    end
  end

  def download_reference?(path)
    DOWNLOAD_EXTENSIONS.include?(path.extname.downcase)
  end

  def scan_partner_download(path)
    relative_path = relative_to_docs(path)
    return if @visited_downloads.include?(relative_path)

    @visited_downloads << relative_path
    if path.extname.downcase == ".json"
      scan_partner_postman_file(path)
      return
    end

    content = path.binread
    scan_partner_sensitive_content(relative_path, content.encode("UTF-8", invalid: :replace, undef: :replace))
    verify_approved_binary_download(path, content)
  rescue SystemCallError, Encoding::UndefinedConversionError
    add_finding("invalid-download", relative_path, 1)
  end

  def verify_approved_binary_download(path, content)
    relative_path = path.relative_path_from(@site_root).to_s
    expected_hash = APPROVED_BINARY_DOWNLOAD_SHA256[relative_path]
    return unless expected_hash

    return if Digest::SHA256.hexdigest(content) == expected_hash

    add_finding("partner-download-hash", relative_to_docs(path), 1)
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
    return false if value.nil?
    return true unless value.is_a?(String)
    return false if placeholder_or_blank?(value)

    true
  end

  def sensitive_key?(key)
    SENSITIVE_POSTMAN_VARIABLE_KEYS.include?(key.downcase.gsub(/[-_ ]/, ""))
  end

  def placeholder_or_blank?(value)
    stripped = value.to_s.strip
    return true if stripped.empty?

    allowed_literal_placeholder?(stripped)
  end

  def allowed_literal_placeholder?(expression)
    stripped = expression.strip
    return true if stripped.match?(/\A\{\{[a-zA-Z0-9_]+\}\}\z/)

    match = stripped.match(/\A\{(?<name>[a-z_-]+)\}(\/.*)?\z/)
    match && APPROVED_PARTNER_PLACEHOLDERS.include?(match[:name])
  end

  def resolve_local_target(current_path, path_part)
    resolved =
      if path_part.start_with?("/docs/")
        @site_root.join(path_part.delete_prefix("/docs/"))
      elsif path_part.start_with?("/")
        @site_root.join(path_part.delete_prefix("/"))
      else
        current_path.dirname.join(path_part)
      end
    resolved = resolved.cleanpath
    return resolved if resolved.file?

    rendered = rendered_html_target(resolved)
    return rendered if rendered&.file?

    rendered || resolved
  end

  def external_reference?(target)
    target.start_with?("//") || target.match?(/\A[a-z][a-z0-9+.-]*:/i)
  end

  def invalid_http_authority?(uri, target)
    return false unless uri.scheme&.match?(/\Ahttps?\z/i) || target.start_with?("//")

    authority = target.sub(/\A(?:[a-z][a-z0-9+.-]*:)?\/\//i, "").split(/[\/?#]/, 2).first
    uri.host.nil? || authority.match?(/\s/)
  end

  def rendered_html_target(path)
    case path.extname
    when ".md"
      path.sub_ext(".html")
    when ""
      path.sub_ext(".html")
    end
  end

  def load_normal_hosts
    @normal_profile.values.each_with_object(Set.new) do |value, hosts|
      next unless value.is_a?(String)

      uri = URI.parse(value)
      hosts << uri.host if uri.host
    rescue URI::InvalidURIError
      next
    end
  end

  def load_normal_sensitive_values
    @normal_profile.each_with_object(Set.new) do |(key, value), values|
      next unless SENSITIVE_NORMAL_PROFILE_KEYS.include?(key.to_s)
      next unless value.is_a?(String) && !value.empty?
      next if NON_SENSITIVE_NORMAL_PROFILE_VALUES.include?(value)

      values << value
    end
  end

  def load_profiles
    profile_path = @docs_root.join(PROFILE_DATA_PATH)
    unless profile_path.file?
      add_profile_schema_finding
      return false
    end

    data = YAML.load_file(profile_path.to_s)
    unless data.is_a?(Hash)
      add_profile_schema_finding
      return false
    end

    @normal_profile = data["sar"] || data[:sar]
    @partner_profile = data["sar_partner"] || data[:sar_partner]
    unless @normal_profile.is_a?(Hash) && @partner_profile.is_a?(Hash)
      add_profile_schema_finding
      return false
    end

    unless valid_profile?(@normal_profile, normal: true) && valid_profile?(@partner_profile, normal: false)
      add_profile_schema_finding
      return false
    end

    true
  rescue Psych::Exception
    add_profile_schema_finding
    false
  end

  def valid_profile?(profile, normal:)
    REQUIRED_PROFILE_FIELDS.all? do |field|
      value = profile[field] || profile[field.to_sym]
      next normal && field == "onboarding_notice" if value.is_a?(String) && value.strip.empty?
      value.is_a?(String) && !value.strip.empty? &&
        (!PROFILE_PATH_FIELDS.include?(field) || profile_path?(value)) &&
        (normal || !PARTNER_PLACEHOLDER_FIELDS.include?(field) || safe_partner_placeholder?(value))
    end
  end

  def profile_path?(value)
    value.start_with?("/")
  end

  def safe_partner_placeholder?(value)
    match = value.match(/\A\{(?<name>[a-z_-]+)\}\z/)
    match && APPROVED_PARTNER_PLACEHOLDERS.include?(match[:name])
  end

  def add_profile_schema_finding
    add_finding("profile-schema", PROFILE_DATA_PATH, 1)
  end

  def normal_profile_path?(path)
    path.cleanpath.to_s.start_with?("#{@site_root.join("ota").cleanpath}/")
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
