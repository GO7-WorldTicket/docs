---
published: false
---

# SAR Documentation Guide

This is the team entry point for maintaining the normal SAR documentation and the SAR Partner documentation. It is repository-only documentation and is intentionally excluded from the public GitHub Pages output.

Choose the guide that matches the work you need to do:

- [SAR update checklist](docs/sar-maintenance/SAR_UPDATE_CHECKLIST.md) — the short, repeatable steps for making and verifying a change.
- [SAR onboarding guide](docs/sar-maintenance/SAR_ONBOARDING_GUIDE.md) — the full explanation of profiles, wrappers, shared includes, Liquid variables, Postman collections, links, and validation.

The most important maintenance rule is simple: functional SAR documentation belongs in `_includes/ota-sar/`, audience-specific values belong in `_data/sar_profiles.yml`, and both rendered trees must be checked before opening a PR.
