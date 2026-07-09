---
layout: go7
title: Seat Availability (SeatAvailability)
---

# Seat Availability

`POST` `https://api.go7.io/v21.3.5/SeatAvailability`

---

## Description

The Seat Availability API returns seat map details and seat-linked a la carte offers for a selected offer or an existing order. Use it to display available seats, seat characteristics, and seat-related offer items before a customer selects seats.

## Workflow (NDC API guide)

**Step 4 (Phase 2)** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/SeatAvailability` · optional Phase 2 seat map lookup, with the working sequence using **`OrderRequest`** and **`OrderID`** / **`OrderItemID`** / **`OwnerCode`** after **OrderCreate**. **`OfferRequest`** with **`OfferID`** / **`OfferItemID`** / **`OwnerCode`** remains documented as an alternate request shape. Scenarios: **`#seatavailability-by-offer`**, **`#seatavailability-by-order`**.

The response returns **`SeatMap`** plus an **`ALaCarteOffer`** containing seat offer items tied to passengers and segments.

See [Authentication](../NDC_API.md#http-headers) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Purpose | Format | Required | Example |
|--------|---------|--------|----------|---------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | Yes | `x-tenant: test-qa-rc` |
| `x-SalesChannel` | Specifies the sales channel (maps to account IDs per tenant configuration) | String (e.g., `NDC`, `IBE`) | Yes | `x-SalesChannel: NDC` |
| `x-api-key` | API key for authenticating the request | String | Yes | `x-api-key: {x-api-key}` |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

**Note:** The `x-SalesChannel` value is used to determine the account ID based on tenant configuration.

## Request Body

The request body must be a valid `IATA_SeatAvailabilityRQ` XML document following IATA NDC v21.3.5 standard.

Provide exactly one of **`OfferRequest`** or **`OrderRequest`** inside **`SeatAvailCoreRequest`**.

### SeatAvailability — By offer
{: #seatavailability-by-offer}

Use this mode when you already have an offer and need the seat map and seat offers for that selected offer item.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_SeatAvailabilityRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                         xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ123511&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;Request&gt;
        &lt;cns:SeatAvailCoreRequest xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
            &lt;cns:OfferRequest&gt;
                &lt;cns:Offer&gt;
                    &lt;cns:OfferID&gt;cec08afe-be28-4874-b06d-74399ce009ca&lt;/cns:OfferID&gt;
                    &lt;cns:OfferItem&gt;
                        &lt;cns:OfferItemID&gt;9b97f9fb-00a6-4b15-97d9-da2ae450e3c6&lt;/cns:OfferItemID&gt;
                    &lt;/cns:OfferItem&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                &lt;/cns:Offer&gt;
            &lt;/cns:OfferRequest&gt;
        &lt;/cns:SeatAvailCoreRequest&gt;
    &lt;/Request&gt;
&lt;/IATA_SeatAvailabilityRQ&gt;
</code></pre>

</details>

### SeatAvailability — By order
{: #seatavailability-by-order}

Use this mode for an existing booking when seat availability must be resolved against order items.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_SeatAvailabilityRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                         xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ123511&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;Request&gt;
        &lt;cns:SeatAvailCoreRequest xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
            &lt;cns:OrderRequest&gt;
                &lt;cns:Order&gt;
                    &lt;cns:OrderID&gt;ad525703-8c7a-4191-9105-255cb626b2ab&lt;/cns:OrderID&gt;
                    &lt;cns:OrderItem&gt;
                        &lt;cns:OrderItemID&gt;883dc9ce-5d84-4efe-9833-026dbec77ccb&lt;/cns:OrderItemID&gt;
                    &lt;/cns:OrderItem&gt;
                    &lt;cns:OrderItem&gt;
                        &lt;cns:OrderItemID&gt;5b0875dd-a083-43f0-9d97-f9a1a36ae484&lt;/cns:OrderItemID&gt;
                    &lt;/cns:OrderItem&gt;
                    &lt;cns:OrderItem&gt;
                        &lt;cns:OrderItemID&gt;bda051aa-d7f2-4d82-aa46-3708595bed7b&lt;/cns:OrderItemID&gt;
                    &lt;/cns:OrderItem&gt;
                    &lt;cns:OrderItem&gt;
                        &lt;cns:OrderItemID&gt;239f93d1-d56a-431b-93da-46e6ca669c87&lt;/cns:OrderItemID&gt;
                    &lt;/cns:OrderItem&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                &lt;/cns:Order&gt;
            &lt;/cns:OrderRequest&gt;
        &lt;/cns:SeatAvailCoreRequest&gt;
    &lt;/Request&gt;
&lt;/IATA_SeatAvailabilityRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_SeatAvailabilityRS` XML document containing `SeatMap`, `DataLists`, and an `ALaCarteOffer` for selectable seats. The example below reflects the offer-based fixture; order-based responses use the same NDC response shape.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_SeatAvailabilityRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;SeatMap&gt;
            &lt;CabinCompartment&gt;
                &lt;CabinType&gt;
                    &lt;CabinTypeCode&gt;Y&lt;/CabinTypeCode&gt;
                    &lt;CabinTypeName&gt;Economy&lt;/CabinTypeName&gt;
                &lt;/CabinType&gt;
                &lt;DeckCode&gt;MAIN&lt;/DeckCode&gt;
                &lt;FirstRowNumber&gt;1&lt;/FirstRowNumber&gt;
                &lt;LastRowNumber&gt;10&lt;/LastRowNumber&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;A&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;B&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;C&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;D&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;E&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatColumn&gt;
                    &lt;ColumnID&gt;F&lt;/ColumnID&gt;
                &lt;/SeatColumn&gt;
                &lt;SeatRow&gt;
                    &lt;RowNumber&gt;1&lt;/RowNumber&gt;
                    &lt;Seat&gt;
                        &lt;ColumnID&gt;A&lt;/ColumnID&gt;
                        &lt;RowNumber&gt;1&lt;/RowNumber&gt;
                        &lt;OccupationStatusCode&gt;F&lt;/OccupationStatusCode&gt;
                        &lt;OfferItemRefID&gt;7c9bad51-becb-434e-95ac-e12787899a40&lt;/OfferItemRefID&gt;
                    &lt;/Seat&gt;
                    &lt;Seat&gt;
                        &lt;ColumnID&gt;B&lt;/ColumnID&gt;
                        &lt;RowNumber&gt;1&lt;/RowNumber&gt;
                        &lt;OccupationStatusCode&gt;F&lt;/OccupationStatusCode&gt;
                        &lt;OfferItemRefID&gt;24df879c-a806-49ab-9d5c-44a20e969c4e&lt;/OfferItemRefID&gt;
                    &lt;/Seat&gt;
                    &lt;Seat&gt;
                        &lt;ColumnID&gt;C&lt;/ColumnID&gt;
                        &lt;RowNumber&gt;1&lt;/RowNumber&gt;
                        &lt;OccupationStatusCode&gt;F&lt;/OccupationStatusCode&gt;
                        &lt;OfferItemRefID&gt;936ce274-e5c4-4880-bd28-4f37a1be13ce&lt;/OfferItemRefID&gt;
                    &lt;/Seat&gt;
                    &lt;Seat&gt;
                        &lt;ColumnID&gt;D&lt;/ColumnID&gt;
                        &lt;RowNumber&gt;1&lt;/RowNumber&gt;
                        &lt;OccupationStatusCode&gt;F&lt;/OccupationStatusCode&gt;
                        &lt;OfferItemRefID&gt;b2c6587e-c5bb-4fca-a82f-0dce3b5a5e91&lt;/OfferItemRefID&gt;
                    &lt;/Seat&gt;
                &lt;/SeatRow&gt;
            &lt;/CabinCompartment&gt;
        &lt;/SeatMap&gt;
        &lt;DataLists&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-01-20T14:30:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;AAC&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-01-20T12:30:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;AAL&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                    &lt;MarketingCarrierFlightNumberText&gt;DX7879&lt;/MarketingCarrierFlightNumberText&gt;
                &lt;/DatedMarketingSegment&gt;
            &lt;/DatedMarketingSegmentList&gt;
            &lt;DatedOperatingSegmentList&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS1&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;DX7879&lt;/OperatingCarrierFlightNumberText&gt;
                &lt;/DatedOperatingSegment&gt;
            &lt;/DatedOperatingSegmentList&gt;
            &lt;OriginDestList&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;AAC&lt;/DestCode&gt;
                    &lt;OriginCode&gt;AAL&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                &lt;/OriginDest&gt;
            &lt;/OriginDestList&gt;
            &lt;PaxJourneyList&gt;
                &lt;PaxJourney&gt;
                    &lt;PaxJourneyID&gt;JOUR1&lt;/PaxJourneyID&gt;
                    &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                &lt;/PaxJourney&gt;
            &lt;/PaxJourneyList&gt;
            &lt;PaxList&gt;
                &lt;Pax&gt;
                    &lt;PaxID&gt;PAX1&lt;/PaxID&gt;
                    &lt;PTC&gt;ADT&lt;/PTC&gt;
                &lt;/Pax&gt;
            &lt;/PaxList&gt;
            &lt;PaxSegmentList&gt;
                &lt;PaxSegment&gt;
                    &lt;DatedMarketingSegmentRefId&gt;DMS1&lt;/DatedMarketingSegmentRefId&gt;
                    &lt;MarketingCarrierRBD_Code&gt;DX&lt;/MarketingCarrierRBD_Code&gt;
                    &lt;OperatingCarrierRBD_Code&gt;DX&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
            &lt;/PaxSegmentList&gt;
            &lt;ServiceDefinitionList&gt;
                &lt;ServiceDefinition&gt;
                    &lt;ServiceDefinitionID&gt;SD1&lt;/ServiceDefinitionID&gt;
                &lt;/ServiceDefinition&gt;
            &lt;/ServiceDefinitionList&gt;
        &lt;/DataLists&gt;
        &lt;ALaCarteOffer&gt;
            &lt;OfferID&gt;cec08afe-be28-4874-b06d-74399ce009ca&lt;/OfferID&gt;
            &lt;OfferItem&gt;
                &lt;Eligibility&gt;
                    &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
                    &lt;OfferFlightAssociations&gt;
                        &lt;PaxSegmentReferences&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentReferences&gt;
                    &lt;/OfferFlightAssociations&gt;
                &lt;/Eligibility&gt;
                &lt;OfferItemID&gt;7c9bad51-becb-434e-95ac-e12787899a40&lt;/OfferItemID&gt;
                &lt;Service&gt;
                    &lt;ServiceDefinitionRefID&gt;SD1&lt;/ServiceDefinitionRefID&gt;
                    &lt;ServiceID&gt;SV1&lt;/ServiceID&gt;
                &lt;/Service&gt;
                &lt;UnitPrice&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;4.0&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                &lt;/UnitPrice&gt;
            &lt;/OfferItem&gt;
            &lt;OfferItem&gt;
                &lt;Eligibility&gt;
                    &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
                    &lt;OfferFlightAssociations&gt;
                        &lt;PaxSegmentReferences&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentReferences&gt;
                    &lt;/OfferFlightAssociations&gt;
                &lt;/Eligibility&gt;
                &lt;OfferItemID&gt;24df879c-a806-49ab-9d5c-44a20e969c4e&lt;/OfferItemID&gt;
                &lt;Service&gt;
                    &lt;ServiceDefinitionRefID&gt;SD1&lt;/ServiceDefinitionRefID&gt;
                    &lt;ServiceID&gt;SV1&lt;/ServiceID&gt;
                &lt;/Service&gt;
                &lt;UnitPrice&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;1.12&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                &lt;/UnitPrice&gt;
            &lt;/OfferItem&gt;
            &lt;OfferExpirationTimeLimitDateTime&gt;2025-12-31T20:11:17.102051114Z&lt;/OfferExpirationTimeLimitDateTime&gt;
        &lt;/ALaCarteOffer&gt;
    &lt;/ns2:Response&gt;
&lt;/ns2:IATA_SeatAvailabilityRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;ErrorResponse&gt;
    &lt;Error&gt;
        &lt;Code&gt;400&lt;/Code&gt;
        &lt;Message&gt;Bad Request - Invalid request format or missing required fields&lt;/Message&gt;
        &lt;Details&gt;Request validation failed: Missing required field 'Request.SeatAvailCoreRequest'&lt;/Details&gt;
    &lt;/Error&gt;
&lt;/ErrorResponse&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/SeatAvailability \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @seatavailability-request-offer.xml
    ```

## Notes

1. `SeatAvailCoreRequest` must contain either `OfferRequest` or `OrderRequest`.
2. Offer-based lookups use `OfferID` plus one or more `OfferItemID` values from the upstream offer context. This request can only be used to get information about the offer.
3. Order-based lookups use `OrderID` and one or more `OrderItemID` values from the existing booking.
4. The gateway maps the backend seat response into both `SeatMap` and `ALaCarteOffer`, so the seat offer items referenced in the map are also available as offer items in the response.
