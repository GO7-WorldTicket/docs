---
layout: default
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

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderChangeRQ
        xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
    <DistributionChain>
        <DistributionChainLink xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <Ordinal>1</Ordinal>
            <OrgRole>Seller</OrgRole>
            <ParticipatingOrg>
                <Name>Travel Agency XYZ</Name>
                <OrgID>SELLER123</OrgID>
            </ParticipatingOrg>
        </DistributionChainLink>
    </DistributionChain>
    <PayloadAttributes>
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">{{$randomUUID}}</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2025-12-30T11:59:48.784+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <POS>
        <Country xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <CountryCode>FR</CountryCode>
        </Country>
    </POS>
    <Request>
        <Order xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
            <OwnerCode>W2</OwnerCode>
        </Order>
        <PaymentFunctions xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <PaymentProcessingDetails>
                <Amount CurCode="USD">122.19</Amount>
                <PaymentMethod>
                    <OfflinePayment>
                        <PaymentTypeCode>CA</PaymentTypeCode>
                    </OfflinePayment>
                </PaymentMethod>
            </PaymentProcessingDetails>
        </PaymentFunctions>
    </Request>
</IATA_OrderChangeRQ>
```

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

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderChangeRQ
        xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
    <DistributionChain>
        <DistributionChainLink xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <Ordinal>1</Ordinal>
            <OrgRole>Seller</OrgRole>
            <ParticipatingOrg>
                <Name>Travel Agency XYZ</Name>
                <OrgID>Seller123</OrgID>
            </ParticipatingOrg>
        </DistributionChainLink>
    </DistributionChain>
    <PayloadAttributes>
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">{{$randomUUID}}</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-05-07T13:35:51.653+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456790</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <POS>
        <Country xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <CountryCode>FR</CountryCode>
        </Country>
    </POS>
    <Request>
        <ChangeOrderChoice xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <AcceptSelectedQuotedOfferList>
                <SelectedPricedOffer>
                    <OfferRefID>351b2a94-83d1-4347-8bbe-8844a4c76cb0</OfferRefID>
                    <OwnerCode>VS</OwnerCode>
                    <SelectedOfferItem>
                        <OfferItemRefID>2afd921a-885f-49bb-93ae-5c279660384c</OfferItemRefID>
                        <PaxRefID>ADT1</PaxRefID>
                    </SelectedOfferItem>
                    <SelectedOfferItem>
                        <OfferItemRefID>66b0aad9-048a-4d1e-bee6-124a1bda2baa</OfferItemRefID>
                        <PaxRefID>CHD1</PaxRefID>
                    </SelectedOfferItem>
                    <SelectedOfferItem>
                        <OfferItemRefID>e8469306-5a16-41a0-bc62-aa98b5b03184</OfferItemRefID>
                        <PaxRefID>INF1</PaxRefID>
                    </SelectedOfferItem>
                </SelectedPricedOffer>
            </AcceptSelectedQuotedOfferList>
        </ChangeOrderChoice>
        <Order xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
            <OwnerCode>W2</OwnerCode>
        </Order>
        <PaymentFunctions xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <PaymentProcessingDetails>
                <Amount CurCode="USD">122.19</Amount>
                <PaymentMethod>
                    <OfflinePayment>
                        <PaymentTypeCode>CA</PaymentTypeCode>
                    </OfflinePayment>
                </PaymentMethod>
            </PaymentProcessingDetails>
        </PaymentFunctions>
    </Request>
</IATA_OrderChangeRQ>
```

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with updated order details.

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
                        <AircraftScheduledDateTime>2026-05-27T07:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CPH</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS1</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS1</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-27T06:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>KRP</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>500</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
            </DatedMarketingSegmentList>
            <DatedOperatingSegmentList>
                <DatedOperatingSegment>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS1</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>500</OperatingCarrierFlightNumberText>
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
                        <IndividualID>72aa9ff5-e62b-4c20-a0ad-afafa3a160fe</IndividualID>
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
                        <IndividualID>a8a65d26-7b2a-4d8f-94bf-f769b4358efc</IndividualID>
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
                        <IndividualID>0ea6e3bc-7be9-40ac-854b-9a2c0c7b53c1</IndividualID>
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
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>W2</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG1</PaxSegmentID>
                </PaxSegment>
            </PaxSegmentList>
            <ServiceDefinitionList/>
        </DataLists>
        <Order>
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
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
                <OrderItemID>8064850f-de57-4226-a39b-f71213f400ff</OrderItemID>
                <OwnerCode>W2</OwnerCode>
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
                                <AirlineDesigCode>W2</AirlineDesigCode>
                            </Carrier>
                        </BookingEntity>
                        <BookingID>CSHUNH</BookingID>
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
                <OrderItemID>1be3dfac-d292-4061-84e9-be8ee968bc43</OrderItemID>
                <OwnerCode>W2</OwnerCode>
                <Price>
                    <BaseAmount CurCode="USD">40.73</BaseAmount>
                    <TotalAmount CurCode="USD">40.73</TotalAmount>
                </Price>
                <Service>
                    <BookingRef>
                        <BookingEntity>
                            <Carrier>
                                <AirlineDesigCode>W2</AirlineDesigCode>
                            </Carrier>
                        </BookingEntity>
                        <BookingID>CSHUNH</BookingID>
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
                <OrderItemID>a48f7f60-115e-4faf-baaf-e84a15eb294e</OrderItemID>
                <OwnerCode>W2</OwnerCode>
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
                                <AirlineDesigCode>W2</AirlineDesigCode>
                            </Carrier>
                        </BookingEntity>
                        <BookingID>CSHUNH</BookingID>
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
                <TicketNumber>2772770026753</TicketNumber>
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
                <TicketNumber>2772770026754</TicketNumber>
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
                <TicketNumber>2772770026755</TicketNumber>
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
        <CorrelationID>858e5019-0050-4415-984f-f3506492fcf3</CorrelationID>
        <Timestamp>2026-05-07T13:35:51.653+07:00</Timestamp>
        <TrxID>TRX-123456790</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_OrderViewRS>
