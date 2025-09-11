Here is Claude's plan:                                                     │
│ ╭────────────────────────────────────────────────────────────────────────╮ │
│ │ Implementation Plan: Approach 1 - Parallel Generic Structure           │ │
│ │                                                                        │ │
│ │ Phase 1: Directory Structure Creation                                  │ │
│ │                                                                        │ │
│ │ New Structure (Non-disruptive)                                         │ │
│ │                                                                        │ │
│ │ ota/                                                                   │ │
│ │ ├── OTA_API_SAR.md           # Existing (unchanged)                    │ │
│ │ ├── OTA_API_Generic.md       # NEW: Main generic documentation         │ │
│ │ ├── changelog.md             # Existing SAR changelog (unchanged)      │ │
│ │ ├── generic-changelog.md     # NEW: Generic version changelog          │ │
│ │ ├── endpoints/               # Existing SAR endpoints (unchanged)      │ │
│ │ │   ├── available_routes_and_flights.md                                │ │
│ │ │   ├── cancel_booking.md                                              │ │
│ │ │   ├── create_booking.md                                              │ │
│ │ │   ├── download_tickets.md                                            │ │
│ │ │   ├── error-response.md                                              │ │
│ │ │   ├── low_fare_search.md                                             │ │
│ │ │   ├── modify-booking.md                                              │ │
│ │ │   ├── payment_and_ticketing.md                                       │ │
│ │ │   ├── read_booking.md                                                │ │
│ │ │   ├── resend_cancellation_email.md                                   │ │
│ │ │   ├── resend_ticket_confirmation_email.md                            │ │
│ │ │   └── segments_cancellation.md                                       │ │
│ │ └── generic/                 # NEW: Generic endpoints directory        │ │
│ │     ├── authentication.md                                              │ │
│ │     ├── flight-availability.md                                         │ │
│ │     ├── flight-search.md                                               │ │
│ │     ├── booking-regular.md                                             │ │
│ │     ├── booking-group.md                                               │ │
│ │     ├── payment-ticketing.md                                           │ │
│ │     ├── booking-modification.md                                        │ │
│ │     ├── booking-cancellation.md                                        │ │
│ │     ├── refund-process.md                                              │ │
│ │     └── error-handling.md                                              │ │
│ │                                                                        │ │
│ │ Phase 2: Content Creation from PDF Source                              │ │
│ │                                                                        │ │
│ │ Main Generic Documentation (OTA_API_Generic.md)                        │ │
│ │                                                                        │ │
│ │ - Header: Jekyll frontmatter with layout: default                      │ │
│ │ - Title: "OTA API Generic Integration Guide"                           │ │
│ │ - Table of Contents: Links to all generic endpoints                    │ │
│ │ - Introduction: Generic OTA API integration overview                   │ │
│ │ - Endpoints Tables: Test and production URL templates                  │ │
│ │ - Authentication Overview: JWT and API Key methods                     │ │
│ │ - Business Flow: Generic workflow diagrams                             │ │
│ │ - Code Lists: Generic booking classes, passenger types, document types │ │
│ │ - Change Log Table: Link to generic-changelog.md                       │ │
│ │                                                                        │ │
│ │ Generic Endpoint Files (10 files)                                      │ │
│ │                                                                        │ │
│ │ 1. authentication.md                                                   │ │
│ │   - PDF Section 2: Authentication (JWT + API Key)                      │ │
│ │   - Generic credential examples                                        │ │
│ │   - Token refresh workflows                                            │ │
│ │ 2. flight-availability.md                                              │ │
│ │   - PDF Section 3: Available Routes and Flights                        │ │
│ │   - Routes API, Calendar availability, AirAvail RQ/RS                  │ │
│ │   - Generic examples without airline-specific data                     │ │
│ │ 3. flight-search.md                                                    │ │
│ │   - PDF Section 4: Low Fare Search (AirLowFareSearchRQ)                │ │
│ │   - One-way, round-trip, with/without booking class                    │ │
│ │   - Discount functionality, generic examples                           │ │
│ │ 4. booking-regular.md                                                  │ │
│ │   - PDF Section 6.1: Create regular booking (AirBookRQ)                │ │
│ │   - Generic passenger details, SSR examples                            │ │
│ │   - Response format with generic data                                  │ │
│ │ 5. booking-group.md                                                    │ │
│ │   - PDF Section 6.2: Create group booking (AirPriceRQ)                 │ │
│ │   - Group booking workflow and completion policy                       │ │
│ │   - Generic contact details format                                     │ │
│ │ 6. payment-ticketing.md                                                │ │
│ │   - PDF Section 7: Payment and Ticketing                               │ │
│ │   - All payment types (External, Credit card, Cash, Debit-credit,      │ │
│ │ Invoice)                                                               │ │
│ │   - Redirect payment flows, EMD issuance                               │ │
│ │   - Currency conversion                                                │ │
│ │ 7. booking-modification.md                                             │ │
│ │   - PDF Section 9: Modify Booking (AirBookModifyRQ)                    │ │
│ │   - Add SSR, change name, change date                                  │ │
│ │   - Cancel segments/passengers                                         │ │
│ │   - Generic modification examples                                      │ │
│ │ 8. booking-cancellation.md                                             │ │
│ │   - PDF Section 10: Cancel RQ                                          │ │
│ │   - Full booking cancellation                                          │ │
│ │   - Generic cancellation policies                                      │ │
│ │ 9. refund-process.md                                                   │ │
│ │   - PDF Section 13: Refund via Refund Queue µService                   │ │
│ │   - Refund request APIs                                                │ │
│ │   - Generic refund reasons and workflows                               │ │
│ │ 10. error-handling.md                                                  │ │
│ │   - Generic error response patterns from PDF                           │ │
│ │   - Common error codes and handling                                    │ │
│ │                                                                        │ │
│ │ Generic Changelog (generic-changelog.md)                               │ │
│ │                                                                        │ │
│ │ - Initial creation entry                                               │ │
│ │ - Future generic OTA updates tracking                                  │ │
│ │ - Format matching existing changelog.md structure                      │ │
│ │                                                                        │ │
│ │ Phase 3: Content Processing Strategy                                   │ │
│ │                                                                        │ │
│ │ From PDF to Markdown Conversion                                        │ │
│ │                                                                        │ │
│ │ - Remove airline-specific references: Replace with {airline-code},     │ │
│ │ {tenant}                                                               │ │
│ │ - Genericize URLs: Use {base_url}, {test-base-url} placeholders        │ │
│ │ - Code examples: Convert to generic format with placeholder values     │ │
│ │ - Maintain structure: Follow existing SAR endpoint format for          │ │
│ │ consistency                                                            │ │
│ │ - Include both formats: XML and JSON examples per PDF content          │ │
│ │ - Preserve diagrams: Business flows and sequence diagrams              │ │
│ │                                                                        │ │
│ │ Jekyll Compatibility                                                   │ │
│ │                                                                        │ │
│ │ - Frontmatter: layout: default for all files                           │ │
│ │ - Links: Relative paths for images ../images/                          │ │
│ │ - Navigation: Internal links using markdown format                     │ │
│ │ - CSS classes: Use existing stylesheet classes                         │ │
│ │                                                                        │ │
│ │ Phase 4: File Creation Operations                                      │ │
│ │                                                                        │ │
│ │ New Files to Create (12 total)                                         │ │
│ │                                                                        │ │
│ │ 1. ota/OTA_API_Generic.md - Main documentation                         │ │
│ │ 2. ota/generic-changelog.md - Generic changelog                        │ │
│ │ 3. ota/generic/authentication.md                                       │ │
│ │ 4. ota/generic/flight-availability.md                                  │ │
│ │ 5. ota/generic/flight-search.md                                        │ │
│ │ 6. ota/generic/booking-regular.md                                      │ │
│ │ 7. ota/generic/booking-group.md                                        │ │
│ │ 8. ota/generic/payment-ticketing.md                                    │ │
│ │ 9. ota/generic/booking-modification.md                                 │ │
│ │ 10. ota/generic/booking-cancellation.md                                │ │
│ │ 11. ota/generic/refund-process.md                                      │ │
│ │ 12. ota/generic/error-handling.md                                      │ │
│ │                                                                        │ │
│ │ No Existing Files Modified                                             │ │
│ │                                                                        │ │
│ │ - All existing SAR documentation remains untouched                     │ │
│ │ - Zero risk of breaking existing links or functionality                │ │
│ │ - Existing Jekyll build process unaffected                             │ │
│ │                                                                        │ │
│ │ Phase 5: Quality Assurance                                             │ │
│ │                                                                        │ │
│ │ Testing Checklist                                                      │ │
│ │                                                                        │ │
│ │ - Jekyll builds successfully with new files                            │ │
│ │ - All internal links resolve correctly                                 │ │
│ │ - Generic documentation renders properly                               │ │
│ │ - Images and assets load correctly                                     │ │
│ │ - Table of contents navigation works                                   │ │
│ │ - Cross-references between generic files function                      │ │
│ │                                                                        │ │
│ │ Content Validation                                                     │ │
│ │                                                                        │ │
│ │ - All PDF sections mapped to markdown files                            │ │
│ │ - Generic examples don't contain airline-specific data                 │ │
│ │ - Code examples are syntactically correct                              │ │
│ │ - Business flows are accurately represented                            │ │
│ │ - Error handling coverage is comprehensive                             │ │
│ │                                                                        │ │
│ │ Benefits of This Approach                                              │ │
│ │                                                                        │ │
│ │ - Zero Risk: No existing files modified                                │ │
│ │ - Independent Evolution: Generic docs can be updated separately        │ │
│ │ - Clear Separation: Obvious distinction between SAR and generic        │ │
│ │ - Scalable: Easy to add more airline-specific variants in future       │ │
│ │ - Maintainable: No complex link management between variants            │ │
│ │                                                                        │ │
│ │ Expected Timeline                                                      │ │
│ │                                                                        │ │
│ │ - Phase 1-2: Directory and main file creation (30 minutes)             │ │
│ │ - Phase 3: Content extraction and conversion (2-3 hours)               │ │
│ │ - Phase 4: Individual endpoint file creation (2-3 hours)               │ │
│ │ - Phase 5: Testing and validation (30 minutes)                         │ │
│ │                                                                        │ │
│ │ Total Estimated Time: 5-7 hours                                        │ │
│ ╰────────────────────────────────────────────────────────────────────────╯ │
│                                             