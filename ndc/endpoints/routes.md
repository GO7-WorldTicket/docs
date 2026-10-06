---
layout: go7
title: Routes (Routes)
---

# Routes

`POST` `https://go7-api-gateway.prod.go7.io/ndc-gateway/v21.3.5/Routes`

---

## Description

The Routes API returns the routes an airline serves: the origin and destination airport pairs available for booking. Use it to build origin and destination pickers, or to check that an airport pair is served before calling **AirShopping**.

**GO7 extension.** `Routes` is **not part of the IATA NDC standard**. `IATA_RoutesRQ` / `IATA_RoutesRS` are GO7 messages in the standard `IATA_OffersAndOrdersMessage` namespace, built only from standard `IATA_OffersAndOrdersCommonTypes` types (`DistributionChainType`, `IATA_PayloadStandardAttributesType`, `CarrierCriteriaType`, `IATA_LocationCodeType`, `DataListsType`, `ErrorType`, `WarningType`). Existing NDC 21.3 bindings can be reused. Schemas: [IATA_RoutesRQ.xsd](/docs/assets/resources/IATA_RoutesRQ.xsd), [IATA_RoutesRS.xsd](/docs/assets/resources/IATA_RoutesRS.xsd) — they import `IATA_OffersAndOrdersCommonTypes.xsd` from the [IATA schema package](/docs/assets/resources/NDC-xmlbeans-21.3.5.zip).

## Workflow (NDC API guide)

**Step 0, optional** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/Routes` · route lookup before **AirShopping**. It does not create or change anything, and no other message depends on its response. Scenarios: **[`#routes-all`](#routes-all)**, **[`#routes-by-carrier`](#routes-by-carrier)**, **[`#routes-from-origin`](#routes-from-origin)**, **[`#routes-by-carrier-and-airports`](#routes-by-carrier-and-airports)**.

The response returns one **`DataLists/OriginDestList/OriginDest`** per origin and destination airport pair.

