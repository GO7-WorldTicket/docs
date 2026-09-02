require "fileutils"
require "json"
require "minitest/autorun"
require "open3"
require "pathname"
require "tmpdir"

class VerifySarProfilesTest < Minitest::Test
  SCRIPT = File.expand_path("../verify_sar_profiles.rb", __dir__)

  def test_accepts_safe_output_and_public_links
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/ota/endpoints/create_booking.html">Create Booking</a>
            <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP">MDN</a>
            <img src="/docs/assets/logo.png" alt="logo">
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <a href="#request">Request</a>
            <section id="request"></section>
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/ota-partner/endpoints/create_booking.html">Create Booking</a>
            <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP">MDN</a>
            <a href="/docs/assets/resources/OTA_partner_postman_collection.json">Collection</a>
            <img src="/docs/assets/logo.png" alt="logo">
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <a href="#request">Request</a>
            <section id="request"></section>
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/assets/logo.png", "png")
      write_file(
        docs_root,
        "_site/assets/resources/OTA_partner_postman_collection.json",
        JSON.pretty_generate(
          "variable" => [
            { "key" => "apiUrl", "value" => "{{apiUrl}}" },
            { "key" => "clientSecret", "value" => "" }
          ]
        )
      )

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stderr]
      assert_equal "", result[:stdout]
    end
  end

  def test_rejects_partner_normal_host_leakage
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <a href="https://api.sar.worldticket.cloud/ota/v2015b/OTA">Bad</a>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-host _site/ota-partner/endpoints/create_booking.html:3"
    end
  end

  def test_rejects_populated_partner_credentials_and_jwts
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>client_secret: super-secret-value</p>
            <p>access_token = eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTYifQ.signature</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-credential _site/ota-partner/endpoints/create_booking.html:3"
      assert_includes result[:stdout], "partner-jwt _site/ota-partner/endpoints/create_booking.html:4"
    end
  end

  def test_rejects_partner_cross_links_into_normal_tree
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/ota/endpoints/read_booking.html">Wrong tree</a>
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota/endpoints/read_booking.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-cross-link _site/ota-partner/endpoints/create_booking.html:3"
    end
  end

  def test_rejects_missing_assets_and_anchors
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/ota/endpoints/create_booking.html#request">Create Booking</a>
            <img src="/docs/assets/logo.png" alt="logo">
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/ota-partner/endpoints/create_booking.html#request">Create Booking</a>
            <img src="/docs/assets/logo.png" alt="logo">
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "missing-anchor _site/ota/endpoints/create_booking.html:1"
      assert_includes result[:stdout], "missing-anchor _site/ota-partner/endpoints/create_booking.html:1"
      assert_includes result[:stdout], "missing-file _site/assets/logo.png:1"
    end
  end

  def test_rejects_unresolved_liquid_expressions
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>{{ page.profile.documentation_root }}</p>
            <p>{% if page.profile %}</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "unresolved-liquid _site/ota-partner/endpoints/create_booking.html:3"
      assert_includes result[:stdout], "unresolved-liquid _site/ota-partner/endpoints/create_booking.html:4"
    end
  end

  def test_allows_literal_postman_placeholders_in_rendered_partner_html
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>Use the provided placeholder value {{apiUrl}}</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
      refute_includes result[:stdout], "unresolved-liquid"
    end
  end

  def test_rejects_populated_partner_postman_variables_but_allows_liquid_placeholders
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/assets/resources/OTA_partner_postman_collection.json">Collection</a>
          </body>
        </html>
      HTML
      write_file(
        docs_root,
        "_site/assets/resources/OTA_partner_postman_collection.json",
        JSON.pretty_generate(
          "variable" => [
            { "key" => "apiUrl", "value" => "{{apiUrl}}" },
            { "key" => "username", "value" => "partner-user" },
            { "key" => "accessToken", "value" => "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTYifQ.signature" }
          ]
        )
      )

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      refute_includes result[:stdout], "{{apiUrl}}"
      assert_includes result[:stdout], "partner-postman-variable _site/assets/resources/OTA_partner_postman_collection.json:8"
      assert_includes result[:stdout], "partner-postman-variable _site/assets/resources/OTA_partner_postman_collection.json:12"
    end
  end

  def test_rejects_generic_partner_json_host_credential_and_jwt_leakage
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="/docs/assets/resources/partner_examples.json">Examples</a>
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/assets/resources/partner_examples.json", <<~JSON)
        {
          "baseUrl": "https://api.sar.worldticket.cloud/ota/v2015b/OTA",
          "credentials": {
            "password": "real-password"
          },
          "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTYifQ.signature"
        }
      JSON

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-host _site/assets/resources/partner_examples.json:2"
      assert_includes result[:stdout], "partner-credential _site/assets/resources/partner_examples.json:4"
      assert_includes result[:stdout], "partner-jwt _site/assets/resources/partner_examples.json:6"
    end
  end

  def test_resolves_extensionless_local_html_targets
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="/docs/ota/endpoints/create_booking">Create</a>')
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/ota-partner/endpoints/create_booking">Create</a>')
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_resolves_markdown_local_html_targets
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="/docs/ota/changelog.md">Change log</a>')
      write_file(docs_root, "_site/ota/changelog.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/ota-partner/changelog.md">Change log</a>')
      write_file(docs_root, "_site/ota-partner/changelog.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_resolves_relative_local_rendered_html_targets
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="changelog.md">Change log</a><a href="endpoints/create_booking">Create</a>')
      write_file(docs_root, "_site/ota/changelog.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="changelog.md">Change log</a><a href="endpoints/create_booking">Create</a>')
      write_file(docs_root, "_site/ota-partner/changelog.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_accepts_local_asset_references_with_spaces
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<img src="/docs/assets/Worldticket Logo.png" alt="logo">')
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<img src="/docs/assets/Worldticket Logo.png" alt="logo">')
      write_file(docs_root, "_site/assets/Worldticket Logo.png", "png")

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_allows_multiple_placeholder_credentials_in_form_body
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <pre>client_secret={client_secret}&username={username}&password={password}</pre>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_rejects_populated_credential_after_safe_form_placeholder
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <pre>client_secret={client_secret}&username=live-user&password=live-password</pre>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-credential _site/ota-partner/endpoints/create_booking.html:3"
      refute_includes result[:stdout], "live-user"
      refute_includes result[:stdout], "live-password"
    end
  end

  def test_rejects_malformed_external_url_with_whitespace_in_host
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="https://example .com/path">Bad</a>')
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "invalid-link _site/ota/OTA_API_SAR.html:1"
    end
  end

  def test_allows_hyphenated_literal_credential_placeholders
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <pre>api-key: {api-key}</pre>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_rejects_unlabeled_normal_profile_sensitive_value
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>normal-client-id</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-normal-value _site/ota-partner/endpoints/create_booking.html:3"
      refute_includes result[:stdout], "normal-client-id"
    end
  end

  def test_allows_generic_normal_profile_username_label
    within_docs_fixture do |docs_root|
      write_file(docs_root, "_data/sar_profiles.yml", <<~YAML)
        sar:
          username_example: username
      YAML
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>username</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_rejects_populated_postman_sensitive_variable_keys
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/assets/resources/OTA_partner_postman_collection.json">Collection</a>')
      sensitive_keys = %w[
        apiUrl apiKey agent_id agent_name tenant token id_token
        accessToken access_token access-token
        refreshToken refresh_token refresh-token
        username user_name password clientSecret client_secret client-secret
      ]
      write_file(
        docs_root,
        "_site/assets/resources/OTA_partner_postman_collection.json",
        JSON.pretty_generate(
          "variable" => sensitive_keys.each_with_index.map do |key, index|
            { "key" => key, "value" => "populated-#{index}" }
          end
        )
      )

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal sensitive_keys.length, result[:stdout].lines.grep(/^partner-postman-variable /).length
      refute_includes result[:stdout], "populated-"
    end
  end

  def test_allows_blank_and_placeholder_postman_sensitive_variable_keys
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/assets/resources/OTA_partner_postman_collection.json">Collection</a>')
      sensitive_keys = %w[apiUrl apiKey agent_id agent_name tenant token id_token access_token refresh_token username password client_secret]
      write_file(
        docs_root,
        "_site/assets/resources/OTA_partner_postman_collection.json",
        JSON.pretty_generate(
          "variable" => sensitive_keys.each_with_index.map do |key, index|
            { "key" => key, "value" => index.even? ? "" : "{{#{key}}}" }
          end
        )
      )

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_resolves_absolute_local_query_and_fragment
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="/docs/ota/endpoints/create_booking.html?scenario=1#request">Create</a>')
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", '<section id="request"></section>')
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/ota-partner/endpoints/create_booking.html?scenario=1#request">Create</a>')
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", '<section id="request"></section>')

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_resolves_relative_local_query_and_fragment
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", '<a href="endpoints/create_booking.html?scenario=1#request">Create</a>')
      write_file(docs_root, "_site/ota/endpoints/create_booking.html", '<section id="request"></section>')
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="endpoints/create_booking.html?scenario=1#request">Create</a>')
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", '<section id="request"></section>')

      result = run_validator(docs_root)

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_reports_referring_line_for_invalid_external_link
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", <<~HTML)
        <html>
          <body>
            <a href="https://example .com/path">Bad</a>
          </body>
        </html>
      HTML
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", "<html><body></body></html>")

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "invalid-link _site/ota/OTA_API_SAR.html:3"
    end
  end

  private

  def within_docs_fixture
    Dir.mktmpdir("verify-sar-profiles") do |dir|
      docs_root = File.join(dir, "docs")
      FileUtils.mkdir_p(docs_root)
      yield docs_root
    end
  end

  def write_basic_entry_pages(docs_root)
    write_file(docs_root, "_site/ota/OTA_API_SAR.html", <<~HTML)
      <html>
        <body>
          <a href="/docs/ota/endpoints/create_booking.html">Create Booking</a>
        </body>
      </html>
    HTML
    write_file(docs_root, "_site/ota/endpoints/create_booking.html", "<html><body></body></html>")
    write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", <<~HTML)
      <html>
        <body>
          <a href="/docs/ota-partner/endpoints/create_booking.html">Create Booking</a>
        </body>
      </html>
    HTML
    write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", "<html><body></body></html>")
  end

  def write_profiles(docs_root)
    write_file(docs_root, "_data/sar_profiles.yml", <<~YAML)
      sar:
        production_auth_url: https://api.sar.worldticket.cloud/auth
        test_auth_url: https://test-auth.worldticket.net/auth
        production_ota_url: https://api.sar.worldticket.cloud/ota/v2015b/OTA
        test_ota_url: https://test-api.worldticket.net/ota/v2015b/OTA
        api_key_example: normal-api-key
        client_id_example: normal-client-id
        client_secret_example: normal-client-secret
        tenant_example: normal-tenant
        sample_email: normal@example.test
        access_token_example: normal-access-token
        refresh_token_example: normal-refresh-token
        id_token_example: normal-id-token
    YAML
  end

  def write_file(root, relative_path, content)
    path = File.join(root, relative_path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
  end

  def run_validator(docs_root)
    stdout, stderr, status = Open3.capture3(
      "ruby",
      SCRIPT,
      "_site",
      chdir: docs_root
    )

    {
      stdout: stdout,
      stderr: stderr,
      status: status.exitstatus
    }
  end
end
