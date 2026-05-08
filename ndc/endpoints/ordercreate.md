---
layout: default
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

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderCreateRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
   <DistributionChain>
      <ns2:DistributionChainLink>
         <ns2:Ordinal>1</ns2:Ordinal>
         <ns2:OrgRole>Seller</ns2:OrgRole>
         <ns2:ParticipatingOrg>
            <ns2:Name>Travel Agency XYZ</ns2:Name>
            <ns2:OrgID>Seller123</ns2:OrgID>
         </ns2:ParticipatingOrg>
      </ns2:DistributionChainLink>
   </DistributionChain>
   <PayloadAttributes>
      <ns2:CorrelationID>{{$randomUUID}}</ns2:CorrelationID>
      <ns2:Timestamp>{{today_th}}</ns2:Timestamp>
      <ns2:TrxID>TRX-123456789</ns2:TrxID>
      <ns2:VersionNumber>21.3</ns2:VersionNumber>
   </PayloadAttributes>
   <POS>
      <ns2:Country>
         <ns2:CountryCode>FR</ns2:CountryCode>
      </ns2:Country>
   </POS>
   <Request>
      <ns2:CreateOrder>
         <ns2:AcceptSelectedQuotedOfferList>
            <ns2:SelectedPricedOffer>
               <ns2:OfferRefID>4601978f-9f7e-4412-bb98-9b561216cb52</ns2:OfferRefID>
               <ns2:OwnerCode>VS</ns2:OwnerCode>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>fe9bdae0-c5d0-4d48-ab51-db60b32e3200:3017640a-4d85-492c-8aa8-0a28a18b785c</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX1</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>4b27e5c9-daa4-4950-951c-fbb6c56061e4:5ad9774a-f85a-4a84-af94-424819d3d53b</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX1</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>848b1060-64df-4880-b11f-9f9fff937c97:ed0780b5-0806-48af-99ac-5d35d0180d10</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX3</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
            </ns2:SelectedPricedOffer>
         </ns2:AcceptSelectedQuotedOfferList>
      </ns2:CreateOrder>
      <ns2:DataLists>
         <ns2:ContactInfoList>
            <ns2:ContactInfo>
               <ns2:ContactInfoID>CTCPAX1_1</ns2:ContactInfoID>
               <ns2:EmailAddress>
                  <ns2:ContactTypeText>Home</ns2:ContactTypeText>
                  <ns2:EmailAddressText>sample@a.com</ns2:EmailAddressText>
               </ns2:EmailAddress>
               <ns2:Individual>
                  <ns2:Birthdate>2026-02-02</ns2:Birthdate>
                  <ns2:GivenName>Firstname</ns2:GivenName>
                  <ns2:Surname>Surname</ns2:Surname>
                  <ns2:TitleName>Mr</ns2:TitleName>
               </ns2:Individual>
               <ns2:Phone>
                  <ns2:CountryDialingCode>66</ns2:CountryDialingCode>
                  <ns2:PhoneNumber>12345960</ns2:PhoneNumber>
               </ns2:Phone>
               <ns2:PostalAddress>
                  <ns2:CityName>TEST</ns2:CityName>
                  <ns2:CountryCode>TH</ns2:CountryCode>
                  <ns2:PostalCode>10210</ns2:PostalCode>
               </ns2:PostalAddress>
            </ns2:ContactInfo>
         </ns2:ContactInfoList>
         <ns2:PaxList>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456789</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>1994-12-08</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Bruce</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX1</ns2:PaxID>
               <ns2:PaxRefID>PAX3</ns2:PaxRefID>
               <ns2:PTC>ADT</ns2:PTC>
            </ns2:Pax>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456789</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>2020-01-01</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Child</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX2</ns2:PaxID>
               <ns2:PTC>CHD</ns2:PTC>
            </ns2:Pax>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456780</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>2026-01-01</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Baby</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX3</ns2:PaxID>
               <ns2:PTC>INF</ns2:PTC>
            </ns2:Pax>
         </ns2:PaxList>
      </ns2:DataLists>
   </Request>
