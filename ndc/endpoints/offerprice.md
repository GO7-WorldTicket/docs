---
layout: go7
title: Offer Price (OfferPrice)
---

# Offer Price

`POST` `https://api.go7.io/v21.3.5/OfferPrice`

---

## Description

The Offer Price API returns detailed pricing for selected offers. In Phase 1 it prices a flight offer from **AirShopping**. In Phase 2 (pre-order) it can also combine that flight offer with selected **ServiceList** ancillaries and/or **SeatAvailability** seats into one `PricedOffer` with a **combined total**.

Use `OfferRefID` / `OfferItemRefID` from **AirShoppingRS**, and — when adding extras — from **ServiceListRS** and/or **SeatAvailabilityRS**. The priced offer feeds **[Order Create](ordercreate.md)**.

## Workflow (NDC API guide)

**Step 2** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OfferPrice`.

- **Phase 1:** flight-only pricing after **AirShopping** → **OrderCreate**.
- **Phase 2 (by offer):** after **[ServiceList](servicelist.md)** and/or **[SeatAvailability](seatavailability.md)**, call **OfferPrice** again with flight + selected service and/or seat → **OrderCreate**.

Scenarios: **[`#offerprice-one-way-trip`](#offerprice-one-way-trip)**, **[`#offerprice-round-trip`](#offerprice-round-trip)**, **[`#offerprice-with-service`](#offerprice-with-service)**, **[`#offerprice-with-seat`](#offerprice-with-seat)**.

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

The request body must be a valid `IATA_OfferPriceRQ` XML document following IATA NDC v21.3.5 standard.

`Request/PricedOffer/SelectedOfferList` contains one or more **`SelectedOffer`** blocks. The gateway classifies each block by the child marker on its `SelectedOfferItem` elements (same pattern as **OrderCreate** / **OrderChange**):

| Item type | XML marker in `SelectedOfferItem` | `OfferRefID` source |
|-----------|-----------------------------------|---------------------|
| Flight | No a-la-carte / seat marker | **AirShoppingRS** |
| Service / SSR | `SelectedALaCarteOfferItem` (+ `Qty`) | **ServiceListRS** |
| Seat | `SelectedSeat` (`ColumnID`, `SeatRowNumber`) | **SeatAvailabilityRS** |

Rules:

- Exactly **one** flight `SelectedOffer` is required when combining with services or seats.
- Service `Qty` must be **1** (omit → treated as 1; `Qty ≠ 1` → `INVALID_VALUE` / 12). Seats have **no** `Qty`.
- Combined pricing (service / seat) is dark-launched per tenant (`service-enabled` / `seat-enabled`). When a category is disabled for the tenant, those selections are ignored and the gateway falls back to flight-only pricing.

