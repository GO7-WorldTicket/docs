---
layout: default
title: Order Reshop (OrderReshop)
---

# Order Reshop

`POST` `https://api.go7.io/v21.3.5/OrderReshop`

---

## Description

The Order Reshop API allows you to search for alternative offers for an existing order. You can use it to:
- Rebook flights with new dates or routes
- Cancel specific segments
- Add new segments
- Get alternative offers for order modifications

The API returns alternative offers that can be used with `OrderChange` to modify the existing order.

## Workflow (NDC API guide)

**Step 5** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderReshop` · yields **`OfferID`** / **`OfferItemID`** for **[Order Quote](orderquote.md)** and **[Order Change](orderchange.md)**. XML samples: **`#orderreshop-rebook`**, **`#orderreshop-cancel-order`**.

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

The request body must be a valid `IATA_OrderReshopRQ` XML document following IATA NDC v21.3.5 standard.

### Rebook with New Travel Date
{: #orderreshop-rebook}

<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderReshopRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <DistributionChain>
        <DistributionChainLink  xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
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
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <Request >
        <OrderRefID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderRefID>
        <UpdateOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <ReshopOrder>
                <ReshopOrderChoice>
                    <ServiceOrder>
                        <AddOfferItems>
                            <FlightRequest>
                                <FlightRequestOriginDestinationsCriteria>
                                    <OriginDestCriteria>
                                        <DestArrivalCriteria>
                                            <Date>2026-05-28</Date>
                                            <IATA_LocationCode>CPH</IATA_LocationCode>
                                        </DestArrivalCriteria>
                                        <OriginDepCriteria>
                                            <Date>2026-05-27</Date>
                                            <IATA_LocationCode>KRP</IATA_LocationCode>
                                        </OriginDepCriteria>
                                    </OriginDestCriteria>
                                </FlightRequestOriginDestinationsCriteria>
                            </FlightRequest>
                        </AddOfferItems>
                        <DeleteOrderItem>
                            <OrderItemRefID>86b20775-4429-41cc-961d-587e7156421b</OrderItemRefID>
                        </DeleteOrderItem>
                        <DeleteOrderItem>
                            <OrderItemRefID>8e54f6a6-543e-4744-8596-b50c0048c12d</OrderItemRefID>
                        </DeleteOrderItem>
                        <DeleteOrderItem>
                            <OrderItemRefID>6b8ae903-0f89-4308-8d5d-24c0a0776137</OrderItemRefID>
                        </DeleteOrderItem>
                    </ServiceOrder>
                </ReshopOrderChoice>
            </ReshopOrder>
        </UpdateOrder>
    </Request>
</IATA_OrderReshopRQ>
```

</details>

Use **`OrderRefID`** from the active order; **`AddOfferItems`** + optional **`DeleteOrderItem`** replace segments. From **OrderReshopRS**, pass **`ReshopOffer.OfferID`** (and item IDs) into **OrderQuote** / **OrderChange**.

### Cancel Order
{: #orderreshop-cancel-order}

<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderReshopRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <DistributionChain>
        <DistributionChainLink  xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
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
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <Request >
        <OrderRefID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</OrderRefID>
        <UpdateOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <CancelOrderRef>
                <ns2:OrderRefID>d14a8d0c-74a6-4c3c-801b-8f9e17cf21c6</ns2:OrderRefID>
            </CancelOrderRef>
        </UpdateOrder>
    </Request>
</IATA_OrderReshopRQ>
```

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderReshopRS` XML document containing alternative offers.

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
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-27T19:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CPH</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS2</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS2</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-27T18:10:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>KRP</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>DX9901</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-27T13:16:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CPH</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS3</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS3</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-27T12:16:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>KRP</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>DX5078</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
            </DatedMarketingSegmentList>
            <DatedOperatingSegmentList>
                <DatedOperatingSegment>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS1</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>DX0500</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
                <DatedOperatingSegment>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS2</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>DX9901</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
                <DatedOperatingSegment>
                    <CarrierDesigCode>DX</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS3</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>DX5078</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
            </DatedOperatingSegmentList>
            <OriginDestList>
                <OriginDest>
                    <DestCode>CPH</DestCode>
                    <OriginCode>KRP</OriginCode>
                    <OriginDestID>OD1</OriginDestID>
                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
                </OriginDest>
            </OriginDestList>
            <PaxJourneyList>
                <PaxJourney>
                    <Duration>PT1H</Duration>
                    <PaxJourneyID>JOUR1</PaxJourneyID>
                    <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                    <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                </PaxJourney>
                <PaxJourney>
                    <Duration>PT50M</Duration>
                    <PaxJourneyID>JOUR2</PaxJourneyID>
                    <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                </PaxJourney>
            </PaxJourneyList>
            <PaxList>
                <Pax>
                    <PaxID>ADT1</PaxID>
                    <PTC>ADT</PTC>
                </Pax>
                <Pax>
                    <PaxID>INF1</PaxID>
                    <PTC>INF</PTC>
                </Pax>
                <Pax>
                    <PaxID>CHD1</PaxID>
                    <PTC>CHD</PTC>
                </Pax>
            </PaxList>
            <PaxSegmentList>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS1</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG1</PaxSegmentID>
                </PaxSegment>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS2</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>DX</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG2</PaxSegmentID>
                </PaxSegment>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS3</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>DX</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>DX</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG3</PaxSegmentID>
                </PaxSegment>
            </PaxSegmentList>
            <PenaltyList/>
            <PriceClassList>
                <PriceClass>
                    <Code>Bedre</Code>
                    <Name>Bedre</Name>
                    <PriceClassID>PC1</PriceClassID>
                </PriceClass>
                <PriceClass>
                    <Code>Economy</Code>
                    <Name>Economy</Name>
                    <PriceClassID>PC2</PriceClassID>
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
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>BDXBED</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>19b595c1-f705-434d-9545-6f9880423697</OfferItemID>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
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
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>fdd9ca32-c53c-42df-9821-f7420b1053ad</OfferItemID>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
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
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a48c1b31-ded2-4fb1-a65c-d8307768e0e9</OfferItemID>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
                                </PaxJourneyRef>
                            </OfferServiceAssociation>
                            <PaxRefID>CHD1</PaxRefID>
                        </Service>
                    </AddedOfferItem>
                    <OfferID>b078b669-bafa-418f-8d3d-6028ca6262ba</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">0.0</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>354c5a07-a5b2-4966-9b65-8e5029344766</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>7444ed2f-fb38-4764-a95a-6cbc0247d0f1</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>cb84417d-5a06-4aef-9bfa-505749cef4d2</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                    <OfferID>48a642b0-4907-40df-93e8-f73c3adcdbf6</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">27.81</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">127.81</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>29330a49-9b26-4406-abaf-5eaf95c74b8e</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>74377d9a-559a-4198-83ac-004067e5254d</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f7eab169-ab83-4095-ad6c-d067bbdd87fb</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                    <OfferID>030dcfda-0100-43cd-bb96-fdb4098846b6</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">27.81</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">127.81</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c441bf2a-3865-456f-bc60-277f1bb7a55e</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d7db5b0f-3c06-4c10-9ac1-65a2a1849596</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e3b8c7a8-2a4b-4703-9e46-613b83aeac0b</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
                                </PaxJourneyRef>
                            </OfferServiceAssociation>
                            <PaxRefID>CHD1</PaxRefID>
                        </Service>
                    </AddedOfferItem>
                    <OfferID>bada6f05-cdd6-4314-a947-cb55b1d8913a</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">27.81</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">127.81</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>13c2e1b5-a71a-49a2-8ac3-b4f65110b1bb</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">43.89</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">150.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d9792e57-1bd7-4d4d-9a0c-51b88779940d</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">50.0</BaseAmount>
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                                <FareBasisCode>YEXWT</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>7b45be77-ca20-431e-9b90-d655d2f39972</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">49.09</BaseAmount>
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
                                        <TotalAmount CurCode="USD">50.0</TotalAmount>
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
                    <OfferID>f86ce5ee-5d64-411e-8fcc-59d130f95e26</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">27.81</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">127.81</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8b9f23ec-e292-433e-adcc-aeb4b7f51926</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">94.21</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">200.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">94.21</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">200.32</TotalAmount>
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
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>62550378-d101-442b-873d-212e22e4c7f5</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">100.33</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">100.33</BaseAmount>
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
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
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4d99b234-0f47-49b6-85d9-3fa3be81f549</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">99.41</BaseAmount>
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
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">99.41</BaseAmount>
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
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
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
                    <OfferID>69e61144-bbfb-4f7f-b4a1-1a8a34d602fe</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">178.77</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">278.77</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <AddedOfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType>
                                    <CabinTypeCode>Y</CabinTypeCode>
                                </CabinType>
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4e775959-f778-411b-84ad-3902160abe8d</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">94.21</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">200.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">94.21</BaseAmount>
                                        <Fee>
                                            <Amount CurCode="USD">100.0</Amount>
                                            <DescText>upgrade</DescText>
                                            <DesigText>upgrade</DesigText>
                                        </Fee>
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
                                        <TotalAmount CurCode="USD">200.32</TotalAmount>
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
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>INF1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>25086f27-0581-4755-99d3-9fb4e47d9a79</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">100.33</BaseAmount>
                                        <TaxSummary>
                                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                                        </TaxSummary>
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">100.33</BaseAmount>
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
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
                                <FareBasisCode>YCALFATRAV</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>CHD1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>975c61f5-0019-4253-8e78-f72c4667c85f</OfferItemID>
                        <ReshopPrice>
                            <PriceDifferential>
                                <DifferentialTypeCode>AddCol</DifferentialTypeCode>
                                <DiffPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">99.41</BaseAmount>
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
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
                                    </Price>
                                </DiffPrice>
                                <NewPrice>
                                    <Price>
                                        <BaseAmount CurCode="USD">99.41</BaseAmount>
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
                                        <TotalAmount CurCode="USD">100.32</TotalAmount>
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
                    <OfferID>6644a161-543a-460c-a7cb-7860a6cda126</OfferID>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">178.77</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">100.0</Amount>
                            <DescText>upgrade</DescText>
                            <DesigText>upgrade</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>QQ</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>EU</TaxCode>
                            </Tax>
                            <Tax>
                                <Amount CurCode="USD">0.0</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>DC</TaxCode>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">0.0</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">278.77</TotalAmount>
                    </TotalPrice>
                </Offer>
            </ReshopOffers>
        </ReshopResults>
    </ns2:Response>
    <ns2:PayloadAttributes>
        <CorrelationID>6da0a3c4-0c8a-457e-b724-8f7e2b5faccd</CorrelationID>
        <Timestamp>2026-05-07T13:35:51.653+07:00</Timestamp>
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
<?xml version="1.0" encoding="UTF-8"?>
<ErrorResponse>
    <Error>
        <Code>400</Code>
        <Message>Bad Request - Invalid request format or missing required fields</Message>
        <Details>Request validation failed: Missing required field 'Request.OrderRefID'</Details>
    </Error>
</ErrorResponse>
```

</details>

#### 404 Not Found

Order not found.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>911</Code>
        <DescText>Order not found - Order with id 014a8d0c-74a6-4c3c-801b-8f9e17cf21c6 not found</DescText>
        <ErrorID>5fbfb652-2c04-464a-b36a-db353f990428</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Business</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderReshopRS>
```

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderReshop \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderreshop-request.xml
    ```

## Use Cases

### Rebooking Flights

1. Provide `OrderRefID` of the existing order
2. Use `AddOfferItems` with `FlightRequest` to specify new flight criteria
3. Use `DeleteOrderItem` to remove segments to be replaced
4. Response returns alternative offers matching the new criteria

### Canceling Segments

1. Provide `OrderRefID` of the existing order
2. Use `DeleteOrderItem` with `OrderItemRefID` to specify segments to cancel
3. Response returns offers showing the order after cancellation

### Canceling Entire Order

1. Provide `OrderRefID` of the existing order
2. Use `CancelOrderRef` with the same `OrderRefID`
3. Response returns cancellation information

## Notes

1. **Prerequisites**: You must have an existing order (from `OrderCreate`) to reshop.
2. **Order Status**: The existing order must be in `OPEN` status to reshop.
3. **Use with OrderChange**: After getting reshop offers, use `OrderChange` with the selected offers to apply the changes.
4. **Offer Selection**: Use the `OfferID` and `OfferItemID` from the reshop response in `OrderChange` requests.
5. **Order Item References**: Use `OrderItemRefID` from the original order to delete specific segments.
6. **Flight Requests**: When adding new segments, provide flight request criteria similar to `AirShopping`.