</IATA_OrderCreateRQ>
```

</details>

Omit **`PaymentFunctions`** for pay-later: the order commonly returns **`DRAFT`** until paid. For **round-trip pay later**, add a second **`SelectedOfferItem`** for the inbound priced item.

### Instant Payment Booking
{: #ordercreate-instant-pay}

<details>
<summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderCreateRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
   <DistributionChain>
      <ns2:DistributionChainLink>
         <ns2:Ordinal>1</ns2:Ordinal>
         <ns2:OrgRole>Seller</ns2:OrgRole>
         <ns2:ParticipatingOrg>
            <ns2:Name>Travel Agency XYZ</ns2:Name>
            <ns2:OrgID>Seller123</ns2:OrgID>
         </ns2:ParticipatingOrg>
      </ns2:DistributionChainLink>
   </DistributionChain>
   <PayloadAttributes>
      <ns2:CorrelationID>{{$randomUUID}}</ns2:CorrelationID>
      <ns2:Timestamp>2025-12-30T11:59:48.784+07:00</ns2:Timestamp>
      <ns2:TrxID>TRX-123456789</ns2:TrxID>
      <ns2:VersionNumber>21.3</ns2:VersionNumber>
   </PayloadAttributes>
   <POS>
      <ns2:Country>
         <ns2:CountryCode>FR</ns2:CountryCode>
      </ns2:Country>
   </POS>
   <Request>
      <ns2:CreateOrder>
         <ns2:AcceptSelectedQuotedOfferList>
            <ns2:SelectedPricedOffer>
               <ns2:OfferRefID>9292c7a4-a0d6-4f30-befa-2c197def7ac9</ns2:OfferRefID>
               <ns2:OwnerCode>VS</ns2:OwnerCode>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>982ec9bd-bcff-452d-a1e4-c1d4ba131eb8:46cd5362-2582-42bb-82e1-3fb260f1ac85</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX1</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>3cbc88b1-ab28-45c7-a4bf-6a52a2153c48:12b9a65a-35d3-4a3f-93d2-5160ffc16eca</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX1</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
               <ns2:SelectedOfferItem>
                  <ns2:OfferItemRefID>4e6be961-b8c4-4cec-8f9c-1d586e22f87f:b1226bf0-5901-4f48-977f-34089fbcec91</ns2:OfferItemRefID>
                  <ns2:PaxRefID>PAX3</ns2:PaxRefID>
               </ns2:SelectedOfferItem>
            </ns2:SelectedPricedOffer>
         </ns2:AcceptSelectedQuotedOfferList>
      </ns2:CreateOrder>
      <ns2:DataLists>
         <ns2:ContactInfoList>
            <ns2:ContactInfo>
               <ns2:ContactInfoID>CTCPAX1_1</ns2:ContactInfoID>
               <ns2:EmailAddress>
                  <ns2:ContactTypeText>Home</ns2:ContactTypeText>
                  <ns2:EmailAddressText>sample@a.com</ns2:EmailAddressText>
               </ns2:EmailAddress>
               <ns2:Individual>
                  <ns2:Birthdate>2026-02-02</ns2:Birthdate>
                  <ns2:GivenName>Firstname</ns2:GivenName>
                  <ns2:Surname>Surname</ns2:Surname>
                  <ns2:TitleName>Mr</ns2:TitleName>
               </ns2:Individual>
               <ns2:Phone>
                  <ns2:CountryDialingCode>66</ns2:CountryDialingCode>
                  <ns2:PhoneNumber>12345960</ns2:PhoneNumber>
               </ns2:Phone>
               <ns2:PostalAddress>
                  <ns2:CityName>TEST</ns2:CityName>
                  <ns2:CountryCode>TH</ns2:CountryCode>
                  <ns2:PostalCode>10210</ns2:PostalCode>
               </ns2:PostalAddress>
            </ns2:ContactInfo>
         </ns2:ContactInfoList>
         <ns2:PaxList>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456789</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>1994-12-08</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Bruce</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX1</ns2:PaxID>
               <ns2:PaxRefID>PAX3</ns2:PaxRefID>
               <ns2:PTC>ADT</ns2:PTC>
            </ns2:Pax>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456789</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>2020-01-01</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Child</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX2</ns2:PaxID>
               <ns2:PTC>CHD</ns2:PTC>
            </ns2:Pax>
            <ns2:Pax>
               <ns2:IdentityDoc>
                  <ns2:ExpiryDate>2029-08-13</ns2:ExpiryDate>
                  <ns2:IdentityDocID>0123456780</ns2:IdentityDocID>
                  <ns2:IdentityDocTypeCode>PP</ns2:IdentityDocTypeCode>
                  <ns2:IssuingCountryCode>GB</ns2:IssuingCountryCode>
                  <ns2:ResidenceCountryCode>GB</ns2:ResidenceCountryCode>
                  <ns2:Surname>Wayne</ns2:Surname>
               </ns2:IdentityDoc>
               <ns2:Individual>
                  <ns2:Birthdate>2026-01-01</ns2:Birthdate>
                  <ns2:GenderCode>M</ns2:GenderCode>
                  <ns2:GivenName>Baby</ns2:GivenName>
                  <ns2:Surname>Wayne</ns2:Surname>
                  <ns2:TitleName>MR</ns2:TitleName>
               </ns2:Individual>
               <ns2:LangUsage>
                  <ns2:LangCode>FR</ns2:LangCode>
               </ns2:LangUsage>
               <ns2:PaxID>PAX3</ns2:PaxID>
               <ns2:PTC>INF</ns2:PTC>
            </ns2:Pax>
         </ns2:PaxList>
      </ns2:DataLists>
      <ns2:PaymentFunctions>
         <ns2:PaymentProcessingDetails>
            <ns2:Amount CurCode="USD">122.19</ns2:Amount>
            <ns2:PaymentMethod>
               <ns2:OfflinePayment>
                  <ns2:PaymentTypeCode>CA</ns2:PaymentTypeCode>
               </ns2:OfflinePayment>
            </ns2:PaymentMethod>
         </ns2:PaymentProcessingDetails>
      </ns2:PaymentFunctions>
   </Request>
</IATA_OrderCreateRQ>
```

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with order confirmation details.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
   <ns2:Response>
      <DataLists>
         <ContactInfoList>
            <ContactInfo>
               <EmailAddress>
                  <EmailAddressText>sample@a.com</EmailAddressText>
               </EmailAddress>
               <Individual>
                  <Birthdate>2026-02-02</Birthdate>
                  <GivenName>Firstname</GivenName>
                  <Surname>Surname</Surname>
                  <TitleName>Mr</TitleName>
               </Individual>
               <Phone>
                  <CountryDialingCode>66</CountryDialingCode>
                  <PhoneNumber>12345960</PhoneNumber>
               </Phone>
               <PostalAddress>
                  <CityName>TEST</CityName>
                  <CountryCode>TH</CountryCode>
                  <PostalCode>10210</PostalCode>
               </PostalAddress>
            </ContactInfo>
         </ContactInfoList>
         <DatedMarketingSegmentList>
            <DatedMarketingSegment>
               <Arrival>
                  <AircraftScheduledDateTime>2026-05-17T19:00:00</AircraftScheduledDateTime>
                  <IATA_LocationCode>CPH</IATA_LocationCode>
               </Arrival>
               <CarrierDesigCode>DX</CarrierDesigCode>
               <DatedMarketingSegmentId>DMS1</DatedMarketingSegmentId>
               <DatedOperatingSegmentRefId>DOS1</DatedOperatingSegmentRefId>
               <Dep>
                  <AircraftScheduledDateTime>2026-05-17T18:10:00</AircraftScheduledDateTime>
                  <IATA_LocationCode>KRP</IATA_LocationCode>
               </Dep>
               <MarketingCarrierFlightNumberText>9901</MarketingCarrierFlightNumberText>
            </DatedMarketingSegment>
         </DatedMarketingSegmentList>
         <DatedOperatingSegmentList>
            <DatedOperatingSegment>
               <CarrierDesigCode>DX</CarrierDesigCode>
               <DatedOperatingSegmentId>DOS1</DatedOperatingSegmentId>
               <OperatingCarrierFlightNumberText>9901</OperatingCarrierFlightNumberText>
            </DatedOperatingSegment>
         </DatedOperatingSegmentList>
         <OriginDestList>
            <OriginDest>
               <DestCode>CPH</DestCode>
               <OriginCode>KRP</OriginCode>
               <OriginDestID>OD1</OriginDestID>
               <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
            </OriginDest>
         </OriginDestList>
         <PaxJourneyList>
            <PaxJourney>
               <PaxJourneyID>JOUR1</PaxJourneyID>
               <PaxSegmentRefID>SEG1</PaxSegmentRefID>
            </PaxJourney>
         </PaxJourneyList>
         <PaxList>
            <Pax>
               <CitizenshipCountryCode></CitizenshipCountryCode>
               <Individual>
                  <GenderCode>M</GenderCode>
                  <GivenName>Bruce</GivenName>
                  <IndividualID>c4f083ce-9e5c-4215-a3ab-8a94ecbe33e1</IndividualID>
                  <Surname>Wayne</Surname>
                  <TitleName>MR</TitleName>
               </Individual>
               <PaxID>PAX1</PaxID>
               <PaxRefID>PAX2</PaxRefID>
               <PTC>ADT</PTC>
            </Pax>
            <Pax>
               <CitizenshipCountryCode></CitizenshipCountryCode>
               <Individual>
                  <GenderCode>M</GenderCode>
                  <GivenName>Baby</GivenName>
                  <IndividualID>4a645ced-20da-4327-abb2-5a638e3ebfc3</IndividualID>
                  <Surname>Wayne</Surname>
                  <TitleName>MR</TitleName>
               </Individual>
               <PaxID>PAX2</PaxID>
               <PTC>INF</PTC>
            </Pax>
            <Pax>
               <CitizenshipCountryCode></CitizenshipCountryCode>
               <Individual>
                  <GenderCode>M</GenderCode>
                  <GivenName>Child</GivenName>
                  <IndividualID>a3e03f61-30d6-47ea-95fd-d2f1d513dffd</IndividualID>
                  <Surname>Wayne</Surname>
                  <TitleName>MR</TitleName>
               </Individual>
               <PaxID>PAX3</PaxID>
               <PTC>CHD</PTC>
            </Pax>
         </PaxList>
         <PaxSegmentList>
            <PaxSegment>
               <DatedMarketingSegmentRefId>DMS1</DatedMarketingSegmentRefId>
               <MarketingCarrierRBD_Code>DX</MarketingCarrierRBD_Code>
               <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
               <PaxSegmentID>SEG1</PaxSegmentID>
            </PaxSegment>
         </PaxSegmentList>
         <ServiceDefinitionList/>
      </DataLists>
      <Order>
         <OrderID>546d8e92-38a9-4908-a62c-dc92a0738202</OrderID>
         <OrderItem>
            <FareDetail>
               <AccountCode>VAT_DC</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>VAT_EU</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>DC</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">2.04</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>EU</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">4.07</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <FareRefText>Base Fare</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">34.62</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <FareRefText>VAT</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <GrandTotalAmount CurCode="USD">40.73</GrandTotalAmount>
            <OrderItemID>85144767-48b1-4107-bb6a-8c6fc9fba5d5</OrderItemID>
            <OwnerCode>DX</OwnerCode>
            <Price>
               <BaseAmount CurCode="USD">34.62</BaseAmount>
               <Fee>
                  <Amount CurCode="USD">0.0</Amount>
               </Fee>
               <Fee>
                  <Amount CurCode="USD">0.0</Amount>
               </Fee>
               <TaxSummary>
                  <Tax>
                     <Amount CurCode="USD">2.04</Amount>
                     <TaxCode>DC</TaxCode>
                  </Tax>
                  <Tax>
                     <Amount CurCode="USD">4.07</Amount>
                     <TaxCode>EU</TaxCode>
                  </Tax>
               </TaxSummary>
               <TotalAmount CurCode="USD">40.73</TotalAmount>
            </Price>
            <Service>
               <BookingRef>
                  <BookingEntity>
                     <Carrier>
                        <AirlineDesigCode>DX</AirlineDesigCode>
                     </Carrier>
                  </BookingEntity>
                  <BookingID>XIP4LO</BookingID>
               </BookingRef>
               <OrderServiceAssociation>
                  <PaxSegmentRef>
                     <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                  </PaxSegmentRef>
               </OrderServiceAssociation>
               <PaxRefID>PAX1</PaxRefID>
            </Service>
            <StatusCode>ACTIVE</StatusCode>
         </OrderItem>
         <OrderItem>
            <FareDetail>
               <FareRefText>Base Fare</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">40.73</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <FareRefText>VAT</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <GrandTotalAmount CurCode="USD">40.73</GrandTotalAmount>
            <OrderItemID>465b2e75-cd06-4ccf-8610-fc3f6c9b7c0a</OrderItemID>
            <OwnerCode>DX</OwnerCode>
            <Price>
               <BaseAmount CurCode="USD">40.73</BaseAmount>
               <TotalAmount CurCode="USD">40.73</TotalAmount>
            </Price>
            <Service>
               <BookingRef>
                  <BookingEntity>
                     <Carrier>
                        <AirlineDesigCode>DX</AirlineDesigCode>
                     </Carrier>
                  </BookingEntity>
                  <BookingID>XIP4LO</BookingID>
               </BookingRef>
               <OrderServiceAssociation>
                  <PaxSegmentRef>
                     <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                  </PaxSegmentRef>
               </OrderServiceAssociation>
               <PaxRefID>PAX2</PaxRefID>
            </Service>
            <StatusCode>ACTIVE</StatusCode>
         </OrderItem>
         <OrderItem>
            <FareDetail>
               <AccountCode>VAT_DC</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>VAT_QQ</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>DC</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0.27</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <AccountCode>QQ</AccountCode>
               <Price>
                  <TotalAmount CurCode="USD">0.64</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <FareRefText>Base Fare</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">39.82</TotalAmount>
               </Price>
            </FareDetail>
            <FareDetail>
               <FareRefText>VAT</FareRefText>
               <Price>
                  <TotalAmount CurCode="USD">0</TotalAmount>
               </Price>
            </FareDetail>
            <GrandTotalAmount CurCode="USD">40.73</GrandTotalAmount>
            <OrderItemID>4d34cc94-565a-426d-903d-7fa1f0755291</OrderItemID>
            <OwnerCode>DX</OwnerCode>
            <Price>
               <BaseAmount CurCode="USD">39.82</BaseAmount>
               <Fee>
                  <Amount CurCode="USD">0.0</Amount>
               </Fee>
               <Fee>
                  <Amount CurCode="USD">0.0</Amount>
               </Fee>
               <TaxSummary>
                  <Tax>
                     <Amount CurCode="USD">0.27</Amount>
                     <TaxCode>DC</TaxCode>
                  </Tax>
                  <Tax>
                     <Amount CurCode="USD">0.64</Amount>
                     <TaxCode>QQ</TaxCode>
                  </Tax>
               </TaxSummary>
               <TotalAmount CurCode="USD">40.73</TotalAmount>
            </Price>
            <Service>
               <BookingRef>
                  <BookingEntity>
                     <Carrier>
                        <AirlineDesigCode>DX</AirlineDesigCode>
                     </Carrier>
                  </BookingEntity>
                  <BookingID>XIP4LO</BookingID>
               </BookingRef>
               <OrderServiceAssociation>
                  <PaxSegmentRef>
                     <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                  </PaxSegmentRef>
               </OrderServiceAssociation>
               <PaxRefID>PAX3</PaxRefID>
            </Service>
            <StatusCode>ACTIVE</StatusCode>
         </OrderItem>
         <StatusCode>OPEN</StatusCode>
         <TotalPrice>
            <BaseAmount CurCode="USD">122.19</BaseAmount>
            <TaxSummary>
               <Tax>
                  <Amount CurCode="USD">2.31</Amount>
                  <TaxCode>DC</TaxCode>
               </Tax>
               <Tax>
                  <Amount CurCode="USD">4.07</Amount>
                  <TaxCode>EU</TaxCode>
               </Tax>
               <Tax>
                  <Amount CurCode="USD">0.64</Amount>
                  <TaxCode>QQ</TaxCode>
               </Tax>
               <TotalTaxAmount CurCode="USD">7.02</TotalTaxAmount>
            </TaxSummary>
            <TotalAmount CurCode="USD">122.19</TotalAmount>
         </TotalPrice>
      </Order>
      <TicketDocInfo>
         <BookletQty>1</BookletQty>
         <OriginDest>
            <DestCode>CPH</DestCode>
            <OriginCode>KRP</OriginCode>
            <OriginDestID>OD1</OriginDestID>
         </OriginDest>
         <PaxRefID>PAX1</PaxRefID>
         <Ticket>
            <TicketNumber>2772770026748</TicketNumber>
         </Ticket>
      </TicketDocInfo>
      <TicketDocInfo>
         <BookletQty>1</BookletQty>
         <OriginDest>
            <DestCode>CPH</DestCode>
            <OriginCode>KRP</OriginCode>
            <OriginDestID>OD1</OriginDestID>
         </OriginDest>
         <PaxRefID>PAX2</PaxRefID>
         <Ticket>
            <TicketNumber>2772770026749</TicketNumber>
         </Ticket>
      </TicketDocInfo>
      <TicketDocInfo>
         <BookletQty>1</BookletQty>
         <OriginDest>
            <DestCode>CPH</DestCode>
            <OriginCode>KRP</OriginCode>
            <OriginDestID>OD1</OriginDestID>
         </OriginDest>
         <PaxRefID>PAX3</PaxRefID>
         <Ticket>
            <TicketNumber>2772770026750</TicketNumber>
         </Ticket>
      </TicketDocInfo>
   </ns2:Response>
   <ns2:DistributionChain>
      <DistributionChainLink>
         <Ordinal>1</Ordinal>
         <OrgRole>Seller</OrgRole>
         <ParticipatingOrg>
            <Name>Travel Agency XYZ</Name>
            <OrgID>Seller123</OrgID>
         </ParticipatingOrg>
      </DistributionChainLink>
   </ns2:DistributionChain>
   <ns2:PayloadAttributes>
      <CorrelationID>acee4201-531c-4432-b726-542117b0d38a</CorrelationID>
      <Timestamp>2025-12-30T11:59:48.784+07:00</Timestamp>
      <TrxID>TRX-123456789</TrxID>
      <VersionNumber>21.3</VersionNumber>
   </ns2:PayloadAttributes>
</ns2:IATA_OrderViewRS>
```

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
   <ns2:Error>
      <Code>914</Code>
      <DescText>offerRefID must be present</DescText>
      <ErrorID>3a1294b8-0f56-424b-b302-1bb66b040547</ErrorID>
      <LangCode>EN</LangCode>
      <TypeCode>Validation</TypeCode>
   </ns2:Error>
</ns2:IATA_OrderViewRS>
```

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