```

</details>

### Error Responses

#### 400 Bad Request

Invalid request, missing required fields, or order not in DRAFT status.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>13</Code>
        <DescText>Reshop offer ID is required for CONFIRM_REBOOK_AND_PAY</DescText>
        <ErrorID>2acab829-02ed-4007-9694-dcf84b1fc9af</ErrorID>
        <LangCode>EN</LangCode>
        <TagText>OrderChangeRQ/Request/ChangeOrderChoice/AcceptSelectedQuotedOfferList/SelectedPricedOffer/OfferRefID</TagText>
        <TypeCode>Validation</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderViewRS>
```

</details>

#### 404 Not Found

Order not found.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>911</Code>
        <DescText>Order not found - Order with id 014a8d0c-74a6-4c3c-801b-8f9e17cf21c6 not found</DescText>
        <ErrorID>64669f43-2d30-4d86-a1a8-05dec018e03b</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Business</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderViewRS>
```
</details>

[//]: # (#### 422 Unprocessable Entity)

[//]: # ()
[//]: # (Payment method not supported or payment validation failed.)

[//]: # ()
[//]: # (<details>)

[//]: # (  <summary>Response Payload</summary>)

[//]: # ()
[//]: # (```xml)

[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # (<ErrorResponse>)

[//]: # (    <Error>)

[//]: # (        <Code>422</Code>)

[//]: # (        <Message>Unprocessable Entity - Payment method not supported or payment validation failed</Message>)

[//]: # (        <Details>Payment type code CASH is not supported</Details>)

[//]: # (    </Error>)

[//]: # (</ErrorResponse>)

[//]: # (```)

[//]: # (</details>)

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
