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
