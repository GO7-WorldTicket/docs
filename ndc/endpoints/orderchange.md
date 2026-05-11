---
layout: go7
title: Order Change (OrderChange)
---

# Order Change

`POST` `https://api.go7.io/v21.3.5/OrderChange`

---

## Description

The Order Change API processes modifications to existing orders. It can be used to:
- Process payment for on-hold (DRAFT status) bookings
- Rebook flights with new offers
- Cancel segments
- Add or remove services

The API validates the order status, processes the changes, and returns the updated order details.

## Workflow (NDC API guide)

**Step 7** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderChange` · settle payment on **`DRAFT`**, or **`ChangeOrderChoice`** + **`PaymentFunctions`** after a quote ([**Rebook with New Offers**](#orderchange-rebook)). Fragments: **`#orderchange-payment-on-hold`**, **`#orderchange-payment-debit`**, **`#orderchange-payment-credit`**, **`#orderchange-rebook`**.

See [Authentication](../NDC_API.md#authentication) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`** on gateway XML calls.

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

The request body must be a valid `IATA_OrderChangeRQ` XML document following IATA NDC v21.3.5 standard.

### Process Payment for On-Hold Booking
{: #orderchange-payment-on-hold}
<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderChangeRQ
        xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;&gt;
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
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2025-12-30T11:59:48.784+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456789&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;POS&gt;
        &lt;Country xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;CountryCode&gt;FR&lt;/CountryCode&gt;
        &lt;/Country&gt;
    &lt;/POS&gt;
    &lt;Request&gt;
        &lt;Order xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OwnerCode&gt;W2&lt;/OwnerCode&gt;
        &lt;/Order&gt;
        &lt;PaymentFunctions xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;PaymentProcessingDetails&gt;
                &lt;Amount CurCode=&quot;USD&quot;&gt;122.19&lt;/Amount&gt;
                &lt;PaymentMethod&gt;
                    &lt;OfflinePayment&gt;
                        &lt;PaymentTypeCode&gt;CA&lt;/PaymentTypeCode&gt;
                    &lt;/OfflinePayment&gt;
                &lt;/PaymentMethod&gt;
            &lt;/PaymentProcessingDetails&gt;
        &lt;/PaymentFunctions&gt;
    &lt;/Request&gt;
&lt;/IATA_OrderChangeRQ&gt;
</code></pre>

</details>

Same **`Order`** + **`PaymentFunctions`** envelope as above; only **`PaymentTypeCode`** differs (confirm codes with your airline / PADIS mapping).

### Payment with cash (`OfflinePayment`)
{: #orderchange-payment-cash}

```xml
<OfflinePayment>
    <PaymentTypeCode>CA</PaymentTypeCode>
</OfflinePayment>
```

### Payment with debit (`OfflinePayment`)
{: #orderchange-payment-debit}

```xml
<OfflinePayment>
    <PaymentTypeCode>DC</PaymentTypeCode>
</OfflinePayment>
```

### Payment with credit (`OfflinePayment`)
{: #orderchange-payment-credit}

```xml
<OfflinePayment>
    <PaymentTypeCode>CC</PaymentTypeCode>
</OfflinePayment>
```

### Rebook with New Offers
{: #orderchange-rebook}
<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderChangeRQ
        xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot;&gt;
    &lt;DistributionChain&gt;
        &lt;DistributionChainLink xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;Ordinal&gt;1&lt;/Ordinal&gt;
            &lt;OrgRole&gt;Seller&lt;/OrgRole&gt;
            &lt;ParticipatingOrg&gt;
                &lt;Name&gt;Travel Agency XYZ&lt;/Name&gt;
                &lt;OrgID&gt;Seller123&lt;/OrgID&gt;
            &lt;/ParticipatingOrg&gt;
        &lt;/DistributionChainLink&gt;
    &lt;/DistributionChain&gt;
    &lt;PayloadAttributes&gt;
        &lt;CorrelationID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;{{$randomUUID}}&lt;/CorrelationID&gt;
        &lt;Timestamp xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;2026-05-07T13:35:51.653+07:00&lt;/Timestamp&gt;
        &lt;TrxID xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;TRX-123456790&lt;/TrxID&gt;
        &lt;VersionNumber xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;21.3&lt;/VersionNumber&gt;
    &lt;/PayloadAttributes&gt;
    &lt;POS&gt;
        &lt;Country xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;CountryCode&gt;FR&lt;/CountryCode&gt;
        &lt;/Country&gt;
    &lt;/POS&gt;
    &lt;Request&gt;
        &lt;ChangeOrderChoice xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;AcceptSelectedQuotedOfferList&gt;
                &lt;SelectedPricedOffer&gt;
                    &lt;OfferRefID&gt;351b2a94-83d1-4347-8bbe-8844a4c76cb0&lt;/OfferRefID&gt;
                    &lt;OwnerCode&gt;VS&lt;/OwnerCode&gt;
                    &lt;SelectedOfferItem&gt;
                        &lt;OfferItemRefID&gt;2afd921a-885f-49bb-93ae-5c279660384c&lt;/OfferItemRefID&gt;
                        &lt;PaxRefID&gt;ADT1&lt;/PaxRefID&gt;
                    &lt;/SelectedOfferItem&gt;
                    &lt;SelectedOfferItem&gt;
                        &lt;OfferItemRefID&gt;66b0aad9-048a-4d1e-bee6-124a1bda2baa&lt;/OfferItemRefID&gt;
                        &lt;PaxRefID&gt;CHD1&lt;/PaxRefID&gt;
                    &lt;/SelectedOfferItem&gt;
                    &lt;SelectedOfferItem&gt;
                        &lt;OfferItemRefID&gt;e8469306-5a16-41a0-bc62-aa98b5b03184&lt;/OfferItemRefID&gt;
                        &lt;PaxRefID&gt;INF1&lt;/PaxRefID&gt;
                    &lt;/SelectedOfferItem&gt;
                &lt;/SelectedPricedOffer&gt;
            &lt;/AcceptSelectedQuotedOfferList&gt;
        &lt;/ChangeOrderChoice&gt;
        &lt;Order xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;OrderID&gt;d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6&lt;/OrderID&gt;
            &lt;OwnerCode&gt;W2&lt;/OwnerCode&gt;
        &lt;/Order&gt;
        &lt;PaymentFunctions xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot;&gt;
            &lt;PaymentProcessingDetails&gt;
                &lt;Amount CurCode=&quot;USD&quot;&gt;122.19&lt;/Amount&gt;
                &lt;PaymentMethod&gt;
                    &lt;OfflinePayment&gt;
                        &lt;PaymentTypeCode&gt;CA&lt;/PaymentTypeCode&gt;
                    &lt;/OfflinePayment&gt;
                &lt;/PaymentMethod&gt;
            &lt;/PaymentProcessingDetails&gt;
        &lt;/PaymentFunctions&gt;
    &lt;/Request&gt;
&lt;/IATA_OrderChangeRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with updated order details.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
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
                &lt;StatusCode&gt;ACTIVE&lt;/StatusCode&gt;
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
                &lt;StatusCode&gt;ACTIVE&lt;/StatusCode&gt;
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
                &lt;StatusCode&gt;ACTIVE&lt;/StatusCode&gt;
            &lt;/OrderItem&gt;
            &lt;StatusCode&gt;OPEN&lt;/StatusCode&gt;
            &lt;TotalPrice&gt;
                &lt;BaseAmount CurCode=&quot;USD&quot;&gt;122.19&lt;/BaseAmount&gt;
                &lt;TaxSummary&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;2.31&lt;/Amount&gt;
                        &lt;TaxCode&gt;DC&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;4.07&lt;/Amount&gt;
                        &lt;TaxCode&gt;EU&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                    &lt;Tax&gt;
                        &lt;Amount CurCode=&quot;USD&quot;&gt;0.64&lt;/Amount&gt;
                        &lt;TaxCode&gt;QQ&lt;/TaxCode&gt;
                    &lt;/Tax&gt;
                    &lt;TotalTaxAmount CurCode=&quot;USD&quot;&gt;7.02&lt;/TotalTaxAmount&gt;
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
                &lt;OrgID&gt;Seller123&lt;/OrgID&gt;
            &lt;/ParticipatingOrg&gt;
        &lt;/DistributionChainLink&gt;
    &lt;/ns2:DistributionChain&gt;
    &lt;ns2:PayloadAttributes&gt;
        &lt;CorrelationID&gt;858e5019-0050-4415-984f-f3506492fcf3&lt;/CorrelationID&gt;
        &lt;Timestamp&gt;2026-05-07T13:35:51.653+07:00&lt;/Timestamp&gt;
        &lt;TrxID&gt;TRX-123456790&lt;/TrxID&gt;
        &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
    &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request, missing required fields, or order not in DRAFT status.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;13&lt;/Code&gt;
        &lt;DescText&gt;Reshop offer ID is required for CONFIRM_REBOOK_AND_PAY&lt;/DescText&gt;
        &lt;ErrorID&gt;2acab829-02ed-4007-9694-dcf84b1fc9af&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TagText&gt;OrderChangeRQ/Request/ChangeOrderChoice/AcceptSelectedQuotedOfferList/SelectedPricedOffer/OfferRefID&lt;/TagText&gt;
        &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

#### 404 Not Found

Order not found.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
    &lt;ns2:Error&gt;
        &lt;Code&gt;911&lt;/Code&gt;
        &lt;DescText&gt;Order not found - Order with id 014a8d0c-74a6-4c3c-801b-8f9e17cf21c6 not found&lt;/DescText&gt;
        &lt;ErrorID&gt;64669f43-2d30-4d86-a1a8-05dec018e03b&lt;/ErrorID&gt;
        &lt;LangCode&gt;EN&lt;/LangCode&gt;
        &lt;TypeCode&gt;Business&lt;/TypeCode&gt;
    &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderChange \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderchange-request.xml
    ```

## Workflow

### Processing Payment for On-Hold Booking

1. Order must be in `DRAFT` status (created with `OrderCreate` without `PaymentFunctions`)
2. Call `OrderChange` with `OrderID` and `PaymentFunctions`
3. System processes payment and polls order status until `OPEN`
4. Response returns confirmed order with tickets issued

### Rebooking

1. Get new offers using `AirShopping`
2. Get quote using `OrderQuote` (optional)
3. Call `OrderChange` with `ChangeOrderChoice` and new offers
4. Include `PaymentFunctions` if additional payment is required
5. Response returns updated order

## Notes

1. **Order Status**: For payment processing, order must be in `DRAFT` status.
2. **Payment Processing**: The system automatically polls order status until tickets are issued (`OPEN` status).
3. **Rebooking**: Use `ChangeOrderChoice` with new offers to rebook flights.
4. **Payment Methods**: Supported payment types depend on airline configuration.
5. **Order ID**: Always use the `OrderID` from the original `OrderCreate` response.
