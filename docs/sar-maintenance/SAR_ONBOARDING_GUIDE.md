---
published: false
---

# SAR Documentation Onboarding Guide

This guide explains how one Markdown source produces two SAR documentation audiences without maintaining two copies of the functional API content.

## Repository layout

| Area | Purpose |
| --- | --- |
| `_data/sar_profiles.yml` | The normal and partner values used during rendering. |
| `_includes/ota-sar/` | Shared SAR overview, changelog, endpoint, and error-handling content. |
| `ota/` | Thin normal-profile wrappers that preserve the existing SAR URLs. |
| `ota-partner/` | Thin partner-profile wrappers under the separate partner URL tree. |
| `assets/resources/OTA_postman_collection.json` | The normal Postman collection. |
| `assets/resources/OTA_partner_postman_collection.json` | The sanitized partner Postman collection. |
| `_scripts/verify_sar_profiles.rb` | Local safety and reachability validator for the rendered output. |

The files in this guide and `SAR_UPDATE_CHECKLIST.md` are repository-only. Their `published: false` front matter keeps them out of the Jekyll site.

## How profile rendering works

The normal entry wrapper selects the `sar` profile:

```yaml
---
layout: default
sar_profile: sar
---
{% assign sar_profile = site.data.sar_profiles[page.sar_profile] %}
{% include ota-sar/overview.md %}
```

The partner entry wrapper is identical except for `sar_profile: sar_partner`. Jekyll loads the YAML data into `site.data.sar_profiles`, looks up the selected key, assigns the result to `sar_profile`, and renders the shared include.

The endpoint wrappers use the same pattern. For example, both Create Booking pages include `_includes/ota-sar/endpoints/create_booking.md`; only the selected profile differs.

The build flow is:

```text
profile YAML
    ↓
thin wrapper front matter
    ↓
sar_profile assignment
    ↓
shared SAR include
    ↓
Jekyll Markdown/Liquid rendering
    ↓
normal HTML tree + partner HTML tree
```

## How to write shared content

Use profile variables for every value that differs between audiences:

```liquid
| OTA API | {{ sar_profile.test_api_origin }}/ota/v2015b/OTA |
| Tenant  | {{ sar_profile.tenant_example }} |
```

The normal output receives the values from `sar`; the partner output receives placeholders from `sar_partner`. Keep the API path, method, parameter names, payload structure, and explanation identical.

For links that must follow the selected tree, use the profile root:

```liquid
[Access token]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#api-key)
```

For ordinary links within the current tree, use relative rendered HTML paths:

```markdown
[Change log](changelog.html#2026-09-02)
[Create booking](endpoints/create_booking.html)
```

Do not use `.md` links for pages that Jekyll renders as `.html`; those links can produce a 404 in the local server and in the published site.

## Legacy examples and capture/replace

Some large legacy documents contain many existing URLs and sample values inside long payloads. Rewriting those payloads by hand would create drift and increase the chance of changing functional examples.

Those files capture the document first and then apply profile replacements:

```liquid
{% capture sar_document %}
  ...shared example content...
{% endcapture %}
{{ sar_document
  | replace: 'existing production origin', sar_profile.production_origin
  | replace: 'existing test origin', sar_profile.test_api_origin }}
```

For the normal profile, the replacement values preserve the existing output. For the partner profile, they become safe placeholders. When adding new content, prefer direct profile variables; use capture/replace for the legacy sections that already follow that pattern.

## Liquid and Postman variables

Jekyll and Postman both use double braces, but they mean different things:

- Jekyll expression: `{{ sar_profile.test_api_origin }}`.
- Literal Postman variable: `{{agentId}}`.

Protect literal Postman examples with a raw block:

```liquid
{% raw %}{{agentId}}{% endraw %}
```

Without the raw block, Jekyll may try to resolve the Postman variable as a Liquid expression.

## Normal and partner Postman collections

The Postman JSON files are static downloads; Jekyll does not render their contents through the profile variable. Maintain two committed collections instead.

The partner collection must preserve the normal collection’s request behavior while sanitizing configuration:

- Keep all 18 request groups, methods, paths, query strings, headers, bodies, scripts, and tests.
- Use `{{apiUrl}}` instead of a hard-coded environment origin.
- Leave `apiUrl`, `apiKey`, `agent_id`, `agent_name`, and `tenant` empty or safely placeholder-based.
- Keep generated tokens runtime-only.
- Remove internal Postman workspace metadata.

The shared overview chooses the correct download through `sar_profile.postman_download`.

## Adding a new endpoint page

1. Add the functional Markdown under `_includes/ota-sar/endpoints/`.
2. Add a normal wrapper under `ota/endpoints/` with `sar_profile: sar`.
3. Add a partner wrapper under `ota-partner/endpoints/` with `sar_profile: sar_partner`.
4. Add navigation links from the shared include using the rendered `.html` target.
5. Use profile data for any environment or credential examples.
6. Run the build and validator from both entry pages.

The wrappers should contain routing metadata only. Do not paste the endpoint’s functional content into both trees.

## Validation model

Run:

```bash
ruby _scripts/test/verify_sar_profiles_test.rb
ruby _scripts/verify_sar_profiles.rb _site
```

The Minitest suite exercises missing files and anchors, broken links, normal-host leakage, populated credentials, JWT-like values, unresolved Liquid, unsafe placeholders, Postman variables, and changed shared downloads.

The rendered-site validator crawls both entry pages and follows reachable local references. For partner output it additionally checks:

- normal Test and Production hosts are absent;
- normal sensitive profile values are absent;
- credential-shaped literals and JWTs are absent;
- partner links do not cross into `/docs/ota/`;
- partner Postman variables are empty or placeholder-based;
- linked downloads are scanned, including the reviewed schema ZIP integrity check.

The validator reports only a category, file, and line number. Never add a suspected secret to test output or review notes.

## Common failures

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Changelog or endpoint link returns 404 | Link still targets `.md` | Change it to the rendered `.html` path. |
| Partner page shows a normal hostname | A shared example or replacement missed the profile path | Move the value into profile data or add the legacy replacement, then rerun the validator. |
| Partner page shows unresolved Liquid | Jekyll expression is missing a value or a literal Postman variable lacks a raw block | Fix the expression or protect the literal with `{% raw %}`. |
| Partner validator reports a populated variable | A partner Postman variable contains a real value | Empty it or use the approved placeholder. |
| Partner link opens the normal tree | A wrapper used a hard-coded `/docs/ota/` link | Use a relative link or `sar_profile.documentation_root`. |
| A new page is missing from one audience | Only one wrapper was added | Add matching normal and partner wrappers around one shared include. |

## Review and handoff

Before opening a PR, inspect both entry pages and one or two deep links, confirm the downloads load, compare functional content between profiles, and verify that repository-only guides do not appear under `_site`.

Use a focused conventional commit, for example:

```text
docs(ST-1807): update SAR documentation
```
