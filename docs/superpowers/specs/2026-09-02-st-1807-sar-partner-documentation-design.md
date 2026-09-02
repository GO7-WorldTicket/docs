# ST-1807: SAR Partner Documentation Design

## Summary

Publish two complete SAR API documentation versions through the repository's existing GitHub Pages build:

- The normal SAR version keeps its current URLs and displays the existing Test and Production environment information.
- The SAR Partner version is published under a separate URL tree and replaces environment-specific hosts and credential values with readable placeholders.

Both versions must preserve the same functional API content. The implementation must use Jekyll's existing Markdown, front matter, data, and include capabilities. It must not introduce a custom generator, GitHub Actions workflow, new hosting platform, or DevOps-managed deployment.

## Context

The current SAR entry page links to endpoint documentation, changelog content, diagrams, schemas, and a downloadable Postman collection. Creating only a second entry page would be insufficient because partner readers could follow links into the normal SAR tree or download assets containing normal environment values.

The partner version must therefore be a complete, internally consistent documentation tree. API route paths remain visible because partners need them to understand the integration. Only environment-specific origins and credential values are replaced.

Both rendered versions will remain publicly reachable on the same GitHub Pages site. The normal SAR URL will not be shared with partners, but this is URL obscurity rather than access control. The business accepts that limitation for ST-1807.

## Goals

- Keep the current normal SAR URLs and rendered content behavior.
- Add a publicly accessible SAR Partner URL tree.
- Maintain functional documentation content in one shared source.
- Preserve API methods, route paths, headers, parameters, schemas, request examples, response examples, and workflow explanations in both versions.
- Ensure every partner navigation link stays inside the partner tree.
- Hide normal environment base URLs and credential values from partner pages and partner downloads.
- Keep the existing GitHub Pages build and deployment process unchanged.

## Non-goals

- Making the normal SAR version private or access-controlled.
- Changing API behavior, routes, authentication, or onboarding procedures.
- Adding a custom site generator, CI workflow, publication gate, or separate deployment.
- Automatically detecting every possible secret during future GitHub Pages builds.
- Rewriting ordinary example business data unless review shows that it contains real customer or production information.

## Considered Approaches

### 1. Shared Jekyll content with two thin page trees

This is the selected approach. Functional content lives in Jekyll includes. Thin pages under the normal and partner URL trees select a rendering profile through front matter. Jekyll renders both as part of its existing GitHub Pages build.

This keeps content synchronized without changing the deployment process. It requires a small wrapper for each navigable page, but those wrappers contain routing metadata rather than duplicated API documentation.

### 2. Generate a sanitized copy from the normal files

This would reduce the initial content restructure, but it would require a custom transformation step. Replacement rules could also miss a new hostname or change unrelated text. It conflicts with the requirement to avoid build and DevOps complexity.

### 3. Maintain two complete Markdown copies

This preserves the current build process but duplicates all content. Normal and partner documentation would drift unless every API change were applied twice. It also increases the chance of copying a sensitive value into the partner tree. This approach is rejected.

## Architecture

### Shared content

The shared functional documents live under Jekyll's non-published include directory:

```text
_includes/ota-sar/
  overview.md
  changelog.md
  endpoints/
    available_routes_and_flights.md
    cancel_booking.md
    create_booking.md
    download_tickets.md
    error-response.md
    low_fare_search.md
    modify-booking.md
    payment_and_ticketing.md
    read_booking.md
    resend_cancellation_email.md
    resend_ticket_confirmation_email.md
    seat_map.md
  shared/
    authentication.md
    error-handling.md
```

The final inventory must follow the local links reachable from `OTA_API_SAR.md`. The names above describe the known core pages and are not permission to omit another reachable Markdown page or downloadable asset.

Shared content references profile values for environment-specific origins and documentation roots. It must not hard-code a normal environment hostname in text that is rendered for both audiences.

### Profile data

Jekyll data defines two content profiles:

```text
_data/sar_profiles.yml
  sar
  sar_partner
```

The normal profile supplies the existing displayed environment URLs and the `/ota` documentation root. The partner profile supplies readable placeholders and the `/ota-partner` documentation root.

The profile is a content-rendering value only. It is not a Maven or Spring profile, deployment environment, GitHub Actions job, or separately hosted site.

### Rendered page trees

The normal wrapper pages stay under the current tree:

```text
ota/
  OTA_API_SAR.md
  changelog.md
  endpoints/...
```

Each normal wrapper selects `sar` in its front matter and includes the matching shared document.
Wrapper filenames and anchors preserve the current SAR paths so existing normal links and bookmarks continue to resolve.

The partner wrappers mirror the navigable structure:

```text
ota-partner/
  OTA_API_SAR.md
  changelog.md
  endpoints/...
```

