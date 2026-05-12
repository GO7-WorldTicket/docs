---
layout: go7
title: Order Retrieve (OrderRetrieve)
---

# Order Retrieve

`POST` `https://api.go7.io/v21.3.5/OrderRetrieve`

---

## Description

The Order Retrieve API returns the current view of an existing order. Use the `OrderID` returned by `OrderCreate` for a direct lookup, or use `BookingID` when retrieving by booking reference / record locator. The response is an `IATA_OrderViewRS` XML document.

## Workflow (NDC API guide)

**Step 6** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderRetrieve` · send `IATA_OrderRetrieveRQ` with either **`OrderID`** or **`BookingID`**. The gateway returns **`IATA_OrderViewRS`**. Scenarios: **`#orderretrieve-by-order-id`**, **`#orderretrieve-by-booking-reference`**.

See [Authentication](../NDC_API.md#authentication) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Purpose | Format | Required | Example                         |
|--------|---------|--------|----------|---------------------------------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | Yes | `x-tenant: test-qa-rc`          |
| `x-SalesChannel` | Specifies the sales channel (maps to account IDs per tenant configuration) | String (e.g., `NDC`, `IBE`) | Yes | `x-SalesChannel: NDC`           |
| `x-api-key` | API key for authenticating the request | String | Yes | `x-api-key: {x-api-key}`        |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

**Note:** The `x-SalesChannel` value is used to determine the account ID based on tenant configuration.

## Request Body

The request body must be a valid `IATA_OrderRetrieveRQ` XML document following IATA NDC v21.3.5 standard.

Provide either `OrderID` or `BookingID`. If both are present, the gateway uses `OrderID`.

### OrderRetrieve — By Order ID
{: #orderretrieve-by-order-id}

Use `OrderID` for direct retrieval when you have the order identifier from `OrderCreateRS` / `OrderViewRS`.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderRetrieveRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;
        xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;ns2:DistributionChainLink&gt;
            &lt;ns2:Ordinal&gt;1&lt;/ns2:Ordinal&gt;
            &lt;ns2:OrgRole&gt;Seller&lt;/ns2:OrgRole&gt;
            &lt;ns2:ParticipatingOrg&gt;
                &lt;ns2:Name&gt;Travel Agency XYZ&lt;/ns2:Name&gt;
                &lt;ns2:OrgID&gt;SELLER123&lt;/ns2:OrgID&gt;
            &lt;/ns2:ParticipatingOrg&gt;
        &lt;/ns2:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;ns2:CorrelationID&gt;c46f2365-b1be-4df2-b472-17389ee9ac00&lt;/ns2:CorrelationID&gt;
        &lt;ns2:Timestamp&gt;2025-11-05T10:00:00Z&lt;/ns2:Timestamp&gt;
        &lt;ns2:TrxID&gt;TRX-123456789&lt;/ns2:TrxID&gt;
        &lt;ns2:VersionNumber&gt;21.3&lt;/ns2:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;ns2:OrderValidationFilterCriteria&gt;
            &lt;ns2:OrderFilterCriteria&gt;
                &lt;ns2:OrderID&gt;8d5deca7-5e1f-4203-b5a9-aa79029fe33d&lt;/ns2:OrderID&gt;
                &lt;ns2:OwnerCode&gt;VS&lt;/ns2:OwnerCode&gt;
            &lt;/ns2:OrderFilterCriteria&gt;
        &lt;/ns2:OrderValidationFilterCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_OrderRetrieveRQ&gt;
</code></pre>

</details>

### OrderRetrieve — By Booking Reference
{: #orderretrieve-by-booking-reference}

Use `BookingID` when retrieving by booking reference / record locator.

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderRetrieveRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;ns2:DistributionChainLink&gt;
            &lt;ns2:Ordinal&gt;1&lt;/ns2:Ordinal&gt;
            &lt;ns2:OrgRole&gt;Seller&lt;/ns2:OrgRole&gt;
            &lt;ns2:ParticipatingOrg&gt;
                &lt;ns2:Name&gt;Travel Agency XYZ&lt;/ns2:Name&gt;
                &lt;ns2:OrgID&gt;SELLER123&lt;/ns2:OrgID&gt;
            &lt;/ns2:ParticipatingOrg&gt;
        &lt;/ns2:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;ns2:CorrelationID&gt;{{$randomUUID}}&lt;/ns2:CorrelationID&gt;
        &lt;ns2:Timestamp&gt;2025-11-05T10:00:00Z&lt;/ns2:Timestamp&gt;
        &lt;ns2:TrxID&gt;TRX-123456789&lt;/ns2:TrxID&gt;
        &lt;ns2:VersionNumber&gt;21.3&lt;/ns2:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;Request&gt;
        &lt;ns2:OrderValidationFilterCriteria&gt;
            &lt;ns2:BookingRefFilterCriteria&gt;
                &lt;ns2:BookingID&gt;CSHUNH&lt;/ns2:BookingID&gt;
            &lt;/ns2:BookingRefFilterCriteria&gt;
        &lt;/ns2:OrderValidationFilterCriteria&gt;
    &lt;/Request&gt;
&lt;/IATA_OrderRetrieveRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with the retrieved order details.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Response&gt;
        &lt;DataLists&gt;
            &lt;DatedMarketingSegmentList&gt;
                &lt;DatedMarketingSegment&gt;
                    &lt;Arrival&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-27T07:00:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
                    &lt;/Arrival&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
                    &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
                    &lt;Dep&gt;
                        &lt;AircraftScheduledDateTime&gt;2026-05-27T06:00:00&lt;/AircraftScheduledDateTime&gt;
                        &lt;IATA_LocationCode&gt;KRP&lt;/IATA_LocationCode&gt;
                    &lt;/Dep&gt;
                    &lt;MarketingCarrierFlightNumberText&gt;500&lt;/MarketingCarrierFlightNumberText&gt;
                &lt;/DatedMarketingSegment&gt;
            &lt;/DatedMarketingSegmentList&gt;
            &lt;DatedOperatingSegmentList&gt;
                &lt;DatedOperatingSegment&gt;
                    &lt;CarrierDesigCode&gt;W2&lt;/CarrierDesigCode&gt;
                    &lt;DatedOperatingSegmentId&gt;DOS1&lt;/DatedOperatingSegmentId&gt;
                    &lt;OperatingCarrierFlightNumberText&gt;500&lt;/OperatingCarrierFlightNumberText&gt;
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
                    &lt;PaxJourneyID&gt;JOUR1&lt;/PaxJourneyID&gt;
                    &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                &lt;/PaxJourney&gt;
            &lt;/PaxJourneyList&gt;
            &lt;PaxList&gt;
                &lt;Pax&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;Individual&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Bruce&lt;/GivenName&gt;
                        &lt;IndividualID&gt;72aa9ff5-e62b-4c20-a0ad-afafa3a160fe&lt;/IndividualID&gt;
                        &lt;Surname&gt;Wayne&lt;/Surname&gt;
                        &lt;TitleName&gt;MR&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;PaxID&gt;PAX1&lt;/PaxID&gt;
                    &lt;PaxRefID&gt;PAX2&lt;/PaxRefID&gt;
                    &lt;PTC&gt;ADT&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;Individual&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Baby&lt;/GivenName&gt;
                        &lt;IndividualID&gt;a8a65d26-7b2a-4d8f-94bf-f769b4358efc&lt;/IndividualID&gt;
                        &lt;Surname&gt;Wayne&lt;/Surname&gt;
                        &lt;TitleName&gt;MR&lt;/TitleName&gt;
                    &lt;/Individual&gt;
                    &lt;PaxID&gt;PAX2&lt;/PaxID&gt;
                    &lt;PTC&gt;INF&lt;/PTC&gt;
                &lt;/Pax&gt;
                &lt;Pax&gt;
                    &lt;CitizenshipCountryCode&gt;&lt;/CitizenshipCountryCode&gt;
                    &lt;Individual&gt;
                        &lt;GenderCode&gt;M&lt;/GenderCode&gt;
                        &lt;GivenName&gt;Child&lt;/GivenName&gt;
                        &lt;IndividualID&gt;0ea6e3bc-7be9-40ac-854b-9a2c0c7b53c1&lt;/IndividualID&gt;
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
                    &lt;MarketingCarrierRBD_Code&gt;W2&lt;/MarketingCarrierRBD_Code&gt;
                    &lt;OperatingCarrierRBD_Code&gt;W2&lt;/OperatingCarrierRBD_Code&gt;
                    &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
                &lt;/PaxSegment&gt;
            &lt;/PaxSegmentList&gt;
            &lt;ServiceDefinitionList/&gt;
        &lt;/DataLists&gt;
        &lt;Order&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OrderItem&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;VAT_DC&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;VAT_EU&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;DC&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;2.04&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;EU&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;4.07&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;Base Fare&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;34.62&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;VAT&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;GrandTotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/GrandTotalAmount&gt;
                &lt;OrderItemID&gt;8064850f-de57-4226-a39b-f71213f400ff&lt;/OrderItemID&gt;
                &lt;OwnerCode&gt;W2&lt;/OwnerCode&gt;
                &lt;Price&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;34.62&lt;/BaseAmount&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;0.0&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;0.0&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;TaxSummary&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;2.04&lt;/Amount&gt;
                            &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                        &lt;/Tax&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;4.07&lt;/Amount&gt;
                            &lt;TaxCode&gt;EU&lt;/TaxCode&gt;
                        &lt;/Tax&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                &lt;/Price&gt;
                &lt;Service&gt;
                    &lt;BookingRef&gt;
                        &lt;BookingEntity&gt;
                            &lt;Carrier&gt;
                                &lt;AirlineDesigCode&gt;W2&lt;/AirlineDesigCode&gt;
                            &lt;/Carrier&gt;
                        &lt;/BookingEntity&gt;
                        &lt;BookingID&gt;CSHUNH&lt;/BookingID&gt;
                    &lt;/BookingRef&gt;
                    &lt;OrderServiceAssociation&gt;
                        &lt;PaxSegmentRef&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentRef&gt;
                    &lt;/OrderServiceAssociation&gt;
                    &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
                &lt;/Service&gt;
                &lt;StatusCode&gt;CANCELLED&lt;/StatusCode&gt;
            &lt;/OrderItem&gt;
            &lt;OrderItem&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;Base Fare&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;VAT&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;GrandTotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/GrandTotalAmount&gt;
                &lt;OrderItemID&gt;1be3dfac-d292-4061-84e9-be8ee968bc43&lt;/OrderItemID&gt;
                &lt;OwnerCode&gt;W2&lt;/OwnerCode&gt;
                &lt;Price&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/BaseAmount&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                &lt;/Price&gt;
                &lt;Service&gt;
                    &lt;BookingRef&gt;
                        &lt;BookingEntity&gt;
                            &lt;Carrier&gt;
                                &lt;AirlineDesigCode&gt;W2&lt;/AirlineDesigCode&gt;
                            &lt;/Carrier&gt;
                        &lt;/BookingEntity&gt;
                        &lt;BookingID&gt;CSHUNH&lt;/BookingID&gt;
                    &lt;/BookingRef&gt;
                    &lt;OrderServiceAssociation&gt;
                        &lt;PaxSegmentRef&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentRef&gt;
                    &lt;/OrderServiceAssociation&gt;
                    &lt;PaxRefID&gt;PAX2&lt;/PaxRefID&gt;
                &lt;/Service&gt;
                &lt;StatusCode&gt;CANCELLED&lt;/StatusCode&gt;
            &lt;/OrderItem&gt;
            &lt;OrderItem&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;VAT_DC&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;VAT_QQ&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;DC&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.27&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;AccountCode&gt;QQ&lt;/AccountCode&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0.64&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;Base Fare&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;39.82&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;FareDetail&gt;
                    &lt;FareRefText&gt;VAT&lt;/FareRefText&gt;
                    &lt;Price&gt;
                        &lt;TotalAmount CurCode=&quot;USD&quot;&gt;0&lt;/TotalAmount&gt;
                    &lt;/Price&gt;
                &lt;/FareDetail&gt;
                &lt;GrandTotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/GrandTotalAmount&gt;
                &lt;OrderItemID&gt;a48f7f60-115e-4faf-baaf-e84a15eb294e&lt;/OrderItemID&gt;
                &lt;OwnerCode&gt;W2&lt;/OwnerCode&gt;
                &lt;Price&gt;
                    &lt;BaseAmount CurCode=&quot;USD&quot;&gt;39.82&lt;/BaseAmount&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;0.0&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;Fee&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;0.0&lt;/Amount&gt;
                    &lt;/Fee&gt;
                    &lt;TaxSummary&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;0.27&lt;/Amount&gt;
                            &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                        &lt;/Tax&gt;
                        &lt;Tax&gt;
                            &lt;Amount CurCode=&quot;USD&quot;&gt;0.64&lt;/Amount&gt;
                            &lt;TaxCode&gt;QQ&lt;/TaxCode&gt;
                        &lt;/Tax&gt;
                    &lt;/TaxSummary&gt;
                    &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
                &lt;/Price&gt;
                &lt;Service&gt;
                    &lt;BookingRef&gt;
                        &lt;BookingEntity&gt;
                            &lt;Carrier&gt;
                                &lt;AirlineDesigCode&gt;W2&lt;/AirlineDesigCode&gt;
                            &lt;/Carrier&gt;
                        &lt;/BookingEntity&gt;
                        &lt;BookingID&gt;CSHUNH&lt;/BookingID&gt;
                    &lt;/BookingRef&gt;
                    &lt;OrderServiceAssociation&gt;
                        &lt;PaxSegmentRef&gt;
                            &lt;PaxSegmentRefID&gt;SEG1&lt;/PaxSegmentRefID&gt;
                        &lt;/PaxSegmentRef&gt;
                    &lt;/OrderServiceAssociation&gt;
                    &lt;PaxRefID&gt;PAX3&lt;/PaxRefID&gt;
                &lt;/Service&gt;
                &lt;StatusCode&gt;CANCELLED&lt;/StatusCode&gt;
            &lt;/OrderItem&gt;
            &lt;StatusCode&gt;OPEN&lt;/StatusCode&gt;
            &lt;TotalPrice&gt;
                &lt;BaseAmount CurCode=&quot;USD&quot;&gt;115.17&lt;/BaseAmount&gt;
                &lt;TaxSummary&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;-4.07&lt;/Amount&gt;
                        &lt;TaxCode&gt;EU&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;-0.64&lt;/Amount&gt;
                        &lt;TaxCode&gt;QQ&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;-2.31&lt;/Amount&gt;
                        &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                &lt;/TaxSummary&gt;
                &lt;TotalAmount CurCode=&quot;USD&quot;&gt;122.19&lt;/TotalAmount&gt;
            &lt;/TotalPrice&gt;
        &lt;/Order&gt;
        &lt;TicketDocInfo&gt;
            &lt;BookletQty&gt;1&lt;/BookletQty&gt;
            &lt;OriginDest&gt;
                &lt;DestCode&gt;CPH&lt;/DestCode&gt;
                &lt;OriginCode&gt;KRP&lt;/OriginCode&gt;
                &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
            &lt;/OriginDest&gt;
            &lt;PaxRefID&gt;PAX1&lt;/PaxRefID&gt;
            &lt;Ticket&gt;
                &lt;TicketNumber&gt;2772770026753&lt;/TicketNumber&gt;
            &lt;/Ticket&gt;
        &lt;/TicketDocInfo&gt;
        &lt;TicketDocInfo&gt;
            &lt;BookletQty&gt;1&lt;/BookletQty&gt;
            &lt;OriginDest&gt;
                &lt;DestCode&gt;CPH&lt;/DestCode&gt;
                &lt;OriginCode&gt;KRP&lt;/OriginCode&gt;
                &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
            &lt;/OriginDest&gt;
            &lt;PaxRefID&gt;PAX2&lt;/PaxRefID&gt;
            &lt;Ticket&gt;
                &lt;TicketNumber&gt;2772770026754&lt;/TicketNumber&gt;
            &lt;/Ticket&gt;
        &lt;/TicketDocInfo&gt;
        &lt;TicketDocInfo&gt;
            &lt;BookletQty&gt;1&lt;/BookletQty&gt;
            &lt;OriginDest&gt;
                &lt;DestCode&gt;CPH&lt;/DestCode&gt;
                &lt;OriginCode&gt;KRP&lt;/OriginCode&gt;
                &lt;OriginDestID&gt;OD1&lt;/OriginDestID&gt;
            &lt;/OriginDest&gt;
            &lt;PaxRefID&gt;PAX3&lt;/PaxRefID&gt;
            &lt;Ticket&gt;
                &lt;TicketNumber&gt;2772770026755&lt;/TicketNumber&gt;
            &lt;/Ticket&gt;
        &lt;/TicketDocInfo&gt;
    &lt;/ns2:Response&gt;
    &lt;ns2:DistributionChain&gt;
        &lt;DistributionChainLink&gt;
            &lt;Ordinal&gt;1&lt;/Ordinal&gt;
            &lt;OrgRole&gt;Seller&lt;/OrgRole&gt;
            &lt;ParticipatingOrg&gt;
                &lt;Name&gt;Travel Agency XYZ&lt;/Name&gt;
                &lt;OrgID&gt;SELLER123&lt;/OrgID&gt;
            &lt;/ParticipatingOrg&gt;
        &lt;/DistributionChainLink&gt;
    &lt;/ns2:DistributionChain&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;f5b3f69c-e78c-4353-9530-960f7f0496d4&lt;/CorrelationID&gt;
        &lt;Timestamp&gt;2025-11-05T10:00:00Z&lt;/Timestamp&gt;
        &lt;TrxID&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid XML, missing retrieve criteria, or an `OrderID` value that is not a valid UUID.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;914&lt;/Code&gt;
        &lt;DescText&gt;no record locator found&lt;/DescText&gt;
        &lt;ErrorID&gt;244cc6d4-da58-4f4f-9b47-fc55ef4e521c&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

#### 404 Not Found

Order or booking reference not found.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;911&lt;/Code&gt;
        &lt;DescText&gt;Order not found - Order by recordLocator [CSHUNB] with lastName [null] not found.&lt;/DescText&gt;
        &lt;ErrorID&gt;9c2df809-13f9-4cd0-8803-9df888ac694f&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TypeCode&gt;Business&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderRetrieve \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderretrieve-request.xml
    ```

## Notes

1. **Retrieve by Order ID**: Use `OrderID` from a previous `OrderCreate` or `OrderViewRS` response whenever available.
2. **Retrieve by Booking Reference**: Use `BookingID` when looking up by record locator.
3. **Lookup Priority**: If both `OrderID` and `BookingID` are provided, the gateway resolves the request by `OrderID`.
4. **Response Format**: The gateway returns XML `IATA_OrderViewRS`, not JSON.
