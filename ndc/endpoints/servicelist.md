---
layout: go7
title: Service List (ServiceList)
---

# Service List

`POST` `https://api.go7.io/v21.3.5/ServiceList`

---

## Description

The Service List API returns ancillary services available for a selected offer or an existing order. Use it to retrieve optional services such as bags, meals, sports equipment, and other a la carte items before the customer confirms changes or adds extras.

## Workflow (NDC API guide)

**Step 5 (Phase 2)** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/ServiceList` · optional Phase 2 ancillary lookup, with the working sequence using **`OrderRequest`** and **`OrderID`** / **`OrderItemID`** / **`OwnerCode`** after **OrderCreate**. **`OfferRequest`** with **`OfferID`** / **`OfferItemID`** / **`OwnerCode`** remains documented as an alternate request shape. Scenarios: **`#servicelist-by-offer`**, **`#servicelist-by-order`**.

The response returns an **`ALaCarteOffer`** with service-priced `OfferItem` rows that can be used in downstream ancillary or change flows.

See [Authentication](../NDC_API.md#authentication) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

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

The request body must be a valid `IATA_ServiceListRQ` XML document following IATA NDC v21.3.5 standard.

Provide exactly one of **`OfferRequest`** or **`OrderRequest`** inside **`ServiceListCoreRequest`**. Both request modes also support **`ResponseParameters`** such as currency and language.

### ServiceList — By offer
{: #servicelist-by-offer}

Use this mode when you already have an offer from shopping/pricing and need ancillary services for that priced itinerary.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_ServiceListRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        &lt;cns:ServiceListCoreRequest xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
            &lt;cns:OfferRequest&gt;
                &lt;cns:Offer&gt;
                    &lt;cns:OfferID&gt;30bdde1b-cbc1-41d5-a832-ef8b2a665321&lt;/cns:OfferID&gt;
                    &lt;cns:OfferItem&gt;
                        &lt;cns:OfferItemID&gt;0bc734ea-8d1b-459f-978a-afcd9b257ec0:01484b6d-50d2-41a7-8dd3-5380baab9322&lt;/cns:OfferItemID&gt;
                    &lt;/cns:OfferItem&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                &lt;/cns:Offer&gt;
            &lt;/cns:OfferRequest&gt;
        &lt;/cns:ServiceListCoreRequest&gt;
        &lt;cns:ResponseParameters&gt;
            &lt;cns:CurParameter&gt;
                &lt;cns:CurCode&gt;USD&lt;/cns:CurCode&gt;
            &lt;/cns:CurParameter&gt;
            &lt;cns:LangUsage&gt;
                &lt;cns:LangCode&gt;en&lt;/cns:LangCode&gt;
            &lt;/cns:LangUsage&gt;
        &lt;/cns:ResponseParameters&gt;
    &lt;/Request&gt;
&lt;/IATA_ServiceListRQ&gt;
</code></pre>

</details>

### ServiceList — By order
{: #servicelist-by-order}

Use this mode for an existing booking when ancillary pricing must be based on the order and its order items.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_ServiceListRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        &lt;cns:ServiceListCoreRequest xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
            &lt;cns:OrderRequest&gt;
                &lt;cns:Order&gt;
                    &lt;cns:OrderID&gt;754555bf-d24f-4c85-b234-4b4f00db837f&lt;/cns:OrderID&gt;
                    &lt;cns:OrderItem&gt;
                        &lt;cns:OrderItemID&gt;7dbfaecf-4938-4daa-bcff-410496261bc9&lt;/cns:OrderItemID&gt;
                    &lt;/cns:OrderItem&gt;
                    &lt;cns:OwnerCode&gt;VS&lt;/cns:OwnerCode&gt;
                &lt;/cns:Order&gt;
            &lt;/cns:OrderRequest&gt;
        &lt;/cns:ServiceListCoreRequest&gt;
        &lt;cns:ResponseParameters&gt;
            &lt;cns:CurParameter&gt;
                &lt;cns:CurCode&gt;USD&lt;/cns:CurCode&gt;
            &lt;/cns:CurParameter&gt;
            &lt;cns:LangUsage&gt;
                &lt;cns:LangCode&gt;en&lt;/cns:LangCode&gt;
            &lt;/cns:LangUsage&gt;
        &lt;/cns:ResponseParameters&gt;
    &lt;/Request&gt;
&lt;/IATA_ServiceListRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_ServiceListRS` XML document containing `DataLists` and an `ALaCarteOffer` with service-priced offer items. The example below reflects the offer-based fixture; order-based responses use the same structure but return a reshop offer generated from the order context.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_ServiceListRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;DataLists&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-03-19T14:30:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;AAC&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-03-19T12:30:00&lt;/AircraftScheduledDateTime&gt;
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
                    &lt;Duration&gt;PT1H&lt;/Duration&gt;
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
            &lt;PriceClassList&gt;
                &lt;PriceClass&gt;
                    &lt;Name&gt;Economy&lt;/Name&gt;
                    &lt;PriceClassID&gt;PC1&lt;/PriceClassID&gt;
                &lt;/PriceClass&gt;
            &lt;/PriceClassList&gt;
            &lt;ServiceDefinitionList&gt;
                &lt;ServiceDefinition&gt;
                    &lt;Name&gt;Cykler - OddSize&lt;/Name&gt;
                    &lt;ServiceDefinitionID&gt;SD1&lt;/ServiceDefinitionID&gt;
                &lt;/ServiceDefinition&gt;
                &lt;ServiceDefinition&gt;
                    &lt;Name&gt;Skiudstyr - OddSize&lt;/Name&gt;
                    &lt;ServiceDefinitionID&gt;SD2&lt;/ServiceDefinitionID&gt;
                &lt;/ServiceDefinition&gt;
                &lt;ServiceDefinition&gt;
                    &lt;Name&gt;food - Food&lt;/Name&gt;
                    &lt;ServiceDefinitionID&gt;SD4&lt;/ServiceDefinitionID&gt;
                &lt;/ServiceDefinition&gt;
            &lt;/ServiceDefinitionList&gt;
        &lt;/DataLists&gt;
        &lt;ALaCarteOffer&gt;
            &lt;OfferID&gt;30bdde1b-cbc1-41d5-a832-ef8b2a665321&lt;/OfferID&gt;
            &lt;OfferItem&gt;
                &lt;Eligibility&gt;
                    &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
                    &lt;OfferFlightAssociations&gt;
                        &lt;PaxSegmentReferences&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentReferences&gt;
                    &lt;/OfferFlightAssociations&gt;
                &lt;/Eligibility&gt;
                &lt;OfferItemID&gt;37bfec30-d49b-401a-84a7-7249f97cd949&lt;/OfferItemID&gt;
                &lt;Service&gt;
                    &lt;ServiceDefinitionRefID&gt;SD1&lt;/ServiceDefinitionRefID&gt;
                    &lt;ServiceID&gt;SV1&lt;/ServiceID&gt;
                &lt;/Service&gt;
                &lt;UnitPrice&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;6.79&lt;/BaseAmount&gt;
                    &lt;TaxSummary&gt;
                        &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalTaxAmount&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;6.79&lt;/TotalAmount&gt;
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
                &lt;OfferItemID&gt;11e58f1e-37d4-4ac5-8543-e703867f9c5b&lt;/OfferItemID&gt;
                &lt;Service&gt;
                    &lt;ServiceDefinitionRefID&gt;SD2&lt;/ServiceDefinitionRefID&gt;
                    &lt;ServiceID&gt;SV2&lt;/ServiceID&gt;
                &lt;/Service&gt;
                &lt;UnitPrice&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;13.58&lt;/BaseAmount&gt;
                    &lt;TaxSummary&gt;
                        &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalTaxAmount&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;13.58&lt;/TotalAmount&gt;
                &lt;/UnitPrice&gt;
            &lt;/OfferItem&gt;
            &lt;TotalPrice&gt;
                &lt;BaseAmount CurCode=&quot;USD&quot;&gt;325.44&lt;/BaseAmount&gt;
                &lt;TaxSummary&gt;
                    &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalTaxAmount&gt;
                &lt;/TaxSummary&gt;
                &lt;TotalAmount CurCode=&quot;USD&quot;&gt;325.44&lt;/TotalAmount&gt;
            &lt;/TotalPrice&gt;
        &lt;/ALaCarteOffer&gt;
    &lt;/ns2:Response&gt;
&lt;/ns2:IATA_ServiceListRS&gt;
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
        &lt;Details&gt;Request validation failed: Missing required field 'Request.ServiceListCoreRequest'&lt;/Details&gt;
    &lt;/Error&gt;
&lt;/ErrorResponse&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/ServiceList \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @servicelist-request-offer.xml
    ```

## Notes

1. `ServiceListCoreRequest` must contain either `OfferRequest` or `OrderRequest`; the gateway branches on that choice.
2. Offer-based lookups use `OfferID` plus one or more `OfferItemID` values from the upstream offer context. This request can only be used to get information about the offer.
3. Order-based lookups use `OrderID` and `OrderItemID` values from the existing booking and return a reshop-style ancillary offer.
4. `ResponseParameters` controls output preferences such as currency (`CurCode`) and language (`LangCode`).
