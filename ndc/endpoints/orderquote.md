---
layout: go7
title: Order Quote (OrderQuote)
---

# Order Quote

`POST` `https://api.go7.io/v21.3.5/OrderQuote`

---

## Description

The Order Quote API returns pricing information for modifying an existing order. Provide the existing order ID and the new offers you want to use. The response includes reshop offers with updated pricing information.

## Workflow (NDC API guide)

**Step 6** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderQuote` · **`Payload.ExistingOrder`** + **`Payload.SelectedOffers`** with **`OfferRefID` / `OfferItemRefID`** from **AirShopping**, **OfferPrice**, or **OrderReshopRS**. Scenarios: **`#orderquote-rebook`**, **`#orderquote-cancel`**, **`#orderquote-booking`**.

See [Authentication](../NDC_API.md#authentication) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Purpose | Format | Required | Example |
|--------|---------|--------|----------|---------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | Yes | `x-tenant: test-qa-rc` |
| `x-SalesChannel` | Specifies the sales channel (maps to account IDs per tenant configuration) | String (e.g., `NDC`, `IBE`) | Yes | `x-SalesChannel: NDC` |
| `x-api-key` | API key for authenticating the request | String | Yes | `x-api-key: 96d2bf5f-2740-4d64-80e9-3542cc44bbbb` |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

**Note:** The `x-SalesChannel` value is used to determine the account ID based on tenant configuration.

## Request Body

The request body must be a valid `IATA_OrderQuoteRQ` XML document following IATA NDC v21.3.5 standard.

### OrderQuote — Rebook quote
{: #orderquote-rebook}

**`Payload.ExistingOrder`** + **`Payload.SelectedOffers`** with **`OfferRefID` / `OfferItemRefID`** from **OrderReshopRS** (rebook path).

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderQuoteRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:cns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
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
    &lt;Payload&gt;
        &lt;ExistingOrder xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
        &lt;/ExistingOrder&gt;
        &lt;SelectedOffers xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OfferRefID&gt;351b2a94-83d1-4347-8bbe-8844a4c76cb0&lt;/OfferRefID&gt;
            &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;2afd921a-885f-49bb-93ae-5c279660384c&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;66b0aad9-048a-4d1e-bee6-124a1bda2baa&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX2&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;e8469306-5a16-41a0-bc62-aa98b5b03184&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX3&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
        &lt;/SelectedOffers&gt;
    &lt;/Payload&gt;
    &lt;PayloadAttributes&gt;
        &lt;CorrelationID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;{{$randomUUID}}&lt;/CorrelationID&gt;
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2026-05-07T13:35:51.653+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
&lt;/IATA_OrderQuoteRQ&gt;
</code></pre>

</details>

### Response (`OrderReshopRS`-style quote):

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderReshopRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;DataLists&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-27T07:00:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-27T06:00:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;KRP&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                    &lt;MarketingCarrierFlightNumberText&gt;DX0500&lt;/MarketingCarrierFlightNumberText&gt;
                &lt;/DatedMarketingSegment&gt;
            &lt;/DatedMarketingSegmentList&gt;
            &lt;DatedOperatingSegmentList&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS1&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;DX0500&lt;/OperatingCarrierFlightNumberText&gt;
                &lt;/DatedOperatingSegment&gt;
            &lt;/DatedOperatingSegmentList&gt;
            &lt;OriginDestList&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;CPH&lt;/DestCode&gt;
                    &lt;OriginCode&gt;KRP&lt;/OriginCode&gt;
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
                    &lt;PaxID&gt;CHD1&lt;/PaxID&gt;
                    &lt;PTC&gt;CHD&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;PaxID&gt;ADT1&lt;/PaxID&gt;
                    &lt;PTC&gt;ADT&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;PaxID&gt;INF1&lt;/PaxID&gt;
                    &lt;PTC&gt;INF&lt;/PTC&gt;
                &lt;/Pax&gt;
            &lt;/PaxList&gt;
            &lt;PaxSegmentList&gt;
                &lt;PaxSegment&gt;
                    &lt;DatedMarketingSegmentRefId&gt;DMS1&lt;/DatedMarketingSegmentRefId&gt;
                    &lt;MarketingCarrierRBD_Code&gt;W2&lt;/MarketingCarrierRBD_Code&gt;
                    &lt;OperatingCarrierRBD_Code&gt;DX&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
            &lt;/PaxSegmentList&gt;
            &lt;PenaltyList/&gt;
            &lt;PriceClassList&gt;
                &lt;PriceClass&gt;
                    &lt;Code&gt;Bedre&lt;/Code&gt;
                    &lt;Name&gt;Bedre&lt;/Name&gt;
                    &lt;PriceClassID&gt;PC1&lt;/PriceClassID&gt;
                &lt;/PriceClass&gt;
            &lt;/PriceClassList&gt;
            &lt;ServiceDefinitionList/&gt;
        &lt;/DataLists&gt;
        &lt;Order&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
        &lt;/Order&gt;
        &lt;ReshopResults&gt;
            &lt;ReshopOffers&gt;
                &lt;Offer&gt;
                    &lt;AddedOfferItem&gt;
                        &lt;FareDetail&gt;
                            &lt;FareComponent&gt;
                                &lt;CabinType&gt;
                                    &lt;CabinTypeCode&gt;Y&lt;/CabinTypeCode&gt;
                                &lt;/CabinType&gt;
                                &lt;FareBasisCode&gt;BDXBED&lt;/FareBasisCode&gt;
                                &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                                &lt;PriceClassRefID&gt;PC1&lt;/PriceClassRefID&gt;
                            &lt;/FareComponent&gt;
                            &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                        &lt;/FareDetail&gt;
                        &lt;OfferItemID&gt;2afd921a-885f-49bb-93ae-5c279660384c&lt;/OfferItemID&gt;
                        &lt;ReshopPrice&gt;
                            &lt;PriceDifferential&gt;
                                &lt;DifferentialTypeCode&gt;AddCol&lt;/DifferentialTypeCode&gt;
                                &lt;DiffPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;34.62&lt;/BaseAmount&gt;
                                        &lt;TaxSummary&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;4.07&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;EU&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;2.04&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;6.11&lt;/TotalTaxAmount&gt;
                                        &lt;/TaxSummary&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/DiffPrice&gt;
                                &lt;NewPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;34.62&lt;/BaseAmount&gt;
                                        &lt;TaxSummary&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;2.04&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;4.07&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;EU&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;6.11&lt;/TotalTaxAmount&gt;
                                        &lt;/TaxSummary&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/NewPrice&gt;
                                &lt;OldPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/OldPrice&gt;
                            &lt;/PriceDifferential&gt;
                        &lt;/ReshopPrice&gt;
                        &lt;Service&gt;
                            &lt;OfferServiceAssociation&gt;
                                &lt;PaxJourneyRef&gt;
                                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                                &lt;/PaxJourneyRef&gt;
                            &lt;/OfferServiceAssociation&gt;
                            &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                        &lt;/Service&gt;
                    &lt;/AddedOfferItem&gt;
                    &lt;AddedOfferItem&gt;
                        &lt;FareDetail&gt;
                            &lt;FareComponent&gt;
                                &lt;CabinType&gt;
                                    &lt;CabinTypeCode&gt;Y&lt;/CabinTypeCode&gt;
                                &lt;/CabinType&gt;
                                &lt;FareBasisCode&gt;BDXBED&lt;/FareBasisCode&gt;
                                &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                                &lt;PriceClassRefID&gt;PC1&lt;/PriceClassRefID&gt;
                            &lt;/FareComponent&gt;
                            &lt;PaxRefID&gt;INF1&lt;/PaxRefID&gt;
                        &lt;/FareDetail&gt;
                        &lt;OfferItemID&gt;66b0aad9-048a-4d1e-bee6-124a1bda2baa&lt;/OfferItemID&gt;
                        &lt;ReshopPrice&gt;
                            &lt;PriceDifferential&gt;
                                &lt;DifferentialTypeCode&gt;AddCol&lt;/DifferentialTypeCode&gt;
                                &lt;DiffPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/BaseAmount&gt;
                                        &lt;TaxSummary&gt;
                                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalTaxAmount&gt;
                                        &lt;/TaxSummary&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/DiffPrice&gt;
                                &lt;NewPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/BaseAmount&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/NewPrice&gt;
                                &lt;OldPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/OldPrice&gt;
                            &lt;/PriceDifferential&gt;
                        &lt;/ReshopPrice&gt;
                        &lt;Service&gt;
                            &lt;OfferServiceAssociation&gt;
                                &lt;PaxJourneyRef&gt;
                                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                                &lt;/PaxJourneyRef&gt;
                            &lt;/OfferServiceAssociation&gt;
                            &lt;PaxRefID&gt;INF1&lt;/PaxRefID&gt;
                        &lt;/Service&gt;
                    &lt;/AddedOfferItem&gt;
                    &lt;AddedOfferItem&gt;
                        &lt;FareDetail&gt;
                            &lt;FareComponent&gt;
                                &lt;CabinType&gt;
                                    &lt;CabinTypeCode&gt;Y&lt;/CabinTypeCode&gt;
                                &lt;/CabinType&gt;
                                &lt;FareBasisCode&gt;BDXBED&lt;/FareBasisCode&gt;
                                &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                                &lt;PriceClassRefID&gt;PC1&lt;/PriceClassRefID&gt;
                            &lt;/FareComponent&gt;
                            &lt;PaxRefID&gt;CHD1&lt;/PaxRefID&gt;
                        &lt;/FareDetail&gt;
                        &lt;OfferItemID&gt;e8469306-5a16-41a0-bc62-aa98b5b03184&lt;/OfferItemID&gt;
                        &lt;ReshopPrice&gt;
                            &lt;PriceDifferential&gt;
                                &lt;DifferentialTypeCode&gt;AddCol&lt;/DifferentialTypeCode&gt;
                                &lt;DiffPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;39.82&lt;/BaseAmount&gt;
                                        &lt;TaxSummary&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;0.64&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;QQ&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;0.27&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.91&lt;/TotalTaxAmount&gt;
                                        &lt;/TaxSummary&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/DiffPrice&gt;
                                &lt;NewPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;39.82&lt;/BaseAmount&gt;
                                        &lt;TaxSummary&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;0.27&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;Tax&gt;
                                                &lt;Amount CurCode=&quot;USD&quot;&gt;0.64&lt;/Amount&gt;
                                                &lt;DescText&gt;Tax description&lt;/DescText&gt;
                                                &lt;TaxCode&gt;QQ&lt;/TaxCode&gt;
                                            &lt;/Tax&gt;
                                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.91&lt;/TotalTaxAmount&gt;
                                        &lt;/TaxSummary&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/NewPrice&gt;
                                &lt;OldPrice&gt;
                                    &lt;Price&gt;
                                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                                    &lt;/Price&gt;
                                &lt;/OldPrice&gt;
                            &lt;/PriceDifferential&gt;
                        &lt;/ReshopPrice&gt;
                        &lt;Service&gt;
                            &lt;OfferServiceAssociation&gt;
                                &lt;PaxJourneyRef&gt;
                                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                                &lt;/PaxJourneyRef&gt;
                            &lt;/OfferServiceAssociation&gt;
                            &lt;PaxRefID&gt;CHD1&lt;/PaxRefID&gt;
                        &lt;/Service&gt;
                    &lt;/AddedOfferItem&gt;
                    &lt;OfferID&gt;351b2a94-83d1-4347-8bbe-8844a4c76cb0&lt;/OfferID&gt;
                    &lt;TotalPrice&gt;
                        &lt;BaseAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/BaseAmount&gt;
                        &lt;TaxSummary&gt;
                            &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalTaxAmount&gt;
                        &lt;/TaxSummary&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.0&lt;/TotalAmount&gt;
                    &lt;/TotalPrice&gt;
                &lt;/Offer&gt;
            &lt;/ReshopOffers&gt;
        &lt;/ReshopResults&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;ce366c50-43b5-4590-8b6f-4d796171ac4d&lt;/CorrelationID&gt;
        &lt;Timestamp&gt;2026-05-07T13:35:51.653+07:00&lt;/Timestamp&gt;
        &lt;TrxID&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OrderReshopRS&gt;
</code></pre>

</details>

### OrderQuote — Cancel quote
{: #orderquote-cancel}

Phase 1 often **skips** **`OrderQuote`** when refunds are unsupported. If your airline enables cancel quoting, shape matches the rebook quote but **`SelectedOffers`** carry IDs returned from **cancel reshop** (when present):

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderQuoteRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:cns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
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
    &lt;Payload&gt;
        &lt;ExistingOrder xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
        &lt;/ExistingOrder&gt;
        &lt;SelectedOffers xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OfferRefID&gt;9fe9409f-0382-4cb0-95c9-39a5a88b18c3&lt;/OfferRefID&gt;
            &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;ccf1eb58-fd5a-4a5c-b4a8-8f5c0dbf9629&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;217478a5-02e5-473a-877d-a164e79b2c1d&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX2&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
            &lt;SelectedOfferItem&gt;
                &lt;OfferItemRefID&gt;a1ae82a1-d2f4-48ee-9983-9ff5dbd152b3&lt;/OfferItemRefID&gt;
                &lt;PaxRefID&gt;PAX3&lt;/PaxRefID&gt;
            &lt;/SelectedOfferItem&gt;
        &lt;/SelectedOffers&gt;
    &lt;/Payload&gt;
    &lt;PayloadAttributes&gt;
        &lt;CorrelationID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;{{$randomUUID}}&lt;/CorrelationID&gt;
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2026-05-07T14:18:37.817+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
&lt;/IATA_OrderQuoteRQ&gt;
</code></pre>

</details>

### OrderQuote — Booking (confirm on-hold)
{: #orderquote-booking}

Use **`ExistingOrder`** = held booking UUID and **`SelectedOffers`** from a **fresh shop/price** or quoted offer set after retrieve:

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderQuoteRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; &gt;
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
    &lt;Payload&gt;
        &lt;ExistingOrder xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
        &lt;/ExistingOrder&gt;
    &lt;/Payload&gt;
    &lt;PayloadAttributes&gt;
        &lt;CorrelationID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;{{$randomUUID}}&lt;/CorrelationID&gt;
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2025-12-30T11:59:48.784+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
&lt;/IATA_OrderQuoteRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderReshopRS` XML document with order quote information.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderReshopRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;DataLists&gt;
            &lt;ContactInfoList&gt;
                &lt;ContactInfo&gt;
                    &lt;EmailAddress&gt;
                        &lt;EmailAddressText&gt;sample@a.com&lt;/EmailAddressText&gt;
                    &lt;/EmailAddress&gt;
                    &lt;Individual&gt;
                        &lt;Birthdate&gt;2026-02-02&lt;/Birthdate&gt;
                        &lt;GivenName&gt;Firstname&lt;/GivenName&gt;
                        &lt;Surname&gt;Surname&lt;/Surname&gt;
                        &lt;TitleName&gt;Mr&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;Phone&gt;
                        &lt;CountryDialingCode&gt;66&lt;/CountryDialingCode&gt;
                        &lt;PhoneNumber&gt;12345960&lt;/PhoneNumber&gt;
                    &lt;/Phone&gt;
                    &lt;PostalAddress&gt;
                        &lt;CityName&gt;TEST&lt;/CityName&gt;
                        &lt;CountryCode&gt;TH&lt;/CountryCode&gt;
                        &lt;PostalCode&gt;10210&lt;/PostalCode&gt;
                    &lt;/PostalAddress&gt;
                &lt;/ContactInfo&gt;
            &lt;/ContactInfoList&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-17T19:00:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-17T18:10:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;KRP&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                &lt;/DatedMarketingSegment&gt;
            &lt;/DatedMarketingSegmentList&gt;
            &lt;DatedOperatingSegmentList&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS1&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;9901&lt;/OperatingCarrierFlightNumberText&gt;
                &lt;/DatedOperatingSegment&gt;
            &lt;/DatedOperatingSegmentList&gt;
            &lt;OriginDestList&gt;
                &lt;OriginDest&gt;
                    &lt;DestCode&gt;CPH&lt;/DestCode&gt;
                    &lt;OriginCode&gt;KRP&lt;/OriginCode&gt;
                    &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
                    &lt;PaxJourneyRefID&gt;JOUR1&lt;/PaxJourneyRefID&gt;
                &lt;/OriginDest&gt;
            &lt;/OriginDestList&gt;
            &lt;PaxJourneyList&gt;
                &lt;PaxJourney&gt;
                    &lt;Duration&gt;PT50M&lt;/Duration&gt;
                    &lt;PaxJourneyID&gt;JOUR1&lt;/PaxJourneyID&gt;
                    &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                &lt;/PaxJourney&gt;
            &lt;/PaxJourneyList&gt;
            &lt;PaxList&gt;
                &lt;Pax&gt;
                    &lt;Birthdate&gt;2026-01-01&lt;/Birthdate&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;IdentityDoc&gt;
                        &lt;ExpiryDate&gt;2029-08-13&lt;/ExpiryDate&gt;
                        &lt;IdentityDocID&gt;0123456780&lt;/IdentityDocID&gt;
                        &lt;IdentityDocTypeCode&gt;PP&lt;/IdentityDocTypeCode&gt;
                        &lt;IssuingCountryCode&gt;GB&lt;/IssuingCountryCode&gt;
                    &lt;/IdentityDoc&gt;
                    &lt;Individual&gt;
                        &lt;Birthdate&gt;2026-01-01&lt;/Birthdate&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Baby&lt;/GivenName&gt;
                        &lt;IndividualID&gt;a1e9d4e1-66a5-4627-85de-137cc22eb3ba&lt;/IndividualID&gt;
                        &lt;Surname&gt;Wayne&lt;/Surname&gt;
                        &lt;TitleName&gt;MR&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;PaxID&gt;PAX1&lt;/PaxID&gt;
                    &lt;PTC&gt;INF&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;Birthdate&gt;1994-12-08&lt;/Birthdate&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;IdentityDoc&gt;
                        &lt;ExpiryDate&gt;2029-08-13&lt;/ExpiryDate&gt;
                        &lt;IdentityDocID&gt;0123456789&lt;/IdentityDocID&gt;
                        &lt;IdentityDocTypeCode&gt;PP&lt;/IdentityDocTypeCode&gt;
                        &lt;IssuingCountryCode&gt;GB&lt;/IssuingCountryCode&gt;
                    &lt;/IdentityDoc&gt;
                    &lt;Individual&gt;
                        &lt;Birthdate&gt;1994-12-08&lt;/Birthdate&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Bruce&lt;/GivenName&gt;
                        &lt;IndividualID&gt;635e29c9-3195-4587-ba8b-7e001780c7d0&lt;/IndividualID&gt;
                        &lt;Surname&gt;Wayne&lt;/Surname&gt;
                        &lt;TitleName&gt;MR&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;PaxID&gt;PAX2&lt;/PaxID&gt;
                    &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
                    &lt;PTC&gt;ADT&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;Birthdate&gt;2020-01-01&lt;/Birthdate&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;IdentityDoc&gt;
                        &lt;ExpiryDate&gt;2029-08-13&lt;/ExpiryDate&gt;
                        &lt;IdentityDocID&gt;0123456789&lt;/IdentityDocID&gt;
                        &lt;IdentityDocTypeCode&gt;PP&lt;/IdentityDocTypeCode&gt;
                        &lt;IssuingCountryCode&gt;GB&lt;/IssuingCountryCode&gt;
                    &lt;/IdentityDoc&gt;
                    &lt;Individual&gt;
                        &lt;Birthdate&gt;2020-01-01&lt;/Birthdate&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Child&lt;/GivenName&gt;
                        &lt;IndividualID&gt;27084b36-ce1d-4c3d-a3fc-da739600bb05&lt;/IndividualID&gt;
                        &lt;Surname&gt;Wayne&lt;/Surname&gt;
                        &lt;TitleName&gt;MR&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;PaxID&gt;PAX3&lt;/PaxID&gt;
                    &lt;PTC&gt;CHD&lt;/PTC&gt;
                &lt;/Pax&gt;
            &lt;/PaxList&gt;
            &lt;PaxSegmentList&gt;
                &lt;PaxSegment&gt;
                    &lt;DatedMarketingSegmentRefId&gt;DMS1&lt;/DatedMarketingSegmentRefId&gt;
                    &lt;OperatingCarrierRBD_Code&gt;DX&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
            &lt;/PaxSegmentList&gt;
            &lt;ServiceDefinitionList/&gt;
        &lt;/DataLists&gt;
        &lt;Order&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
        &lt;/Order&gt;
        &lt;ReshopResults&gt;
            &lt;NoChangeInd&gt;
                &lt;NoChangeInd&gt;true&lt;/NoChangeInd&gt;
            &lt;/NoChangeInd&gt;
        &lt;/ReshopResults&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;639ab93d-d54c-4155-8a91-6794d3e81f83&lt;/CorrelationID&gt;
        &lt;Timestamp&gt;2025-12-30T11:59:48.784+07:00&lt;/Timestamp&gt;
        &lt;TrxID&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OrderReshopRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderReshopRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;12&lt;/Code&gt;
        &lt;DescText&gt;Order is not paid : d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/DescText&gt;
        &lt;ErrorID&gt;8d9efeac-91ab-44d4-99a9-3c15a866b046&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderReshopRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderQuote \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderquote-request.xml
    ```

## Notes

1. **Prerequisites**: You must have an existing order (from `OrderCreate`) and new offers (from `AirShopping`).
2. **Order Status**: The existing order must be in `OPEN` status to get a quote.
3. **Use Case**: Use this API to get pricing before actually modifying an order with `OrderChange`.
4. **Response Format**: The response is an `OrderReshopRS` format, similar to reshop operations.
5. **Next Steps**: After getting the quote, use `OrderChange` with the same offer references to apply the changes.
