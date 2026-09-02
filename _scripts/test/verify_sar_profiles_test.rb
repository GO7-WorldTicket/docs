require "fileutils"
require "json"
require "minitest/autorun"
require "open3"
require "pathname"
require "tmpdir"
require "yaml"

class VerifySarProfilesTest < Minitest::Test
  SCRIPT = File.expand_path("../verify_sar_profiles.rb", __dir__)

  WRAPPER_TITLES = {
    "changelog.md" => "Changelog",
    "endpoints/available_routes_and_flights.md" => "Available Routes and Flights Calendar",
    "endpoints/cancel_booking.md" => "Full Booking Cancellation",
    "endpoints/create_booking.md" => "Create a booking",
    "endpoints/download_tickets.md" => "Download Tickets",
    "endpoints/error-response.md" => "OTA Error Response",
    "endpoints/low_fare_search.md" => "Low Fare Search",
    "endpoints/modify-booking.md" => "Modify booking",
    "endpoints/payment_and_ticketing.md" => "Payment and Ticketing",
    "endpoints/read_booking.md" => "Read booking",
    "endpoints/resend_cancellation_email.md" => "Cancellation Email Endpoint",
    "endpoints/resend_ticket_confirmation_email.md" => "Ticket Confirmation Resource Endpoint",
    "endpoints/seat_map.md" => "Seat Map",
    "endpoints/segments_cancellation.md" => "Cancel Booking by Segments with Automatic Refund."
  }.freeze

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

  def test_rejects_unlabeled_normal_profile_tenant_value
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_basic_entry_pages(docs_root)
      write_file(docs_root, "_site/ota-partner/endpoints/create_booking.html", <<~HTML)
        <html>
          <body>
            <p>normal-skywork-tenant</p>
          </body>
        </html>
      HTML

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_includes result[:stdout], "partner-normal-value _site/ota-partner/endpoints/create_booking.html:3"
      refute_includes result[:stdout], "normal-skywork-tenant"
    end
  end

  def test_allows_generic_normal_profile_username_label
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
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

  def test_rejects_non_string_postman_sensitive_variable_values
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_site/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_site/ota-partner/OTA_API_SAR.html", '<a href="/docs/assets/resources/OTA_partner_postman_collection.json">Collection</a>')
      write_file(
        docs_root,
        "_site/assets/resources/OTA_partner_postman_collection.json",
        JSON.pretty_generate(
          "variable" => [
            { "key" => "apiUrl", "value" => 123 },
            { "key" => "apiKey", "value" => true },
            { "key" => "agent_id", "value" => { "nested" => "value" } },
            { "key" => "tenant", "value" => ["value"] },
            { "key" => "token", "value" => nil }
          ]
        )
      )

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal 4, result[:stdout].lines.grep(/^partner-postman-variable /).length
      refute_includes result[:stdout], "nested"
      refute_includes result[:stdout], "value"
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

  def test_rejects_missing_profile_data
    within_docs_fixture do |docs_root|
      write_basic_entry_pages(docs_root)

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal "profile-schema _data/sar_profiles.yml:1\n", result[:stdout]
    end
  end

  def test_rejects_missing_or_non_mapping_profiles
    within_docs_fixture do |docs_root|
      write_file(docs_root, "_data/sar_profiles.yml", "sar: []\nsar_partner: missing\n")
      write_basic_entry_pages(docs_root)

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal "profile-schema _data/sar_profiles.yml:1\n", result[:stdout]
    end
  end

  def test_rejects_blank_required_profile_field_and_unsafe_partner_value
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      profile_path = File.join(docs_root, "_data/sar_profiles.yml")
      profile = File.read(profile_path)
        .sub('test_api_origin: https://test-api.worldticket.net', 'test_api_origin: ""')
        .sub('api_key_example: "{api_key}"', 'api_key_example: partner-live-value')
      File.write(profile_path, profile)
      write_basic_entry_pages(docs_root)

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal "profile-schema _data/sar_profiles.yml:1\n", result[:stdout]
      refute_includes result[:stdout], "partner-live-value"
    end
  end

  def test_rejects_unsafe_partner_placeholder_value
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      profile_path = File.join(docs_root, "_data/sar_profiles.yml")
      File.write(
        profile_path,
        File.read(profile_path).sub('api_key_example: "{api_key}"', 'api_key_example: partner-live-value')
      )
      write_basic_entry_pages(docs_root)

      result = run_validator(docs_root)

      assert_equal 1, result[:status]
      assert_equal "profile-schema _data/sar_profiles.yml:1\n", result[:stdout]
      refute_includes result[:stdout], "partner-live-value"
    end
  end

  def test_uses_supplied_build_destination
    within_docs_fixture do |docs_root|
      write_profiles(docs_root)
      write_file(docs_root, "_rendered/ota/OTA_API_SAR.html", "<html><body></body></html>")
      write_file(docs_root, "_rendered/ota-partner/OTA_API_SAR.html", "<html><body></body></html>")

      result = run_validator(docs_root, "_rendered")

      assert_equal 0, result[:status], result[:stdout]
    end
  end

  def test_normal_and_partner_wrappers_have_expected_titles
    docs_root = File.expand_path("../..", __dir__)

    WRAPPER_TITLES.each do |relative_path, title|
      %w[ota ota-partner].each do |tree|
        wrapper = File.read(File.join(docs_root, tree, relative_path))

        assert_match(/^title: #{Regexp.escape(title)}$/, wrapper)
      end
    end
  end

  def test_normal_profile_masks_match_the_baseline_markdown
    profiles = YAML.load_file(File.expand_path("../../_data/sar_profiles.yml", __dir__))

    assert_equal "**\\*\\*\\*\\***", profiles.fetch("sar").fetch("password_example")
    assert_equal "33357c21-3233-4eb3-a420-**\\*\\*\\*\\***", profiles.fetch("sar").fetch("client_secret_example")
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
        documentation_root: /docs/ota
        test_auth_origin: https://test-auth.worldticket.net
        test_api_origin: https://test-api.worldticket.net
        test_gateway_origin: https://test.worldticket.net
        production_origin: https://api.sar.worldticket.cloud
        legacy_api_origin: https://api.worldticket.net
        api_key_example: normal-api-key
        client_id_example: normal-client-id
        client_secret_example: normal-client-secret
        username_example: username
        password_example: "********"
        tenant_example: normal-tenant
        tenant_skywork_example: normal-skywork-tenant
        tenant_mservice_example: normal-mservice-tenant
        sample_email: normal@example.test
        named_sample_email: named@example.test
        cancellation_to_email: to@example.test
        cancellation_cc_email: cc@example.test
        cancellation_bcc_email: bcc@example.test
        test_com_email: test@example.test
        new_email_example: new@example.test
        access_token_example: normal-access-token
        refresh_token_example: normal-refresh-token
        id_token_example: normal-id-token
        onboarding_notice: ""
        postman_download: /docs/assets/resources/OTA_postman_collection.json
      sar_partner:
        documentation_root: /docs/ota-partner
        test_auth_origin: "{auth_base_url}"
        test_api_origin: "{base_url}"
        test_gateway_origin: "{service_base_url}"
        production_origin: "{production_base_url}"
        legacy_api_origin: "{auth_base_url}"
        api_key_example: "{api_key}"
        client_id_example: "{client_id}"
        client_secret_example: "{client_secret}"
        username_example: "{username}"
        password_example: "{password}"
        access_token_example: "{access_token}"
        refresh_token_example: "{refresh_token}"
        id_token_example: "{id_token}"
        tenant_example: "{tenant}"
        tenant_skywork_example: "{tenant}"
        tenant_mservice_example: "{tenant}"
        sample_email: test@example.com
        named_sample_email: named@example.com
        cancellation_to_email: to@example.com
        cancellation_cc_email: cc@example.com
        cancellation_bcc_email: bcc@example.com
        test_com_email: test@example.com
        new_email_example: new@example.com
        onboarding_notice: Partner environment URLs and credentials are supplied separately.
        postman_download: /docs/assets/resources/OTA_partner_postman_collection.json
    YAML
  end

  def write_file(root, relative_path, content)
    path = File.join(root, relative_path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
  end

  def run_validator(docs_root, site_arg = "_site")
    stdout, stderr, status = Open3.capture3(
      "ruby",
      SCRIPT,
      site_arg,
      chdir: docs_root
    )

    {
      stdout: stdout,
      stderr: stderr,
      status: status.exitstatus
    }
  end
end