See [Authentication](../NDC_API.md#http-headers) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Purpose | Format | Required | Example |
|--------|---------|--------|----------|---------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | No | `x-tenant: test-qa-rc` |
| `x-SalesChannel` | Specifies the sales channel; only routes sold in this channel are returned | String (`DIRECT_OTA` or `OTA_NETWORK`) | No | `x-SalesChannel: DIRECT_OTA` |
| `x-api-key` | API key for authenticating the request | String | Yes (if no tenant and sales channel) | `x-api-key: {x-api-key}` |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

## Request Body

The request body must be a valid `IATA_RoutesRQ` XML document ([IATA_RoutesRQ.xsd](/docs/assets/resources/IATA_RoutesRQ.xsd)).

| Element | Type | Occurs | Description |
|---------|------|--------|-------------|
| `DistributionChain` | `cns:DistributionChainType` | 1 | Same as on every NDC message. Each link needs `Ordinal`, `OrgRole` and `ParticipatingOrg/OrgID`. |
| `PayloadAttributes` | `cns:IATA_PayloadStandardAttributesType` | 0..1 | Echoed in the response (`CorrelationID`, `TrxID`, `VersionNumber`, `Timestamp`, `PrimaryLangID`). |
| `Request` | — | 1 | Route filters. All of them are optional and are combined with AND. |
| `Request/CarrierCriteria/Carrier/AirlineDesigCode` | `cns:CarrierCriteriaType` | 0..n | Airline whose routes are returned. Repeat `CarrierCriteria` for several airlines. |
| `Request/OriginCode` | `cns:IATA_LocationCodeType` | 0..1 | IATA **airport** code of the departure. |
| `Request/DestCode` | `cns:IATA_LocationCodeType` | 0..1 | IATA **airport** code of the arrival. |

Elements inside `Request` must appear in this order: `CarrierCriteria`, `OriginCode`, `DestCode`.

### Routes — All routes
{: #routes-all}

Use this mode to list every route without filtering by airline or airport: send an empty `Request`. No carrier filter is applied, so the routes returned are those available for the tenant the request is made for (`x-tenant`) in your sales channel (`x-SalesChannel`).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_RoutesRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;RT-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request/&gt;
&lt;/IATA_RoutesRQ&gt;
</code></pre>

</details>

### Routes — By carrier
{: #routes-by-carrier}

Use this mode to list every route of an airline.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_RoutesRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;RT-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;CarrierCriteria&gt;
            &lt;cns:Carrier&gt;
                &lt;cns:AirlineDesigCode&gt;DX&lt;/cns:AirlineDesigCode&gt;
            &lt;/cns:Carrier&gt;
        &lt;/CarrierCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_RoutesRQ&gt;
</code></pre>

</details>

### Routes — From an origin
{: #routes-from-origin}

Use this mode to list the destinations an airline serves from one airport.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_RoutesRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;RT-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;CarrierCriteria&gt;
            &lt;cns:Carrier&gt;
                &lt;cns:AirlineDesigCode&gt;DX&lt;/cns:AirlineDesigCode&gt;
            &lt;/cns:Carrier&gt;
        &lt;/CarrierCriteria&gt;
        &lt;OriginCode&gt;CPH&lt;/OriginCode&gt;
    &lt;/Request&gt;
&lt;/IATA_RoutesRQ&gt;
</code></pre>

</details>

### Routes — By carrier and airports
{: #routes-by-carrier-and-airports}

Use this mode to check that an airline serves one origin and destination pair. An empty `DataLists` means the pair is not served.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_RoutesRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;RT-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;CarrierCriteria&gt;
            &lt;cns:Carrier&gt;
                &lt;cns:AirlineDesigCode&gt;DX&lt;/cns:AirlineDesigCode&gt;
            &lt;/cns:Carrier&gt;
        &lt;/CarrierCriteria&gt;
        &lt;OriginCode&gt;CPH&lt;/OriginCode&gt;
        &lt;DestCode&gt;AAL&lt;/DestCode&gt;
    &lt;/Request&gt;
&lt;/IATA_RoutesRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_RoutesRS` XML document ([IATA_RoutesRS.xsd](/docs/assets/resources/IATA_RoutesRS.xsd)). Each origin and destination airport pair is returned once, as one `OriginDest`, even when several airlines or sales channels serve it. `OriginDestID` is `<OriginCode>-<DestCode>`.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_RoutesRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"&gt;
    &lt;ns2:Response&gt;
        &lt;ns2:DataLists&gt;
            &lt;OriginDestList&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;AAL&lt;/DestCode&gt;
                    &lt;OriginCode&gt;CPH&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;CPH-AAL&lt;/OriginDestID&gt;
                &lt;/OriginDest&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;BLL&lt;/DestCode&gt;
                    &lt;OriginCode&gt;CPH&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;CPH-BLL&lt;/OriginDestID&gt;
                &lt;/OriginDest&gt;
            &lt;/OriginDestList&gt;
        &lt;/ns2:DataLists&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;RT-001-2026&lt;/CorrelationID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_RoutesRS&gt;
</code></pre>

</details>

When no route matches, the response is still `200 OK`, with an empty `DataLists`:

<details>
<summary>Response Payload — no route found</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_RoutesRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"&gt;
    &lt;ns2:Response&gt;
        &lt;ns2:DataLists/&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;RT-001-2026&lt;/CorrelationID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_RoutesRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request format, missing required fields or invalid codes. The error is returned as `IATA_RoutesRS/Error`.

| Case | Code | TagText |
|------|------|---------|
| `DistributionChain` missing, or a link without `Ordinal`, `OrgRole` or `ParticipatingOrg/OrgID` | 13 | `Request.DistributionChain…` |
| `Request` missing | 13 | `Request` |
| `CarrierCriteria` sent without `Carrier/AirlineDesigCode` | 13 | `Request.CarrierCriteria[i].Carrier.AirlineDesigCode` |
| Airline code is not a valid IATA or ICAO code | 12 | `Request.CarrierCriteria[i].Carrier.AirlineDesigCode` |
| `OriginCode` or `DestCode` is not a valid airport code | 12 | `Request.OriginCode`, `Request.DestCode` |

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_RoutesRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;12&lt;/Code&gt;
        &lt;DescText&gt;Invalid value 'COPENHAGEN' at Request.OriginCode&lt;/DescText&gt;
        &lt;ErrorID&gt;RT-001-2026&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TagText&gt;Request.OriginCode&lt;/TagText&gt;
        &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_RoutesRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://go7-api-gateway.prod.go7.io/ndc-gateway/v21.3.5/Routes \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: DIRECT_OTA" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @routes-request.xml
    ```

## Notes

1. `Routes` is a GO7 extension of NDC 21.3; it is not part of the IATA standard. Validate against [IATA_RoutesRQ.xsd](/docs/assets/resources/IATA_RoutesRQ.xsd), not against an IATA schema.
2. All filters are optional. Send `CarrierCriteria` to get the routes of specific airlines; without it no carrier filter is applied and the routes returned depend on the tenant the request is made for.
3. `OriginCode` and `DestCode` are airport codes. City and country codes are not supported.
