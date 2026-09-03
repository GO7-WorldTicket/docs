---
published: false
---

# SAR Documentation Update Checklist

Use this checklist whenever SAR documentation changes. It applies to both the normal SAR tree and the SAR Partner tree.

## 1. Identify the change

- Decide whether the change is functional documentation, profile-specific configuration, navigation, a downloadable asset, or a Postman collection change.
- Confirm the existing page and shared include before editing. Do not copy an endpoint document into a second full implementation.

## 2. Edit the correct source

- Functional API behavior, methods, paths, headers, parameters, schemas, examples, workflows, and errors: edit the matching file under `_includes/ota-sar/`.
- Test/Production origins, credentials, tenants, sample values, notices, documentation roots, and collection downloads: edit `_data/sar_profiles.yml`.
- A new SAR page: add one thin wrapper under `ota/` and a matching wrapper under `ota-partner/`, both including one shared file.
- Large legacy examples that still contain old literals: preserve the existing `capture`/`replace` pattern and update its profile replacements rather than duplicating the document.

## 3. Keep the two audiences safe

- Normal SAR values remain in the `sar` profile.
- Partner values must use approved readable placeholders such as `{base_url}`, `{production_base_url}`, `{auth_base_url}`, `{service_base_url}`, `{api_key}`, `{client_secret}`, `{username}`, `{password}`, `{tenant}`, or token placeholders.
- Never place a real partner credential, token, or environment-specific secret in shared content.
- Keep intentional Postman variables such as `{{agentId}}` inside Liquid raw blocks when they appear in shared Markdown.

## 4. Check navigation and downloads

- Use rendered `.html` targets for local documentation links, for example `changelog.html` and `endpoints/create_booking.html`.
- Use `sar_profile.documentation_root` when a link must point back to the selected SAR entry tree.
- Verify that partner links stay under `/docs/ota-partner/`; they must not point into `/docs/ota/`.
- If a downloadable asset contains profile-sensitive content, provide a partner-safe variant and select it through `postman_download` or the relevant profile field.
- Preserve the shared schema ZIP only after confirming it contains no environment or credential data.

## 5. Update Postman correctly

- Review the normal and partner collections together.
- Preserve request groups, methods, paths, query strings, headers, bodies, scripts, and tests.
- In the partner collection, use `{{apiUrl}}` for origins and leave configuration variables empty or placeholder-based.
- Do not commit generated access tokens or internal workspace metadata.

## 6. Build and validate locally

From the repository root:

```bash
bundle install
bundle exec jekyll build --config github-page/_config.yml --destination _site
ruby _scripts/test/verify_sar_profiles_test.rb
ruby _scripts/verify_sar_profiles.rb _site
git diff --check
```

If the local Ruby or Bundler command is unavailable, follow [`github-page/Github-page.md`](../../github-page/Github-page.md) to prepare the local Jekyll environment.

The validator must finish with no findings. It checks both entry pages, reachable pages, anchors, images, schemas, downloads, partner cross-links, unresolved Liquid, normal-host leakage, credential-shaped values, JWTs, and partner Postman variables.

## 7. Review both rendered trees

Start the local server when visual checking is useful:

```bash
bundle exec jekyll serve --config github-page/_config.yml --destination _site
```

Open both entry pages:

- `/docs/ota/OTA_API_SAR.html`
- `/docs/ota-partner/OTA_API_SAR.html`

Check a representative endpoint, the changelog and dated anchor, the schema download, and the profile-specific Postman download. Confirm the normal page shows real environment values and the partner page shows readable placeholders and the onboarding notice.

## 8. Prepare the change

- Compare normal and partner output for matching functional content.
- Confirm only expected profile differences exist: origins, credentials, routing, downloads, and the partner notice.
- Confirm repository-only guides remain absent from `_site`.
- Stage only the intended files.
- Use a conventional commit such as `docs(ST-1807): update SAR documentation`.
- Open or prepare the pull request with a focused title and summary, and include the build, test, validator, rendered-tree, and repository-only guide verification evidence.
