---
sar_profile: sar_partner
---
{% assign sar_profile = site.data.sar_profiles[page.sar_profile] %}
{% include ota-sar/endpoints/resend_ticket_confirmation_email.md %}
