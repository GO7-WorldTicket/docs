---
layout: go7
title: Order Create (OrderCreate)
---

# Order Create

`POST` `https://api.go7.io/v21.3.5/OrderCreate`

---

## Description

The Order Create API creates a new booking order based on selected offers from an Offer Price response. Supports both pay-later (holding) bookings without PaymentFunctions and instant payment flows when payment details are provided. Returns an OrderViewRS response with order confirmation details.

## Workflow (NDC API guide)

**Step 3** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderCreate` · **`CreateOrder`** → **`AcceptSelectedQuotedOfferList`** using **`OfferRefID`** / **`OfferItemRefID`** / **`OwnerCode`** / **`PaxRefID`** from **OfferPriceRS**. Scenarios: **`#ordercreate-pay-later`**, **`#ordercreate-instant-pay`**.

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

The request body must be a valid `IATA_OrderCreateRQ` XML document following IATA NDC v21.3.5 standard.

### Pay Later (Holding) Booking
{: #ordercreate-pay-later}

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderCreateRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
   &lt;DistributionChain&gt;
      &lt;ns2:DistributionChainLink&gt;
         &lt;ns2:Ordinal&gt;1&lt;/ns2:Ordinal&gt;
         &lt;ns2:OrgRole&gt;Seller&lt;/ns2:OrgRole&gt;
         &lt;ns2:ParticipatingOrg&gt;
            &lt;ns2:Name&gt;Travel Agency XYZ&lt;/ns2:Name&gt;
            &lt;ns2:OrgID&gt;Seller123&lt;/ns2:OrgID&gt;
         &lt;/ns2:ParticipatingOrg&gt;
      &lt;/ns2:DistributionChainLink&gt;
   &lt;/DistributionChain&gt;
   &lt;PayloadAttributes&gt;
      &lt;ns2:CorrelationID&gt;{{$randomUUID}}&lt;/ns2:CorrelationID&gt;
      &lt;ns2:Timestamp&gt;{{today_th}}&lt;/ns2:Timestamp&gt;
      &lt;ns2:TrxID&gt;TRX-123456789&lt;/ns2:TrxID&gt;
      &lt;ns2:VersionNumber&gt;21.3&lt;/ns2:VersionNumber&gt;
   &lt;/PayloadAttributes&gt;
   &lt;POS&gt;
      &lt;ns2:Country&gt;
         &lt;ns2:CountryCode&gt;FR&lt;/ns2:CountryCode&gt;
      &lt;/ns2:Country&gt;
   &lt;/POS&gt;
   &lt;Request&gt;
      &lt;ns2:CreateOrder&gt;
         &lt;ns2:AcceptSelectedQuotedOfferList&gt;
            &lt;ns2:SelectedPricedOffer&gt;
               &lt;ns2:OfferRefID&gt;4601978f-9f7e-4412-bb98-9b561216cb52&lt;/ns2:OfferRefID&gt;
               &lt;ns2:OwnerCode&gt;VS&lt;/ns2:OwnerCode&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;fe9bdae0-c5d0-4d48-ab51-db60b32e3200:3017640a-4d85-492c-8aa8-0a28a18b785c&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX1&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;4b27e5c9-daa4-4950-951c-fbb6c56061e4:5ad9774a-f85a-4a84-af94-424819d3d53b&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX1&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;848b1060-64df-4880-b11f-9f9fff937c97:ed0780b5-0806-48af-99ac-5d35d0180d10&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX3&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
            &lt;/ns2:SelectedPricedOffer&gt;
         &lt;/ns2:AcceptSelectedQuotedOfferList&gt;
      &lt;/ns2:CreateOrder&gt;
      &lt;ns2:DataLists&gt;
         &lt;ns2:ContactInfoList&gt;
            &lt;ns2:ContactInfo&gt;
               &lt;ns2:ContactInfoID&gt;CTCPAX1_1&lt;/ns2:ContactInfoID&gt;
               &lt;ns2:EmailAddress&gt;
                  &lt;ns2:ContactTypeText&gt;Home&lt;/ns2:ContactTypeText&gt;
                  &lt;ns2:EmailAddressText&gt;sample@a.com&lt;/ns2:EmailAddressText&gt;
               &lt;/ns2:EmailAddress&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2026-02-02&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GivenName&gt;Firstname&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Surname&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;Mr&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:Phone&gt;
                  &lt;ns2:CountryDialingCode&gt;66&lt;/ns2:CountryDialingCode&gt;
                  &lt;ns2:PhoneNumber&gt;12345960&lt;/ns2:PhoneNumber&gt;
               &lt;/ns2:Phone&gt;
               &lt;ns2:PostalAddress&gt;
                  &lt;ns2:CityName&gt;TEST&lt;/ns2:CityName&gt;
                  &lt;ns2:CountryCode&gt;TH&lt;/ns2:CountryCode&gt;
                  &lt;ns2:PostalCode&gt;10210&lt;/ns2:PostalCode&gt;
               &lt;/ns2:PostalAddress&gt;
            &lt;/ns2:ContactInfo&gt;
         &lt;/ns2:ContactInfoList&gt;
         &lt;ns2:PaxList&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456789&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;1994-12-08&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Bruce&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX1&lt;/ns2:PaxID&gt;
               &lt;ns2:PaxRefID&gt;PAX3&lt;/ns2:PaxRefID&gt;
               &lt;ns2:PTC&gt;ADT&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456789&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2020-01-01&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Child&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX2&lt;/ns2:PaxID&gt;
               &lt;ns2:PTC&gt;CHD&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456780&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2026-01-01&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Baby&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX3&lt;/ns2:PaxID&gt;
               &lt;ns2:PTC&gt;INF&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
         &lt;/ns2:PaxList&gt;
      &lt;/ns2:DataLists&gt;
   &lt;/Request&gt;
&lt;/IATA_OrderCreateRQ&gt;
</code></pre>

</details>

Omit **`PaymentFunctions`** for pay-later: the order commonly returns **`DRAFT`** until paid. For **round-trip pay later**, add a second **`SelectedOfferItem`** for the inbound priced item.

### Instant Payment Booking
{: #ordercreate-instant-pay}

<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;IATA_OrderCreateRQ xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
   &lt;DistributionChain&gt;
      &lt;ns2:DistributionChainLink&gt;
         &lt;ns2:Ordinal&gt;1&lt;/ns2:Ordinal&gt;
         &lt;ns2:OrgRole&gt;Seller&lt;/ns2:OrgRole&gt;
         &lt;ns2:ParticipatingOrg&gt;
            &lt;ns2:Name&gt;Travel Agency XYZ&lt;/ns2:Name&gt;
            &lt;ns2:OrgID&gt;Seller123&lt;/ns2:OrgID&gt;
         &lt;/ns2:ParticipatingOrg&gt;
      &lt;/ns2:DistributionChainLink&gt;
   &lt;/DistributionChain&gt;
   &lt;PayloadAttributes&gt;
      &lt;ns2:CorrelationID&gt;{{$randomUUID}}&lt;/ns2:CorrelationID&gt;
      &lt;ns2:Timestamp&gt;2025-12-30T11:59:48.784+07:00&lt;/ns2:Timestamp&gt;
      &lt;ns2:TrxID&gt;TRX-123456789&lt;/ns2:TrxID&gt;
      &lt;ns2:VersionNumber&gt;21.3&lt;/ns2:VersionNumber&gt;
   &lt;/PayloadAttributes&gt;
   &lt;POS&gt;
      &lt;ns2:Country&gt;
         &lt;ns2:CountryCode&gt;FR&lt;/ns2:CountryCode&gt;
      &lt;/ns2:Country&gt;
   &lt;/POS&gt;
   &lt;Request&gt;
      &lt;ns2:CreateOrder&gt;
         &lt;ns2:AcceptSelectedQuotedOfferList&gt;
            &lt;ns2:SelectedPricedOffer&gt;
               &lt;ns2:OfferRefID&gt;9292c7a4-a0d6-4f30-befa-2c197def7ac9&lt;/ns2:OfferRefID&gt;
               &lt;ns2:OwnerCode&gt;VS&lt;/ns2:OwnerCode&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;982ec9bd-bcff-452d-a1e4-c1d4ba131eb8:46cd5362-2582-42bb-82e1-3fb260f1ac85&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX1&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;3cbc88b1-ab28-45c7-a4bf-6a52a2153c48:12b9a65a-35d3-4a3f-93d2-5160ffc16eca&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX1&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
               &lt;ns2:SelectedOfferItem&gt;
                  &lt;ns2:OfferItemRefID&gt;4e6be961-b8c4-4cec-8f9c-1d586e22f87f:b1226bf0-5901-4f48-977f-34089fbcec91&lt;/ns2:OfferItemRefID&gt;
                  &lt;ns2:PaxRefID&gt;PAX3&lt;/ns2:PaxRefID&gt;
               &lt;/ns2:SelectedOfferItem&gt;
            &lt;/ns2:SelectedPricedOffer&gt;
         &lt;/ns2:AcceptSelectedQuotedOfferList&gt;
      &lt;/ns2:CreateOrder&gt;
      &lt;ns2:DataLists&gt;
         &lt;ns2:ContactInfoList&gt;
            &lt;ns2:ContactInfo&gt;
               &lt;ns2:ContactInfoID&gt;CTCPAX1_1&lt;/ns2:ContactInfoID&gt;
               &lt;ns2:EmailAddress&gt;
                  &lt;ns2:ContactTypeText&gt;Home&lt;/ns2:ContactTypeText&gt;
                  &lt;ns2:EmailAddressText&gt;sample@a.com&lt;/ns2:EmailAddressText&gt;
               &lt;/ns2:EmailAddress&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2026-02-02&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GivenName&gt;Firstname&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Surname&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;Mr&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:Phone&gt;
                  &lt;ns2:CountryDialingCode&gt;66&lt;/ns2:CountryDialingCode&gt;
                  &lt;ns2:PhoneNumber&gt;12345960&lt;/ns2:PhoneNumber&gt;
               &lt;/ns2:Phone&gt;
               &lt;ns2:PostalAddress&gt;
                  &lt;ns2:CityName&gt;TEST&lt;/ns2:CityName&gt;
                  &lt;ns2:CountryCode&gt;TH&lt;/ns2:CountryCode&gt;
                  &lt;ns2:PostalCode&gt;10210&lt;/ns2:PostalCode&gt;
               &lt;/ns2:PostalAddress&gt;
            &lt;/ns2:ContactInfo&gt;
         &lt;/ns2:ContactInfoList&gt;
         &lt;ns2:PaxList&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456789&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;1994-12-08&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Bruce&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX1&lt;/ns2:PaxID&gt;
               &lt;ns2:PaxRefID&gt;PAX3&lt;/ns2:PaxRefID&gt;
               &lt;ns2:PTC&gt;ADT&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456789&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2020-01-01&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Child&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX2&lt;/ns2:PaxID&gt;
               &lt;ns2:PTC&gt;CHD&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
            &lt;ns2:Pax&gt;
               &lt;ns2:IdentityDoc&gt;
                  &lt;ns2:ExpiryDate&gt;2029-08-13&lt;/ns2:ExpiryDate&gt;
                  &lt;ns2:IdentityDocID&gt;0123456780&lt;/ns2:IdentityDocID&gt;
                  &lt;ns2:IdentityDocTypeCode&gt;PP&lt;/ns2:IdentityDocTypeCode&gt;
                  &lt;ns2:IssuingCountryCode&gt;GB&lt;/ns2:IssuingCountryCode&gt;
                  &lt;ns2:ResidenceCountryCode&gt;GB&lt;/ns2:ResidenceCountryCode&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
               &lt;/ns2:IdentityDoc&gt;
               &lt;ns2:Individual&gt;
                  &lt;ns2:Birthdate&gt;2026-01-01&lt;/ns2:Birthdate&gt;
                  &lt;ns2:GenderCode&gt;M&lt;/ns2:GenderCode&gt;
                  &lt;ns2:GivenName&gt;Baby&lt;/ns2:GivenName&gt;
                  &lt;ns2:Surname&gt;Wayne&lt;/ns2:Surname&gt;
                  &lt;ns2:TitleName&gt;MR&lt;/ns2:TitleName&gt;
               &lt;/ns2:Individual&gt;
               &lt;ns2:LangUsage&gt;
                  &lt;ns2:LangCode&gt;FR&lt;/ns2:LangCode&gt;
               &lt;/ns2:LangUsage&gt;
               &lt;ns2:PaxID&gt;PAX3&lt;/ns2:PaxID&gt;
               &lt;ns2:PTC&gt;INF&lt;/ns2:PTC&gt;
            &lt;/ns2:Pax&gt;
         &lt;/ns2:PaxList&gt;
      &lt;/ns2:DataLists&gt;
      &lt;ns2:PaymentFunctions&gt;
         &lt;ns2:PaymentProcessingDetails&gt;
            &lt;ns2:Amount CurCode=&quot;USD&quot;&gt;122.19&lt;/ns2:Amount&gt;
            &lt;ns2:PaymentMethod&gt;
               &lt;ns2:OfflinePayment&gt;
                  &lt;ns2:PaymentTypeCode&gt;CA&lt;/ns2:PaymentTypeCode&gt;
               &lt;/ns2:OfflinePayment&gt;
            &lt;/ns2:PaymentMethod&gt;
         &lt;/ns2:PaymentProcessingDetails&gt;
      &lt;/ns2:PaymentFunctions&gt;
   &lt;/Request&gt;
&lt;/IATA_OrderCreateRQ&gt;
</code></pre>

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with order confirmation details.

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
                  &lt;AircraftScheduledDateTime&gt;2026-05-17T19:00:00&lt;/AircraftScheduledDateTime&gt;
                  &lt;IATA_LocationCode&gt;CPH&lt;/IATA_LocationCode&gt;
               &lt;/Arrival&gt;
               &lt;CarrierDesigCode&gt;DX&lt;/CarrierDesigCode&gt;
               &lt;DatedMarketingSegmentId&gt;DMS1&lt;/DatedMarketingSegmentId&gt;
               &lt;DatedOperatingSegmentRefId&gt;DOS1&lt;/DatedOperatingSegmentRefId&gt;
               &lt;Dep&gt;
                  &lt;AircraftScheduledDateTime&gt;2026-05-17T18:10:00&lt;/AircraftScheduledDateTime&gt;
                  &lt;IATA_LocationCode&gt;KRP&lt;/IATA_LocationCode&gt;
               &lt;/Dep&gt;
               &lt;MarketingCarrierFlightNumberText&gt;9901&lt;/MarketingCarrierFlightNumberText&gt;
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
                  &lt;IndividualID&gt;c4f083ce-9e5c-4215-a3ab-8a94ecbe33e1&lt;/IndividualID&gt;
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
                  &lt;IndividualID&gt;4a645ced-20da-4327-abb2-5a638e3ebfc3&lt;/IndividualID&gt;
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
                  &lt;IndividualID&gt;a3e03f61-30d6-47ea-95fd-d2f1d513dffd&lt;/IndividualID&gt;
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
               &lt;MarketingCarrierRBD_Code&gt;DX&lt;/MarketingCarrierRBD_Code&gt;
               &lt;OperatingCarrierRBD_Code&gt;DX&lt;/OperatingCarrierRBD_Code&gt;
               &lt;PaxSegmentID&gt;SEG1&lt;/PaxSegmentID&gt;
            &lt;/PaxSegment&gt;
         &lt;/PaxSegmentList&gt;
         &lt;ServiceDefinitionList/&gt;
      &lt;/DataLists&gt;
      &lt;Order&gt;
         &lt;OrderID&gt;546d8e92-38a9-4908-a62c-dc92a0738202&lt;/OrderID&gt;
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
            &lt;OrderItemID&gt;85144767-48b1-4107-bb6a-8c6fc9fba5d5&lt;/OrderItemID&gt;
            &lt;OwnerCode&gt;DX&lt;/OwnerCode&gt;
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
                        &lt;AirlineDesigCode&gt;DX&lt;/AirlineDesigCode&gt;
                     &lt;/Carrier&gt;
                  &lt;/BookingEntity&gt;
                  &lt;BookingID&gt;XIP4LO&lt;/BookingID&gt;
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
            &lt;OrderItemID&gt;465b2e75-cd06-4ccf-8610-fc3f6c9b7c0a&lt;/OrderItemID&gt;
            &lt;OwnerCode&gt;DX&lt;/OwnerCode&gt;
            &lt;Price&gt;
               &lt;BaseAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/BaseAmount&gt;
               &lt;TotalAmount CurCode=&quot;USD&quot;&gt;40.73&lt;/TotalAmount&gt;
            &lt;/Price&gt;
            &lt;Service&gt;
               &lt;BookingRef&gt;
                  &lt;BookingEntity&gt;
                     &lt;Carrier&gt;
                        &lt;AirlineDesigCode&gt;DX&lt;/AirlineDesigCode&gt;
                     &lt;/Carrier&gt;
                  &lt;/BookingEntity&gt;
                  &lt;BookingID&gt;XIP4LO&lt;/BookingID&gt;
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
            &lt;OrderItemID&gt;4d34cc94-565a-426d-903d-7fa1f0755291&lt;/OrderItemID&gt;
            &lt;OwnerCode&gt;DX&lt;/OwnerCode&gt;
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
                        &lt;AirlineDesigCode&gt;DX&lt;/AirlineDesigCode&gt;
                     &lt;/Carrier&gt;
                  &lt;/BookingEntity&gt;
                  &lt;BookingID&gt;XIP4LO&lt;/BookingID&gt;
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
            &lt;TicketNumber&gt;2772770026748&lt;/TicketNumber&gt;
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
            &lt;TicketNumber&gt;2772770026749&lt;/TicketNumber&gt;
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
            &lt;TicketNumber&gt;2772770026750&lt;/TicketNumber&gt;
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
      &lt;CorrelationID&gt;acee4201-531c-4432-b726-542117b0d38a&lt;/CorrelationID&gt;
      &lt;Timestamp&gt;2025-12-30T11:59:48.784+07:00&lt;/Timestamp&gt;
      &lt;TrxID&gt;TRX-123456789&lt;/TrxID&gt;
      &lt;VersionNumber&gt;21.3&lt;/VersionNumber&gt;
   &lt;/ns2:PayloadAttributes&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

<pre><code class="language-xml">
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot; standalone=&quot;yes&quot;?&gt;
&lt;ns2:IATA_OrderViewRS xmlns=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes&quot; xmlns:ns2=&quot;http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage&quot; xmlns:ns3=&quot;http://www.w3.org/2000/09/xmldsig#&quot;&gt;
   &lt;ns2:Error&gt;
      &lt;Code&gt;914&lt;/Code&gt;
      &lt;DescText&gt;offerRefID must be present&lt;/DescText&gt;
      &lt;ErrorID&gt;3a1294b8-0f56-424b-b302-1bb66b040547&lt;/ErrorID&gt;
      &lt;LangCode&gt;EN&lt;/LangCode&gt;
      &lt;TypeCode&gt;Validation&lt;/TypeCode&gt;
   &lt;/ns2:Error&gt;
&lt;/ns2:IATA_OrderViewRS&gt;
</code></pre>

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderCreate \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @ordercreate-request.xml
    ```

## Notes

1. **Prerequisites**: You must first call `AirShopping` and `OfferPrice` to get offer references.
2. **Pay Later vs Instant Payment**: 
   - Omit `PaymentFunctions` for pay-later (holding) bookings
   - Include `PaymentFunctions` for instant payment
3. **Order Status**: 
   - Pay-later bookings return status `DRAFT` (on hold)
   - Instant payment bookings return status `OPEN` (confirmed)
4. **Payment Processing**: For pay-later bookings, use `OrderChange` to process payment later.
5. **Order ID**: Save the `OrderID` from the response for future operations like `OrderRetrieve` or `OrderChange`.