### OfferPrice — One-way trip
{: #offerprice-one-way-trip}

One **`SelectedOffer`** with typically **one `SelectedOfferItem`** per passenger when the shopping offer contained a single outbound slice (adjust **`PaxRefID`** to match shopping).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;IATA_OfferPriceRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;
                   xmlns:cns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;ASR-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:Timestamp&gt;2025-11-05T10:00:00Z&lt;/cns:Timestamp&gt;
        &lt;cns:TrxID&gt;TRX-123456789&lt;/cns:TrxID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:PricedOffer&gt;
            &lt;cns:SelectedOfferList&gt;
                &lt;cns:SelectedOffer&gt;
                    &lt;cns:OfferRefID&gt;9292c7a4-a0d6-4f30-befa-2c197def7ac9&lt;/cns:OfferRefID&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;982ec9bd-bcff-452d-a1e4-c1d4ba131eb8:46cd5362-2582-42bb-82e1-3fb260f1ac85&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;ADT1&lt;/cns:PaxRefID&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;3cbc88b1-ab28-45c7-a4bf-6a52a2153c48:12b9a65a-35d3-4a3f-93d2-5160ffc16eca&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;CHD1&lt;/cns:PaxRefID&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;4e6be961-b8c4-4cec-8f9c-1d586e22f87f:b1226bf0-5901-4f48-977f-34089fbcec91&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;INF1&lt;/cns:PaxRefID&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                &lt;/cns:SelectedOffer&gt;
            &lt;/cns:SelectedOfferList&gt;
        &lt;/cns:PricedOffer&gt;
    &lt;/Request&gt;
&lt;/IATA_OfferPriceRQ&gt;
</code></pre>

</details>

### OfferPrice — Round trip
{: #offerprice-round-trip}

Same **`OfferRefID`** when both directions sit under one offer; **two `SelectedOfferItem`** rows (IDs from **AirShoppingRS**).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;IATA_OfferPriceRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;DistributionChainLink xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;Ordinal&gt;1&lt;/Ordinal&gt;
            &lt;OrgRole&gt;Seller&lt;/OrgRole&gt;
            &lt;ParticipatingOrg&gt;
                &lt;Name&gt;Travel Agency XYZ&lt;/Name&gt;
                &lt;OrgID&gt;SELLER123&lt;/OrgID&gt;
            &lt;/ParticipatingOrg&gt;
        &lt;/DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;CorrelationID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;{{$randomUUID}}&lt;/CorrelationID&gt;
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2026-05-07T18:34:11.567+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;PricedOffer xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;SelectedOfferList&gt;
                &lt;SelectedOffer&gt;
                    &lt;OfferRefID&gt;0d8ef628-02f3-4f3b-ba6b-d6bbf8e661d1&lt;/OfferRefID&gt;
                    &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
                    &lt;SelectedOfferItem&gt;
                        &lt;OfferItemRefID&gt;a3db17db-e4d7-4d30-95ce-8f634d16bafc:af9c85a0-e93b-4f2c-91b2-eb7d7e7d1e48&lt;/OfferItemRefID&gt;
                        &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                    &lt;/SelectedOfferItem&gt;
                    &lt;SelectedOfferItem&gt;
                        &lt;OfferItemRefID&gt;19fff8c1-ad9f-4a23-ad4a-fd434356350e:e7756a5a-7194-4c7e-a0ec-28da794e8562&lt;/OfferItemRefID&gt;
                        &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                    &lt;/SelectedOfferItem&gt;
                &lt;/SelectedOffer&gt;
            &lt;/SelectedOfferList&gt;
        &lt;/PricedOffer&gt;
    &lt;/Request&gt;
&lt;/IATA_OfferPriceRQ&gt;
</code></pre>

</details>

Round-trip **responses** match the one-way shape but include **two** flight `OfferItem` blocks (taxes/fees per carrier rules).

### OfferPrice — With selected service
{: #offerprice-with-service}

**Phase 2 (by offer):** after **[ServiceList](servicelist.md#servicelist-by-offer)**, send the flight `SelectedOffer` plus a service `SelectedOffer` whose items include **`SelectedALaCarteOfferItem`**. `OfferRefID` / `OfferItemRefID` for the service block come from **ServiceListRS** `ALaCarteOffer`.

You may also add seat selections in the same request (see [with selected seat](#offerprice-with-seat)).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;IATA_OfferPriceRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;
                   xmlns:cns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;OP-SVC-001&lt;/cns:CorrelationID&gt;
        &lt;cns:Timestamp&gt;2026-07-21T10:00:00Z&lt;/cns:Timestamp&gt;
        &lt;cns:TrxID&gt;TRX-123456789&lt;/cns:TrxID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:PricedOffer&gt;
            &lt;cns:SelectedOfferList&gt;
                &lt;!-- Flight offer from AirShoppingRS / prior OfferPriceRS --&gt;
                &lt;cns:SelectedOffer&gt;
                    &lt;cns:OfferRefID&gt;444d338d-6a9c-481a-8cac-2ee69a6d2078&lt;/cns:OfferRefID&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;4dc81ae7-3460-490b-a758-38ec7b68e778:9aa5f349-24b9-4589-b2ed-87055c508bcc&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;PAX1&lt;/cns:PaxRefID&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                &lt;/cns:SelectedOffer&gt;
                &lt;!-- Service / SSR offer from ServiceListRS --&gt;
                &lt;cns:SelectedOffer&gt;
                    &lt;cns:OfferRefID&gt;8016be2c-8134-48ba-876e-b27e801d0bfa&lt;/cns:OfferRefID&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;45733be7-4459-40b2-8e46-d20c483a0c82&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;PAX1&lt;/cns:PaxRefID&gt;
                        &lt;cns:SelectedALaCarteOfferItem&gt;
                            &lt;cns:Qty&gt;1&lt;/cns:Qty&gt;
                        &lt;/cns:SelectedALaCarteOfferItem&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                &lt;/cns:SelectedOffer&gt;
            &lt;/cns:SelectedOfferList&gt;
        &lt;/cns:PricedOffer&gt;
    &lt;/Request&gt;
&lt;/IATA_OfferPriceRQ&gt;
</code></pre>

</details>

### OfferPrice — With selected seat
{: #offerprice-with-seat}

**Phase 2 (by offer):** after **[SeatAvailability](seatavailability.md#seatavailability-by-offer)**, send the flight `SelectedOffer` plus a seat `SelectedOffer` whose items include **`SelectedSeat`** (`ColumnID`, `SeatRowNumber`). `OfferRefID` / `OfferItemRefID` for the seat block come from **SeatAvailabilityRS** `ALaCarteOffer`.

Use one `SelectedOfferItem` + `SelectedSeat` per physical seat / passenger. You may also add service selections in the same request (see [with selected service](#offerprice-with-service)).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;IATA_OfferPriceRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;
                   xmlns:cns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;OP-SEAT-001&lt;/cns:CorrelationID&gt;
        &lt;cns:Timestamp&gt;2026-07-21T10:00:00Z&lt;/cns:Timestamp&gt;
        &lt;cns:TrxID&gt;TRX-123456789&lt;/cns:TrxID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:PricedOffer&gt;
            &lt;cns:SelectedOfferList&gt;
                &lt;!-- Flight offer from AirShoppingRS / prior OfferPriceRS --&gt;
                &lt;cns:SelectedOffer&gt;
                    &lt;cns:OfferRefID&gt;444d338d-6a9c-481a-8cac-2ee69a6d2078&lt;/cns:OfferRefID&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;4dc81ae7-3460-490b-a758-38ec7b68e778:9aa5f349-24b9-4589-b2ed-87055c508bcc&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;PAX1&lt;/cns:PaxRefID&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                &lt;/cns:SelectedOffer&gt;
                &lt;!-- Seat offer from SeatAvailabilityRS --&gt;
                &lt;cns:SelectedOffer&gt;
                    &lt;cns:OfferRefID&gt;413bcc35-0ffd-4716-8095-0f1b35567aa4&lt;/cns:OfferRefID&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                    &lt;cns:SelectedOfferItem&gt;
                        &lt;cns:OfferItemRefID&gt;14a19143-8acc-483d-a9b9-e38794a7ea19&lt;/cns:OfferItemRefID&gt;
                        &lt;cns:PaxRefID&gt;PAX1&lt;/cns:PaxRefID&gt;
                        &lt;cns:SelectedSeat&gt;
                            &lt;cns:ColumnID&gt;A&lt;/cns:ColumnID&gt;
                            &lt;cns:SeatRowNumber&gt;5&lt;/cns:SeatRowNumber&gt;
                        &lt;/cns:SelectedSeat&gt;
                    &lt;/cns:SelectedOfferItem&gt;
                &lt;/cns:SelectedOffer&gt;
            &lt;/cns:SelectedOfferList&gt;
        &lt;/cns:PricedOffer&gt;
    &lt;/Request&gt;
&lt;/IATA_OfferPriceRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OfferPriceRS` XML document.

- **Flight-only:** `PricedOffer` contains flight `OfferItem` rows and flight `TotalPrice` (example below).
- **Combined (service and/or seat):** flight items are kept; selected service and seat items are appended; **`PricedOffer.TotalPrice`** is the sum of flight + selected extras. Seat location is echoed on the seat item as **`Desc` / `DescText`** (for example `5A`) — `NewOfferItemType` has no `SelectedSeat` element. Zero-price (free) seats or services still appear as line items; the total may match flight-only.

<details>
<summary>Response Payload (flight-only example)</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OfferPriceRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;DataLists&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-17T12:20:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;CUR&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-17T05:25:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;BOS&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                    &lt;MarketingCarrierFlightNumberText&gt;W29896&lt;/MarketingCarrierFlightNumberText&gt;
                &lt;/DatedMarketingSegment&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-23T19:45:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;BOS&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS2&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS2&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-23T12:50:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;CUR&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                    &lt;MarketingCarrierFlightNumberText&gt;W29897&lt;/MarketingCarrierFlightNumberText&gt;
                &lt;/DatedMarketingSegment&gt;
            &lt;/DatedMarketingSegmentList&gt;
            &lt;DatedOperatingSegmentList&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS1&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;W29896&lt;/OperatingCarrierFlightNumberText&gt;
                &lt;/DatedOperatingSegment&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS2&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;W29897&lt;/OperatingCarrierFlightNumberText&gt;
                &lt;/DatedOperatingSegment&gt;
            &lt;/DatedOperatingSegmentList&gt;
            &lt;OriginDestList&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;CUR&lt;/DestCode&gt;
                    &lt;OriginCode&gt;BOS&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                &lt;/OriginDest&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;BOS&lt;/DestCode&gt;
                    &lt;OriginCode&gt;CUR&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;OD2&lt;/OriginDestID&gt;
                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                &lt;/OriginDest&gt;
            &lt;/OriginDestList&gt;
            &lt;PaxJourneyList&gt;
                &lt;PaxJourney&gt;
                    &lt;Duration&gt;PT6H55M&lt;/Duration&gt;
                    &lt;PaxJourneyID&gt;JOUR1&lt;/PaxJourneyID&gt;
                    &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                    &lt;PaxSegmentRefID&gt;SEG2&lt;/PaxSegmentRefID&gt;
                &lt;/PaxJourney&gt;
            &lt;/PaxJourneyList&gt;
            &lt;PaxList&gt;
                &lt;Pax&gt;
                    &lt;PaxID&gt;ADT1&lt;/PaxID&gt;
                    &lt;PTC&gt;ADT&lt;/PTC&gt;
                &lt;/Pax&gt;
            &lt;/PaxList&gt;
            &lt;PaxSegmentList&gt;
                &lt;PaxSegment&gt;
                    &lt;DatedMarketingSegmentRefId&gt;DMS1&lt;/DatedMarketingSegmentRefId&gt;
                    &lt;MarketingCarrierRBD_Code&gt;W2&lt;/MarketingCarrierRBD_Code&gt;
                    &lt;OperatingCarrierRBD_Code&gt;W2&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
                &lt;PaxSegment&gt;
                    &lt;DatedMarketingSegmentRefId&gt;DMS2&lt;/DatedMarketingSegmentRefId&gt;
                    &lt;MarketingCarrierRBD_Code&gt;W2&lt;/MarketingCarrierRBD_Code&gt;
                    &lt;OperatingCarrierRBD_Code&gt;W2&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG2&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
            &lt;/PaxSegmentList&gt;
            &lt;PriceClassList&gt;
                &lt;PriceClass&gt;
                    &lt;Code&gt;NOTREBOOK&lt;/Code&gt;
                    &lt;Name&gt;NOTREBOOK&lt;/Name&gt;
                    &lt;PriceClassID&gt;PC1&lt;/PriceClassID&gt;
                &lt;/PriceClass&gt;
            &lt;/PriceClassList&gt;
        &lt;/DataLists&gt;
        &lt;PricedOffer&gt;
            &lt;OfferID&gt;0d8ef628-02f3-4f3b-ba6b-d6bbf8e661d1&lt;/OfferID&gt;
            &lt;OfferItem&gt;
                &lt;FareDetail&gt;
                    &lt;FareComponent&gt;
                        &lt;CabinType/&gt;
                        &lt;FareBasisCode&gt;Y_NOTREBOOK&lt;/FareBasisCode&gt;
                        &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;PriceClassRefID&gt;PC1&lt;/PriceClassRefID&gt;
                    &lt;/FareComponent&gt;
                    &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                &lt;/FareDetail&gt;
                &lt;OfferItemID&gt;a3db17db-e4d7-4d30-95ce-8f634d16bafc:af9c85a0-e93b-4f2c-91b2-eb7d7e7d1e48&lt;/OfferItemID&gt;
                &lt;Price&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                    &lt;TaxSummary&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;4.68&lt;/Amount&gt;
                            &lt;DescText&gt;Tax description&lt;/DescText&gt;
                            &lt;TaxCode&gt;E4&lt;/TaxCode&gt;
                            &lt;TaxName&gt;E4&lt;/TaxName&gt;
                        &lt;/Tax&gt;
                        &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;4.68&lt;/TotalTaxAmount&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;4.68&lt;/TotalAmount&gt;
                &lt;/Price&gt;
                &lt;Service&gt;
                    &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                    &lt;ServiceID&gt;1&lt;/ServiceID&gt;
                &lt;/Service&gt;
            &lt;/OfferItem&gt;
            &lt;OfferItem&gt;
                &lt;FareDetail&gt;
                    &lt;FareComponent&gt;
                        &lt;CabinType/&gt;
                        &lt;FareBasisCode&gt;Y_NOTREBOOK&lt;/FareBasisCode&gt;
                        &lt;PaxSegmentRefID&gt;SEG2&lt;/PaxSegmentRefID&gt;
                        &lt;PriceClassRefID&gt;PC1&lt;/PriceClassRefID&gt;
                    &lt;/FareComponent&gt;
                    &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                &lt;/FareDetail&gt;
                &lt;OfferItemID&gt;19fff8c1-ad9f-4a23-ad4a-fd434356350e:e7756a5a-7194-4c7e-a0ec-28da794e8562&lt;/OfferItemID&gt;
                &lt;Price&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                    &lt;TaxSummary&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;3.68&lt;/Amount&gt;
                            &lt;DescText&gt;Tax description&lt;/DescText&gt;
                            &lt;TaxCode&gt;E4&lt;/TaxCode&gt;
                            &lt;TaxName&gt;E4&lt;/TaxName&gt;
                        &lt;/Tax&gt;
                        &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;3.68&lt;/TotalTaxAmount&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;3.68&lt;/TotalAmount&gt;
                &lt;/Price&gt;
                &lt;Service&gt;
                    &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                    &lt;ServiceID&gt;1&lt;/ServiceID&gt;
                &lt;/Service&gt;
            &lt;/OfferItem&gt;
            &lt;TotalPrice&gt;
                &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                &lt;TaxSummary&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;8.36&lt;/Amount&gt;
                        &lt;DescText&gt;Tax description&lt;/DescText&gt;
                        &lt;TaxCode&gt;E4&lt;/TaxCode&gt;
                        &lt;TaxName&gt;E4&lt;/TaxName&gt;
                    &lt;/Tax&gt;
                    &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;8.36&lt;/TotalTaxAmount&gt;
                &lt;/TaxSummary&gt;
                &lt;TotalAmount CurCode=&quot;USD&quot;&gt;8.36&lt;/TotalAmount&gt;
            &lt;/TotalPrice&gt;
        &lt;/PricedOffer&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;3ffe0001-fbe9-4080-bac9-3e9d042d0e22&lt;/CorrelationID&gt;
        &lt;Timestamp&gt;2026-05-07T18:34:11.567+07:00&lt;/Timestamp&gt;
        &lt;TrxID&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OfferPriceRS&gt;
</code></pre>

</details>

<details>
<summary>Response shape notes (combined service / seat)</summary>

When services or seats are included, `PricedOffer` keeps the flight `OfferItem` rows and appends extra items, for example:

```xml
<!-- Ancillary / SSR OfferItem -->
<OfferItem>
    <OfferItemID>45733be7-4459-40b2-8e46-d20c483a0c82</OfferItemID>
    <Service>
        <ServiceDefinitionRefID>SD1</ServiceDefinitionRefID>
        <PaxRefID>PAX1</PaxRefID>
    </Service>
    <Price>
        <BaseAmount CurCode="USD">6.79</BaseAmount>
        <TotalAmount CurCode="USD">6.79</TotalAmount>
    </Price>
</OfferItem>

<!-- Seat OfferItem — location in Desc -->
<OfferItem>
    <OfferItemID>14a19143-8acc-483d-a9b9-e38794a7ea19</OfferItemID>
    <Desc>
        <DescText>5A</DescText>
    </Desc>
    <Service>
        <ServiceDefinitionRefID>SD1</ServiceDefinitionRefID>
        <PaxRefID>PAX1</PaxRefID>
    </Service>
    <Price>
        <BaseAmount CurCode="USD">12.00</BaseAmount>
        <TotalAmount CurCode="USD">12.00</TotalAmount>
    </Price>
</OfferItem>

<TotalPrice>
    <!-- flight + selected extras -->
    <TotalAmount CurCode="USD">...</TotalAmount>
</TotalPrice>
```

`DataLists` may also include `ServiceDefinitionList` entries for the selected extras.

</details>

### Error Responses

#### 400 Bad Request

Invalid request format, missing required fields, or business validation failures on the selected offers.

| Condition | Typical code |
|-----------|--------------|
| Invalid / unsupported value (e.g. service `Qty ≠ 1`, ineligible passenger, duplicate seat selection) | `12` (`INVALID_VALUE`) |
| Missing required field | `13` |
| Flight / service offer or item not found | `913` (`ITEM_NOT_FOUND`) |
| Selected seat no longer available (e.g. taken since SeatAvailability) | `486` (`SEAT_UNAVAILABLE`) — re-request **SeatAvailability** |

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;ErrorResponse&gt;
    &lt;Error&gt;
        &lt;Code&gt;400&lt;/Code&gt;
        &lt;Message&gt;Bad Request - Invalid request format or missing required fields&lt;/Message&gt;
        &lt;Details&gt;Request validation failed: Missing required field &apos;Request.Offer&apos;&lt;/Details&gt;
    &lt;/Error&gt;
&lt;/ErrorResponse&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OfferPrice \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @offerprice-request.xml
    ```

## Notes

1. **Prerequisites (flight-only):** Call `AirShopping` first and reuse exact `OfferRefID` / `OfferItemRefID` values.
2. **Prerequisites (with service):** Call offer-based `ServiceList`, then include a second `SelectedOffer` with `SelectedALaCarteOfferItem`.
3. **Prerequisites (with seat):** Call offer-based `SeatAvailability`, then include a second `SelectedOffer` with `SelectedSeat` (`ColumnID` + `SeatRowNumber`).
4. **Combined total:** `PricedOffer.TotalPrice` is flight price plus selected service and seat prices. Free/zero-price extras still appear as line items.
5. **Passenger eligibility:** `PaxRefID` on service/seat items must match the eligible passenger on that offer item.
6. **Feature flags:** Combined service/seat pricing requires tenant `service-enabled` / `seat-enabled` (global defaults may be off).
7. **Use in OrderCreate:** Pass the same selection markers (`SelectedALaCarteOfferItem` / `SelectedSeat`) when creating the order from the priced offer.