Each partner wrapper selects `sar_partner` and includes the same shared document. The rendered partner entry URL is `/docs/ota-partner/OTA_API_SAR.html` under the current GitHub Pages base URL.

### Shared and profile-specific assets

Non-sensitive images and schemas remain shared when their content is identical and contains no environment or credential information.

The Postman collection has two committed outputs:

- The current normal collection retains the normal SAR configuration behavior.
- A partner collection preserves folders, requests, methods, route paths, headers, bodies, tests, and variable names but leaves environment URLs and credentials as placeholders or empty values.

Each documentation profile links only to its corresponding collection. If review finds another downloadable file with profile-sensitive content, it must also receive separate normal and partner variants.

## Rendering Rules

### Environment URLs

Normal output displays the existing Test and Production environment URLs. Partner output uses descriptive placeholders such as:

```text
{base_url}/ota/v2015b/OTA
{auth_base_url}/realms/{tenant}/protocol/openid-connect/token
{service_base_url}/tickets/confirmation/{booking_reference}/download
```

The placeholder replaces only the environment-specific origin. API paths and query parameter structures remain visible.

### Credentials and tokens

Partner content must never contain populated values for API keys, client secrets, usernames, passwords, access tokens, refresh tokens, or similar authentication material. It retains the header names, authentication flow, and descriptive placeholders required to understand integration.

### Links

Internal links derive from the selected documentation root. A partner page must not link to a normal SAR page. Anchors, images, schema downloads, and collection downloads must resolve from both output trees.

External standards or reference links that are intentionally public remain real links. Placeholders are used in examples and configuration tables, not as clickable links to nonexistent hosts.

### Partner notice

The partner entry page contains a concise notice that environment URLs and credentials are supplied separately after access approval. The notice must not imply that the placeholders are live endpoints.

## Authoring and Maintenance

Contributors edit the shared include when API behavior or documentation changes. They do not copy the functional change into two full documents.

Adding a new navigable SAR page requires:

1. One shared content file.
2. One thin normal wrapper.
3. One thin partner wrapper.
4. Profile-aware navigation links from both trees.
5. Verification of any new downloadable asset.

Audience-specific conditional content should be limited to environment display, credential display, download selection, routing, and the partner onboarding notice. Functional API explanations should remain shared.

The normal and partner Postman collections must be reviewed together whenever collection functionality changes.

## Error Handling

Jekyll rendering must fail visibly during local verification if a wrapper references a missing include or invalid data. Before review, the implementation must also detect:

- Missing required profile values.
- Unresolved Jekyll or Liquid expressions in either rendered tree.
- Partner placeholder names outside the approved placeholder vocabulary.
- Normal environment hostnames in rendered partner HTML.
- Populated credential values in partner HTML or the partner Postman collection.
- Partner links that cross into the normal `/ota/` tree.
- Missing pages, anchors, images, schemas, or downloads.

A suspected sensitive value must be reported by file and location without printing the value in shared logs or review notes.

Because ST-1807 does not change CI, these checks run locally during implementation and review. Future automatic publication enforcement is outside this ticket.

## Verification

### Build verification

- Run the repository's existing Jekyll build without changing its publication configuration.
- Confirm that both normal and partner HTML trees are produced.
- Confirm the current normal SAR entry path remains unchanged.
- Confirm the partner entry path is generated under `/ota-partner`.

### Navigation verification

- Check every local link and anchor reachable from each entry page.
- Confirm partner links never resolve into the normal SAR tree.
- Confirm images, schemas, and profile-specific Postman downloads resolve.

### Content parity verification

Compare the two rendered versions after normalizing profile-specific values. Both must retain equivalent:

- Headings and workflows.
- HTTP methods and API paths.
- Headers and parameters.
- Request and response structures.
- Examples and error descriptions.

Expected differences are limited to profile-specific URLs, credential presentation, download selection, documentation routing, and the partner notice.

### Partner safety verification

- Scan rendered partner HTML, not only Markdown source.
- Scan the partner Postman collection and any other partner download.
- Confirm normal Test and Production environment origins do not appear.
- Confirm no populated API key, secret, password, or token appears.
- Review representative partner pages visually for clarity and readable placeholder usage.

## Acceptance Criteria

- Both SAR and SAR Partner versions are publicly accessible through the existing GitHub Pages deployment.
- The current normal SAR URL and its visible environment behavior remain intact.
- The partner version has a distinct `/ota-partner` URL tree.
- Both versions render from shared functional content.
- The partner version preserves API paths and complete integration explanations.
- The partner tree and its downloads contain placeholders instead of normal environment hosts and credential values.
- All links, anchors, images, schemas, and downloads reachable from both entry pages work.
- The existing GitHub Pages build and deployment process is unchanged.
- No custom generator, CI workflow, new hosting, or DevOps work is introduced.
