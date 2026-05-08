---
layout: default
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

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderQuoteRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
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
    <Payload>
        <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
            <OwnerCode>VS</OwnerCode>
        </ExistingOrder>
        <SelectedOffers xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OfferRefID>351b2a94-83d1-4347-8bbe-8844a4c76cb0</OfferRefID>
            <OwnerCode>VS</OwnerCode>
            <SelectedOfferItem>
                <OfferItemRefID>2afd921a-885f-49bb-93ae-5c279660384c</OfferItemRefID>
                <PaxRefID>PAX1</PaxRefID>
            </SelectedOfferItem>
            <SelectedOfferItem>
                <OfferItemRefID>66b0aad9-048a-4d1e-bee6-124a1bda2baa</OfferItemRefID>
                <PaxRefID>PAX2</PaxRefID>
            </SelectedOfferItem>
            <SelectedOfferItem>
                <OfferItemRefID>e8469306-5a16-41a0-bc62-aa98b5b03184</OfferItemRefID>
                <PaxRefID>PAX3</PaxRefID>
            </SelectedOfferItem>
        </SelectedOffers>
    </Payload>
    <PayloadAttributes>
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">{{$randomUUID}}</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-05-07T13:35:51.653+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
</IATA_OrderQuoteRQ>
```
</details>

**Response** (`OrderReshopRS`-style quote):

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Response>
        <DataLists>
            <DatedMarketingSegmentList>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-27T07:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CPH</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS1</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS1</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-27T06:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>KRP</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>DX0500</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
            </DatedMarketingSegmentList>
            <DatedOperatingSegmentList>
                <DatedOperatingSegment>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS1</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>DX0500</OperatingCarrierFlightNumberText>
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
                    <Duration>PT1H</Duration>
                    <PaxJourneyID>JOUR1</PaxJourneyID>
                    <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                </PaxJourney>
            </PaxJourneyList>
            <PaxList>
                <Pax>
                    <PaxID>CHD1</PaxID>
                    <PTC>CHD</PTC>
                </Pax>
                <Pax>
                    <PaxID>ADT1</PaxID>
                    <PTC>ADT</PTC>
                </Pax>
                <Pax>
                    <PaxID>INF1</PaxID>
                    <PTC>INF</PTC>
                </Pax>
            </PaxList>
            <PaxSegmentList>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS1</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG1</PaxSegmentID>
                </PaxSegment>
            </PaxSegmentList>
            <PenaltyList/>
            <PriceClassList>
                <PriceClass>
                    <Code>Bedre</Code>
                    <Name>Bedre</Name>
                    <PriceClassID>PC1</PriceClassID>
                </PriceClass>
            </PriceClassList>
            <ServiceDefinitionList/>
        </DataLists>
        <Order>
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
        </Order>
        <ReshopResults>
            <ReshopOffers>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>BDXBED</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>2afd921a-885f-49bb-93ae-5c279660384c</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">34.62</BaseAmount>
                                        <TaxSummary>
                                            <Tax>
                                                <Amount CurCode="USD">4.07</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>EU</TaxCode>
                                            </Tax>
                                            <Tax>
                                                <Amount CurCode="USD">2.04</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>DC</TaxCode>
                                            </Tax>
                                            <TotalTaxAmount CurCode="USD">6.11</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">34.62</BaseAmount>
                                        <TaxSummary>
                                            <Tax>
                                                <Amount CurCode="USD">2.04</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>DC</TaxCode>
                                            </Tax>
                                            <Tax>
                                                <Amount CurCode="USD">4.07</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>EU</TaxCode>
                                            </Tax>
                                            <TotalTaxAmount CurCode="USD">6.11</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </NewPrice>
                                <OldPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                                        <TotalAmount CurCode="USD">0.0</TotalAmount>
                                    </Price>
                                </OldPrice>
                            </PriceDifferential>
                        </ReshopPrice>
                        <Service>
                            <OfferServiceAssociation>
                                <PaxJourneyRef>
                                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                                </PaxJourneyRef>
                            </OfferServiceAssociation>
                            <PaxRefID>ADT1</PaxRefID>
                        </Service>
                    </AddedOfferItem>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>BDXBED</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>66b0aad9-048a-4d1e-bee6-124a1bda2baa</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">40.73</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">40.73</BaseAmount>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </NewPrice>
                                <OldPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                                        <TotalAmount CurCode="USD">0.0</TotalAmount>
                                    </Price>
                                </OldPrice>
                            </PriceDifferential>
                        </ReshopPrice>
                        <Service>
                            <OfferServiceAssociation>
                                <PaxJourneyRef>
                                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                                </PaxJourneyRef>
                            </OfferServiceAssociation>
                            <PaxRefID>INF1</PaxRefID>
                        </Service>
                    </AddedOfferItem>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>BDXBED</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e8469306-5a16-41a0-bc62-aa98b5b03184</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">39.82</BaseAmount>
                                        <TaxSummary>
                                            <Tax>
                                                <Amount CurCode="USD">0.64</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>QQ</TaxCode>
                                            </Tax>
                                            <Tax>
                                                <Amount CurCode="USD">0.27</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>DC</TaxCode>
                                            </Tax>
                                            <TotalTaxAmount CurCode="USD">0.91</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">39.82</BaseAmount>
                                        <TaxSummary>
                                            <Tax>
                                                <Amount CurCode="USD">0.27</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>DC</TaxCode>
                                            </Tax>
                                            <Tax>
                                                <Amount CurCode="USD">0.64</Amount>
                                                <DescText>Tax description</DescText>
                                                <TaxCode>QQ</TaxCode>
                                            </Tax>
                                            <TotalTaxAmount CurCode="USD">0.91</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">40.73</TotalAmount>
                                    </Price>
                                </NewPrice>
                                <OldPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                                        <TotalAmount CurCode="USD">0.0</TotalAmount>
                                    </Price>
                                </OldPrice>
                            </PriceDifferential>
                        </ReshopPrice>
                        <Service>
                            <OfferServiceAssociation>
                                <PaxJourneyRef>
                                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                                </PaxJourneyRef>
                            </OfferServiceAssociation>
                            <PaxRefID>CHD1</PaxRefID>
                        </Service>
                    </AddedOfferItem>
                    <OfferID>351b2a94-83d1-4347-8bbe-8844a4c76cb0</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">0.0</TotalAmount>
                    </TotalPrice>
                </Offer>
            </ReshopOffers>
        </ReshopResults>
    </ns2:Response>
    <ns2:PayloadAttributes>
        <CorrelationID>ce366c50-43b5-4590-8b6f-4d796171ac4d</CorrelationID>
        <Timestamp>2026-05-07T13:35:51.653+07:00</Timestamp>
        <TrxID>TRX-123456789</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_OrderReshopRS>
```

