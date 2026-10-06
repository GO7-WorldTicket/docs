---
layout: go7
title: Airline Profile (AirlineProfile)
---

# Airline Profile

`POST` `https://go7-api-gateway.prod.go7.io/ndc-gateway/v21.3.5/AirlineProfile`

---

## Description

The Airline Profile API returns the IATA NDC airline profile of each airline: the origin and destination airport pairs the airline serves. Use it to build origin and destination pickers, or to check that an airport pair is served before calling **AirShopping**.

`IATA_AirlineProfileRQ` / `IATA_AirlineProfileRS` are standard IATA NDC 21.3 messages. Their schemas are not in the [IATA schema package](/docs/assets/resources/NDC-xmlbeans-21.3.5.zip); download [IATA_AirlineProfileRQ.xsd](/docs/assets/resources/IATA_AirlineProfileRQ.xsd) and [IATA_AirlineProfileRS.xsd](/docs/assets/resources/IATA_AirlineProfileRS.xsd) and put them next to `IATA_OffersAndOrdersCommonTypes.xsd` from that package. They follow the [IATA XSD Viewer 21.3.5](https://retailing.iata.org/tools/xsd_viewer/21.3.5/IATA_AirlineProfileRQ/).

## Workflow (NDC API guide)

**Step 0, optional** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/AirlineProfile` · airport pairs an airline serves, before **AirShopping**. It does not create or change anything, and no other message depends on its response. Scenarios: **[`#airlineprofile-all`](#airlineprofile-all)**, **[`#airlineprofile-by-owner`](#airlineprofile-by-owner)**, **[`#airlineprofile-several-owners`](#airlineprofile-several-owners)**.

The response returns one **`AirlineProfile`** per airline, with one **`AirlineProfileDataItem`** per origin and destination airport pair.

See [Authentication](../NDC_API.md#http-headers) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Purpose | Format | Required | Example |
|--------|---------|--------|----------|---------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | Yes | `x-tenant: test-qa-rc` |
| `x-SalesChannel` | Specifies the sales channel; only routes sold in this channel are returned | String (`DIRECT_OTA` or `OTA_NETWORK`) | Yes | `x-SalesChannel: DIRECT_OTA` |
| `x-api-key` | API key for authenticating the request | String | Yes | `x-api-key: {x-api-key}` |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

## Request Body

The request body must be a valid `IATA_AirlineProfileRQ` XML document ([IATA_AirlineProfileRQ.xsd](/docs/assets/resources/IATA_AirlineProfileRQ.xsd)).

| Element | Occurs | Use |
|---------|--------|-----|
| `DistributionChain` | 1 | Same as on every NDC message. Each link needs `Ordinal`, `OrgRole` and `ParticipatingOrg/OrgID`. |
| `PayloadAttributes` | 0..1 | Echoed in the response (`CorrelationID`, `TrxID`, `VersionNumber`, `Timestamp`, `PrimaryLangID`). |
| `Request/AirlineProfileFilterCriteria` | 1 | Profile filter. May be empty. |
| `…/AirlineProfileCriteria/OwnerCode` | 0..n | Airline whose profile is returned. Repeat `AirlineProfileCriteria` for several airlines. |
| `…/AllProfilesInd` | 0..1 | `true` returns every profile available to you; `OwnerCode` values are then ignored. |
| `…/MediaURL_Ind` | 0..1 | Not supported. Profiles are always returned inline. |

Without `AirlineProfileCriteria` (or with `AllProfilesInd` = `true`) no airline filter is applied. The standard message has no airport filter: filter the returned pairs on your side.

### AirlineProfile — All profiles
{: #airlineprofile-all}

Use this mode to list every route without filtering by airline. The routes returned are those available for the tenant the request is made for (`x-tenant`) in your sales channel (`x-SalesChannel`). An empty `AirlineProfileFilterCriteria` gives the same result.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_AirlineProfileRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        &lt;cns:CorrelationID&gt;AP-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:AirlineProfileFilterCriteria&gt;
            &lt;cns:AllProfilesInd&gt;true&lt;/cns:AllProfilesInd&gt;
        &lt;/cns:AirlineProfileFilterCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_AirlineProfileRQ&gt;
</code></pre>

</details>

### AirlineProfile — By airline
{: #airlineprofile-by-owner}

Use this mode to list every route of one airline.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_AirlineProfileRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        &lt;cns:CorrelationID&gt;AP-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:AirlineProfileFilterCriteria&gt;
            &lt;cns:AirlineProfileCriteria&gt;
                &lt;cns:OwnerCode&gt;DX&lt;/cns:OwnerCode&gt;
            &lt;/cns:AirlineProfileCriteria&gt;
        &lt;/cns:AirlineProfileFilterCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_AirlineProfileRQ&gt;
</code></pre>

</details>

### AirlineProfile — Several airlines
{: #airlineprofile-several-owners}

Repeat `AirlineProfileCriteria` to get the profiles of several airlines in one call. An airline without routes is still returned, as an `AirlineProfile` with `ProfileOwner` only.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_AirlineProfileRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        &lt;cns:CorrelationID&gt;AP-001-2026&lt;/cns:CorrelationID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;cns:AirlineProfileFilterCriteria&gt;
            &lt;cns:AirlineProfileCriteria&gt;
                &lt;cns:OwnerCode&gt;DX&lt;/cns:OwnerCode&gt;
            &lt;/cns:AirlineProfileCriteria&gt;
            &lt;cns:AirlineProfileCriteria&gt;
                &lt;cns:OwnerCode&gt;J2&lt;/cns:OwnerCode&gt;
            &lt;/cns:AirlineProfileCriteria&gt;
        &lt;/cns:AirlineProfileFilterCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_AirlineProfileRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_AirlineProfileRS` XML document ([IATA_AirlineProfileRS.xsd](/docs/assets/resources/IATA_AirlineProfileRS.xsd)):

- one `AirlineProfile` per airline, with `ProfileOwner/AirlineDesigCode` (IATA airline code) and `ProfileOwner/Name`;
- one `AirlineProfileDataItem` per origin and destination airport pair, in `OfferFilterCriteria/OfferFilterCriteriaChoice/OfferFilterCriteriawithOriginandDest`: `OfferOriginPoint/IATA_LocationCode`, `OfferDestPoint/IATA_LocationCode` and `DirectionalIndText` = `1` (from origin to destination). A return route is a separate item.
- `SeqNumber` numbers the items of a profile from 1.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_AirlineProfileRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#"&gt;
    &lt;ns2:Response&gt;
        &lt;AirlineProfile&gt;
            &lt;AirlineProfileDataItem&gt;
                &lt;OfferFilterCriteria&gt;
                    &lt;OfferFilterCriteriaChoice&gt;
                        &lt;OfferFilterCriteriawithOriginandDest&gt;
                            &lt;DirectionalIndText&gt;1&lt;/DirectionalIndText&gt;
                            &lt;OfferDestPoint&gt;
                                &lt;IATA_LocationCode&gt;AAL&lt;/IATA_LocationCode&gt;
                            &lt;/OfferDestPoint&gt;
                            &lt;OfferOriginPoint&gt;
                                &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                            &lt;/OfferOriginPoint&gt;
                        &lt;/OfferFilterCriteriawithOriginandDest&gt;
                    &lt;/OfferFilterCriteriaChoice&gt;
                &lt;/OfferFilterCriteria&gt;
                &lt;SeqNumber&gt;1&lt;/SeqNumber&gt;
            &lt;/AirlineProfileDataItem&gt;
            &lt;AirlineProfileDataItem&gt;
                &lt;OfferFilterCriteria&gt;
                    &lt;OfferFilterCriteriaChoice&gt;
                        &lt;OfferFilterCriteriawithOriginandDest&gt;
                            &lt;DirectionalIndText&gt;1&lt;/DirectionalIndText&gt;
                            &lt;OfferDestPoint&gt;
                                &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                            &lt;/OfferDestPoint&gt;
                            &lt;OfferOriginPoint&gt;
                                &lt;IATA_LocationCode&gt;AAL&lt;/IATA_LocationCode&gt;
                            &lt;/OfferOriginPoint&gt;
                        &lt;/OfferFilterCriteriawithOriginandDest&gt;
                    &lt;/OfferFilterCriteriaChoice&gt;
                &lt;/OfferFilterCriteria&gt;
                &lt;SeqNumber&gt;2&lt;/SeqNumber&gt;
            &lt;/AirlineProfileDataItem&gt;
            &lt;AirlineProfileDataItem&gt;
                &lt;OfferFilterCriteria&gt;
                    &lt;OfferFilterCriteriaChoice&gt;
                        &lt;OfferFilterCriteriawithOriginandDest&gt;
                            &lt;DirectionalIndText&gt;1&lt;/DirectionalIndText&gt;
                            &lt;OfferDestPoint&gt;
                                &lt;IATA_LocationCode&gt;BLL&lt;/IATA_LocationCode&gt;
                            &lt;/OfferDestPoint&gt;
                            &lt;OfferOriginPoint&gt;
                                &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                            &lt;/OfferOriginPoint&gt;
                        &lt;/OfferFilterCriteriawithOriginandDest&gt;
                    &lt;/OfferFilterCriteriaChoice&gt;
                &lt;/OfferFilterCriteria&gt;
                &lt;SeqNumber&gt;3&lt;/SeqNumber&gt;
            &lt;/AirlineProfileDataItem&gt;
            &lt;ProfileOwner&gt;
                &lt;AirlineDesigCode&gt;DX&lt;/AirlineDesigCode&gt;
                &lt;Name&gt;DAT&lt;/Name&gt;
            &lt;/ProfileOwner&gt;
        &lt;/AirlineProfile&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;AP-001-2026&lt;/CorrelationID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_AirlineProfileRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request format, missing required fields, invalid codes, or no profile found. The error is returned as `IATA_AirlineProfileRS/Error`.

| Case | Code | TagText |
|------|------|---------|
| `DistributionChain` missing, or a link without `Ordinal`, `OrgRole` or `ParticipatingOrg/OrgID` | 13 | `Request.DistributionChain…` |
| `Request` or `Request/AirlineProfileFilterCriteria` missing | 13 | `Request`, `Request.AirlineProfileFilterCriteria` |
| `AirlineProfileCriteria` without `OwnerCode` | 13 | `Request.AirlineProfileFilterCriteria.AirlineProfileCriteria[i].OwnerCode` |
| `OwnerCode` is not a valid IATA or ICAO airline code | 12 | `Request.AirlineProfileFilterCriteria.AirlineProfileCriteria[i].OwnerCode` |
| No route found and no airline requested | 913 | — |

<details>
<summary>Response Payload — invalid OwnerCode</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_AirlineProfileRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#"&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;12&lt;/Code&gt;
        &lt;DescText&gt;Invalid value 'INVALID' at Request.AirlineProfileFilterCriteria.AirlineProfileCriteria[0].OwnerCode&lt;/DescText&gt;
        &lt;ErrorID&gt;AP-001-2026&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TagText&gt;Request.AirlineProfileFilterCriteria.AirlineProfileCriteria[0].OwnerCode&lt;/TagText&gt;
        &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_AirlineProfileRS&gt;
</code></pre>

</details>

<details>
<summary>Response Payload — no profile found</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
&lt;ns2:IATA_AirlineProfileRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#"&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;913&lt;/Code&gt;
        &lt;DescText&gt;No airline profile found&lt;/DescText&gt;
        &lt;ErrorID&gt;AP-001-2026&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TypeCode&gt;Application&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_AirlineProfileRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://go7-api-gateway.prod.go7.io/ndc-gateway/v21.3.5/AirlineProfile \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: DIRECT_OTA" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @airlineprofile-request.xml
    ```

## Notes

1. `IATA_AirlineProfileRQ` / `IATA_AirlineProfileRS` are standard IATA NDC 21.3 messages; validate them against [IATA_AirlineProfileRQ.xsd](/docs/assets/resources/IATA_AirlineProfileRQ.xsd) and [IATA_AirlineProfileRS.xsd](/docs/assets/resources/IATA_AirlineProfileRS.xsd).
2. Send `OwnerCode` to get the profiles of specific airlines; without it the routes returned depend on the tenant the request is made for.
3. Routes are filtered by the `x-SalesChannel` header: a route that is not sold in that channel is not returned.
4. A route is an airport pair, not a flight. Use **AirShopping** for dates, flights, connections and prices.