</details>

### OrderQuote — Cancel quote
{: #orderquote-cancel}

Phase 1 often **skips** **`OrderQuote`** when refunds are unsupported. If your airline enables cancel quoting, shape matches the rebook quote but **`SelectedOffers`** carry IDs returned from **cancel reshop** (when present):

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderQuoteRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
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
    <Payload>
        <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
            <OwnerCode>VS</OwnerCode>
        </ExistingOrder>
        <SelectedOffers xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OfferRefID>9fe9409f-0382-4cb0-95c9-39a5a88b18c3</OfferRefID>
            <OwnerCode>VS</OwnerCode>
            <SelectedOfferItem>
                <OfferItemRefID>ccf1eb58-fd5a-4a5c-b4a8-8f5c0dbf9629</OfferItemRefID>
                <PaxRefID>PAX1</PaxRefID>
            </SelectedOfferItem>
            <SelectedOfferItem>
                <OfferItemRefID>217478a5-02e5-473a-877d-a164e79b2c1d</OfferItemRefID>
                <PaxRefID>PAX2</PaxRefID>
            </SelectedOfferItem>
            <SelectedOfferItem>
                <OfferItemRefID>a1ae82a1-d2f4-48ee-9983-9ff5dbd152b3</OfferItemRefID>
                <PaxRefID>PAX3</PaxRefID>
            </SelectedOfferItem>
        </SelectedOffers>
    </Payload>
    <PayloadAttributes>
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">{{$randomUUID}}</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-05-07T14:18:37.817+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
</IATA_OrderQuoteRQ>
```

### OrderQuote — Booking (confirm on-hold)
{: #orderquote-booking}

Use **`ExistingOrder`** = held booking UUID and **`SelectedOffers`** from a **fresh shop/price** or quoted offer set after retrieve:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderQuoteRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" >
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
    <Payload>
        <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
            <OwnerCode>VS</OwnerCode>
        </ExistingOrder>
    </Payload>
    <PayloadAttributes>
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">{{$randomUUID}}</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2025-12-30T11:59:48.784+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
</IATA_OrderQuoteRQ>
```

## Response

### Success Response (200 OK)

Returns an `IATA_OrderReshopRS` XML document with order quote information.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
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
                    <DatedMarketingSegmentId>DMS1</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS1</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-17T18:10:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>KRP</IATA_LocationCode>
                    </Dep>
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
                    <Duration>PT50M</Duration>
                    <PaxJourneyID>JOUR1</PaxJourneyID>
                    <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                </PaxJourney>
            </PaxJourneyList>
            <PaxList>
                <Pax>
                    <Birthdate>2026-01-01</Birthdate>
                    <CitizenshipCountryCode></CitizenshipCountryCode>
                    <IdentityDoc>
                        <ExpiryDate>2029-08-13</ExpiryDate>
                        <IdentityDocID>0123456780</IdentityDocID>
                        <IdentityDocTypeCode>PP</IdentityDocTypeCode>
                        <IssuingCountryCode>GB</IssuingCountryCode>
                    </IdentityDoc>
                    <Individual>
                        <Birthdate>2026-01-01</Birthdate>
                        <GenderCode>M</GenderCode>
                        <GivenName>Baby</GivenName>
                        <IndividualID>a1e9d4e1-66a5-4627-85de-137cc22eb3ba</IndividualID>
                        <Surname>Wayne</Surname>
                        <TitleName>MR</TitleName>
                    </Individual>
                    <PaxID>PAX1</PaxID>
                    <PTC>INF</PTC>
                </Pax>
                <Pax>
                    <Birthdate>1994-12-08</Birthdate>
                    <CitizenshipCountryCode></CitizenshipCountryCode>
                    <IdentityDoc>
                        <ExpiryDate>2029-08-13</ExpiryDate>
                        <IdentityDocID>0123456789</IdentityDocID>
                        <IdentityDocTypeCode>PP</IdentityDocTypeCode>
                        <IssuingCountryCode>GB</IssuingCountryCode>
                    </IdentityDoc>
                    <Individual>
                        <Birthdate>1994-12-08</Birthdate>
                        <GenderCode>M</GenderCode>
                        <GivenName>Bruce</GivenName>
                        <IndividualID>635e29c9-3195-4587-ba8b-7e001780c7d0</IndividualID>
                        <Surname>Wayne</Surname>
                        <TitleName>MR</TitleName>
                    </Individual>
                    <PaxID>PAX2</PaxID>
                    <PaxRefID>PAX1</PaxRefID>
                    <PTC>ADT</PTC>
                </Pax>
                <Pax>
                    <Birthdate>2020-01-01</Birthdate>
                    <CitizenshipCountryCode></CitizenshipCountryCode>
                    <IdentityDoc>
                        <ExpiryDate>2029-08-13</ExpiryDate>
                        <IdentityDocID>0123456789</IdentityDocID>
                        <IdentityDocTypeCode>PP</IdentityDocTypeCode>
                        <IssuingCountryCode>GB</IssuingCountryCode>
                    </IdentityDoc>
                    <Individual>
                        <Birthdate>2020-01-01</Birthdate>
                        <GenderCode>M</GenderCode>
                        <GivenName>Child</GivenName>
                        <IndividualID>27084b36-ce1d-4c3d-a3fc-da739600bb05</IndividualID>
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
                    <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG1</PaxSegmentID>
                </PaxSegment>
            </PaxSegmentList>
            <ServiceDefinitionList/>
        </DataLists>
        <Order>
            <OrderID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderID>
        </Order>
        <ReshopResults>
            <NoChangeInd>
                <NoChangeInd>true</NoChangeInd>
            </NoChangeInd>
        </ReshopResults>
    </ns2:Response>
    <ns2:PayloadAttributes>
        <CorrelationID>639ab93d-d54c-4155-8a91-6794d3e81f83</CorrelationID>
        <Timestamp>2025-12-30T11:59:48.784+07:00</Timestamp>
        <TrxID>TRX-123456789</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_OrderReshopRS>
```

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>12</Code>
        <DescText>Order is not paid : d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</DescText>
        <ErrorID>8d9efeac-91ab-44d4-99a9-3c15a866b046</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Validation</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderReshopRS>
```

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
