---
layout: default
title: Air Shopping (AirShopping)
---

# Air Shopping

`POST` `https://api.go7.io/v21.3.5/AirShopping`

---

## Description

The Air Shopping API searches for available flight offers matching your criteria. Provide origin/destination airports, travel dates, passenger types, and optional cabin preferences. The response includes available offers with pricing and flight segment details.

## Workflow (NDC API guide)

**Step 1** in the Phased 1 chain ([NDC API — Offers & Orders workflow](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/AirShopping` · messages **`IATA_AirShoppingRQ`** / **`IATA_AirShoppingRS`**. Capture **`OfferID`**, **`OfferItemID`**, **`OwnerCode`**, and **`PaxRefID`** for **[Offer Price](offerprice.md)**. Scenario anchors: **`#airshopping-one-way-trip`**, **`#airshopping-round-trip`**.

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

The request body must be a valid `IATA_AirShoppingRQ` XML document following IATA NDC v21.3.5 standard.


### AirShopping — One-way trip
{: #airshopping-one-way-trip}

Single **`OriginDestCriteria`** (outbound only).
<details>
<summary>Request Payload</summary>

<pre><code class="language-xml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;IATA_AirShoppingRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                    xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"&gt;
    &lt;DistributionChain&gt;
        &lt;cns:DistributionChainLink&gt;
            &lt;cns:Ordinal&gt;1&lt;/cns:Ordinal&gt;
            &lt;cns:OrgRole&gt;Seller&lt;/cns:OrgRole&gt;
            &lt;cns:ParticipatingOrg&gt;
                &lt;cns:Name&gt;Travel Agency XYZ&lt;/cns:Name&gt;
                &lt;cns:OrgID&gt;SELLER123&lt;/cns:OrgID&gt;
            &lt;/cns:ParticipatingOrg&gt;
        &lt;/cns:DistributionChainLink&gt;
    &lt;/DistributionChain&gt;

    &lt;PayloadAttributes&gt;
        &lt;cns:CorrelationID&gt;{{$randomUUID}}&lt;/cns:CorrelationID&gt;
        &lt;cns:Timestamp&gt;2025-11-05T10:00:00Z&lt;/cns:Timestamp&gt;
        &lt;cns:TrxID&gt;TRX-123456789&lt;/cns:TrxID&gt;
        &lt;cns:VersionNumber&gt;21.3&lt;/cns:VersionNumber&gt;
    &lt;/PayloadAttributes&gt;

    &lt;Request&gt;
        &lt;cns:FlightRequest&gt;
            &lt;cns:FlightRequestOriginDestinationsCriteria&gt;
                &lt;cns:OriginDestCriteria&gt;
                    &lt;cns:DestArrivalCriteria&gt;
                        &lt;cns:Date&gt;2026-05-18&lt;/cns:Date&gt;
                        &lt;cns:IATA_LocationCode&gt;CPH&lt;/cns:IATA_LocationCode&gt;
                    &lt;/cns:DestArrivalCriteria&gt;

                    &lt;cns:OriginDepCriteria&gt;
                        &lt;cns:Date&gt;2026-05-17&lt;/cns:Date&gt;
                        &lt;cns:IATA_LocationCode&gt;KRP&lt;/cns:IATA_LocationCode&gt;
                    &lt;/cns:OriginDepCriteria&gt;
                &lt;/cns:OriginDestCriteria&gt;
            &lt;/cns:FlightRequestOriginDestinationsCriteria&gt;
        &lt;/cns:FlightRequest&gt;

        &lt;cns:PaxList&gt;
            &lt;cns:Pax&gt;
                &lt;cns:PaxID&gt;PAX1&lt;/cns:PaxID&gt;
                &lt;cns:PTC&gt;ADT&lt;/cns:PTC&gt;
            &lt;/cns:Pax&gt;

            &lt;cns:Pax&gt;
                &lt;cns:PaxID&gt;PAX2&lt;/cns:PaxID&gt;
                &lt;cns:PTC&gt;CHD&lt;/cns:PTC&gt;
            &lt;/cns:Pax&gt;

            &lt;cns:Pax&gt;
                &lt;cns:PaxID&gt;PAX3&lt;/cns:PaxID&gt;
                &lt;cns:PTC&gt;INF&lt;/cns:PTC&gt;
            &lt;/cns:Pax&gt;
        &lt;/cns:PaxList&gt;
    &lt;/Request&gt;
&lt;/IATA_AirShoppingRQ&gt;
</code></pre>

</details>

### AirShopping — Round trip
{: #airshopping-round-trip}

Two **`OriginDestCriteria`** blocks (outbound + inbound).
<details>
<summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_AirShoppingRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <DistributionChain >
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
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">32f9ddf2-bda9-4ca4-83ee-82a873c509f6</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-05-07T18:11:33.876+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <Request>
        <FlightRequest xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <FlightRequestOriginDestinationsCriteria>
                <OriginDestCriteria>
                    <DestArrivalCriteria>
                        <Date>2026-05-18</Date>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </DestArrivalCriteria>
                    <OriginDepCriteria>
                        <Date>2026-05-17</Date>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </OriginDepCriteria>
                </OriginDestCriteria>
                <OriginDestCriteria>
                    <DestArrivalCriteria>
                        <Date>2026-05-24</Date>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </DestArrivalCriteria>
                    <OriginDepCriteria>
                        <Date>2026-05-23</Date>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </OriginDepCriteria>
                </OriginDestCriteria>
            </FlightRequestOriginDestinationsCriteria>
        </FlightRequest>
        <PaxList xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <Pax>
                <PaxID>PAX1</PaxID>
                <PTC>ADT</PTC>
            </Pax>
        </PaxList>
    </Request>
</IATA_AirShoppingRQ>
```

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_AirShoppingRS` XML document containing available flight offers.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_AirShoppingRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Response>
        <DataLists>
            <DatedMarketingSegmentList>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-17T12:20:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS1</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS1</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-17T05:25:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>W29896</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-23T19:45:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS2</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS2</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-23T12:50:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>W29897</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-17T19:30:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS3</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS3</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-17T14:30:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>W29592</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
                <DatedMarketingSegment>
                    <Arrival>
                        <AircraftScheduledDateTime>2026-05-23T23:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>BOS</IATA_LocationCode>
                    </Arrival>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedMarketingSegmentId>DMS4</DatedMarketingSegmentId>
                    <DatedOperatingSegmentRefId>DOS4</DatedOperatingSegmentRefId>
                    <Dep>
                        <AircraftScheduledDateTime>2026-05-23T20:00:00</AircraftScheduledDateTime>
                        <IATA_LocationCode>CUR</IATA_LocationCode>
                    </Dep>
                    <MarketingCarrierFlightNumberText>W29593</MarketingCarrierFlightNumberText>
                </DatedMarketingSegment>
            </DatedMarketingSegmentList>
            <DatedOperatingSegmentList>
                <DatedOperatingSegment>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS1</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>W29896</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
                <DatedOperatingSegment>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS2</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>W29897</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
                <DatedOperatingSegment>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS3</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>W29592</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
                <DatedOperatingSegment>
                    <CarrierDesigCode>W2</CarrierDesigCode>
                    <DatedOperatingSegmentId>DOS4</DatedOperatingSegmentId>
                    <OperatingCarrierFlightNumberText>W29593</OperatingCarrierFlightNumberText>
                </DatedOperatingSegment>
            </DatedOperatingSegmentList>
            <OriginDestList>
                <OriginDest>
                    <DestCode>CUR</DestCode>
                    <OriginCode>BOS</OriginCode>
                    <OriginDestID>OD1</OriginDestID>
                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                    <PaxJourneyRefID>JOUR2</PaxJourneyRefID>
                </OriginDest>
                <OriginDest>
                    <DestCode>BOS</DestCode>
                    <OriginCode>CUR</OriginCode>
                    <OriginDestID>OD2</OriginDestID>
                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                    <PaxJourneyRefID>JOUR3</PaxJourneyRefID>
                </OriginDest>
            </OriginDestList>
            <PaxJourneyList>
                <PaxJourney>
                    <Duration>PT6H55M</Duration>
                    <PaxJourneyID>JOUR1</PaxJourneyID>
                    <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                    <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                </PaxJourney>
                <PaxJourney>
                    <Duration>PT5H</Duration>
                    <PaxJourneyID>JOUR2</PaxJourneyID>
                    <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                </PaxJourney>
                <PaxJourney>
                    <Duration>PT3H</Duration>
                    <PaxJourneyID>JOUR3</PaxJourneyID>
                    <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                </PaxJourney>
            </PaxJourneyList>
            <PaxList>
                <Pax>
                    <PaxID>ADT1</PaxID>
                    <PTC>ADT</PTC>
                </Pax>
            </PaxList>
            <PaxSegmentList>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS1</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>W2</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG1</PaxSegmentID>
                </PaxSegment>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS2</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>W2</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG2</PaxSegmentID>
                </PaxSegment>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS3</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>W2</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG3</PaxSegmentID>
                </PaxSegment>
                <PaxSegment>
                    <DatedMarketingSegmentRefId>DMS4</DatedMarketingSegmentRefId>
                    <MarketingCarrierRBD_Code>W2</MarketingCarrierRBD_Code>
                    <OperatingCarrierRBD_Code>W2</OperatingCarrierRBD_Code>
                    <PaxSegmentID>SEG4</PaxSegmentID>
                </PaxSegment>
            </PaxSegmentList>
            <PriceClassList>
                <PriceClass>
                    <Code>NOTREBOOK</Code>
                    <Name>NOTREBOOK</Name>
                    <PriceClassID>PC1</PriceClassID>
                </PriceClass>
                <PriceClass>
                    <Code>Residente</Code>
                    <Name>Residente</Name>
                    <PriceClassID>PC2</PriceClassID>
                </PriceClass>
                <PriceClass>
                    <Code>Economy</Code>
                    <Name>Economy</Name>
                    <PriceClassID>PC3</PriceClassID>
                </PriceClass>
                <PriceClass>
                    <Code>ECOBOSCUR</Code>
                    <Name>ECOBOSCUR</Name>
                    <PriceClassID>PC4</PriceClassID>
                </PriceClass>
            </PriceClassList>
        </DataLists>
        <OffersGroup>
            <CarrierOffers>
                <Offer>
                    <OfferID>b6ef526e-9bea-4c6d-8747-04f75557a41c</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ad5b8ef8-34c0-43e7-a6a8-098b8f757aae:d09f6ce5-2867-4882-842a-0150ee1fed3f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>538c5c53-6095-4925-971f-60c0acb3d08c:29b184be-ac97-4420-87dd-e241454cea23</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">8.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>5e368ca7-dc0d-4e6e-904e-8ef0c7a8e482</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>499ae9ac-8c4f-44bc-a801-1e5830da6f03:b06f9157-247f-4ea9-a838-05c4163bc547</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>2bbfe0af-8044-4c3b-8cc8-30ee14438e68:70ff1fca-1d15-43d1-b446-cc82a04b2dfc</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">8.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>2fc142aa-f679-45d9-b237-af1e6e460124</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b6343a7e-aac0-4da1-9bb7-93272ee2e0aa:884de015-a335-471b-9bb6-44ad388dddcd</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>dc49c261-401c-43c1-8dd9-87dfc932aafc:802fb54e-8206-48ec-82cf-fc8f1dfd3a0e</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">8.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>23a8990d-fb51-4348-a3bb-17497c69fbeb</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c799f69c-2651-4f45-a500-24376afd3a74:600581c4-b8c4-47b9-8369-823d8b25f60a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b650efc7-2c95-498c-a56f-aa8223801b91:a4b0fa45-e074-419e-8d32-12897330ee91</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">0.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">8.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>9e996610-9c26-4a58-975d-c6c1b8435abb</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f0c98075-2e94-4180-bac9-7ab6c783dd9a:12b15b49-394b-49bc-8032-74453e1a9b0a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>0f019124-5c39-4ecc-a09b-631d0f948070:7ec4ed5c-fa3d-460a-913b-fbc1b86eed36</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>6e002125-8a7f-4020-8207-f3ccbeee1c68</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e92951e4-550c-4be2-a885-41001b0ff58b:71d71c5e-564d-4623-94a3-ba1162695ea5</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>eb62c92e-3266-4b14-b1a4-6fef601cb166:b0cb1c0e-432b-4298-8068-8bd3d05a3d91</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>90c29a51-7968-4f7f-9c1a-0147393f3431</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c677050e-8023-4181-a101-91e839de5fa4:07c53052-a2fa-45f9-aa25-fa7f880703d8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>347eeff2-e699-4a51-a5f5-a3afb65d9331:483426a8-34ed-4974-8930-c53b487f733c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>f4cd3bfc-08ac-46b7-9e37-21db5cf4ef94</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>31076ecc-a06e-4276-b02f-34ed2e529083:cfe53576-bc90-46e2-a956-52ea1759689e</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>867f61c8-e2df-4731-a298-37fdd0b13fb0:6ba32dae-c792-4cd5-bf64-b89d16b572a6</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>da2da085-17c9-40bb-baa3-92a1fc1dad49</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>01281331-9d50-4a72-b144-0dd0c3869696:4b25248a-2e2f-4378-92c4-371d0f7d6d64</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>191b07e4-5558-46fa-b3f1-0d94e00ad1f8:eda14400-44a1-4ded-a32a-113a1c05dfe2</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>a6ad400c-e16f-414b-a2e5-dcb4cbab8f43</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>afa3fae6-88c5-4b27-8a2d-3719ad151d82:fe009933-abc4-4bb2-b6cc-f4fd18f12125</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>90293ffb-0b5b-429b-a005-8e1e510b2148:62ebf469-25ad-4f22-ae05-c842741a8a75</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>80dcf1d7-c137-4345-8162-5f1b5fd356c8</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>fd904af9-e004-4208-809d-03b86324cd93:cdbe8e57-e05d-4c57-8a10-27c63cc8d0fe</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b1eaa812-b109-442f-848e-e146dc49570a:73e953c1-e808-4431-a380-a7616102d893</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>38fdceb7-f9a3-43bf-b51c-4b9a542adb43</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>eb7635ee-97c1-4d71-bf20-f4c171ab80d9:eab00359-27f3-4dd2-8502-5f206c994e9e</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ccc70929-503e-4a67-886b-d836127ed9dd:a21e5ea7-d54f-49c0-8dd4-7c8a43531b3c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">9.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">21.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>094f40a5-5be2-4a29-a431-3746a68b12d9</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>7b879ba5-8397-49bd-a099-99639a509362:d64fb472-a644-460a-a428-2ecd140401ab</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>294eace1-1e72-4a06-bbe3-e7e9cbd4fc27:1fe7fdeb-a8c2-4010-8752-6cab308b0bbe</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">19.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">34.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>24d95b68-1f37-4ef6-98dc-1fa397fd841e</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ed24e2ce-96e1-45db-b0a3-7d1aafdb19e9:a396a516-1eb7-48f3-9f79-135e645ce1cc</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d0f5c939-dfc4-4b70-988c-314a53d70af9:c718d570-81a9-4a0a-b83d-b717153548f8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">19.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">34.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>264d9279-94be-468f-802a-abba71e33edb</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a158002b-a923-477f-8be9-54f4f4cfd1ae:10cf6fe2-70ac-4bf9-86eb-b0522eb6e643</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e570f64a-1076-4111-9122-6078ffd2b072:bbc58266-f43e-4415-ac65-198d003fc1a8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">19.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">34.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>62186987-bb14-497a-a1db-a1fcb3ee32b6</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>3bfad0bd-cf6a-4d0b-93e8-79b075356fd4:b7fe7d47-61a5-4fbf-b52a-6505cf6c6d75</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>7b4e5dd3-231f-43f0-b48c-d7555b3a2be2:f8d88125-8a14-4826-a832-661093eff115</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">19.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">34.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>fcf546cb-6863-42ba-83dc-ab9554b3f619</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e032e61a-cf45-483b-9440-9fd37e8c8225:6816f0a3-7aa8-4399-af90-8b5f0082b708</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>fa856d61-6544-427c-b781-339f91ee7eeb:6a78f8ff-9c3a-4ed6-bb4f-9d66c231667a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>d0f05951-91bd-4d9c-925b-36bc0d111984</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d9ea2802-0bda-4faf-9194-d81d7da2f0f5:c85a66bf-6f36-4db7-b729-4eba9e2ac429</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f079f2e5-1a8e-4b53-84bf-d7fb2796e17f:d01d4025-0df9-4c36-98bb-f1f0b1b951e1</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>79ef8cc1-a5e1-4acd-9f39-e64eeec13fd0</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>81c9ed3f-46fb-43c8-bba7-b8b76f9dc094:dd33545c-3027-449e-8f34-ec6e6367afea</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d8354896-39a6-4cce-bf9a-a5f3a59ba930:b70ec583-a495-43f0-9e72-6c213b45bbfc</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>64408350-9c11-4c03-b0c8-4b8d2c36385a</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>82b8c31a-0a9f-472b-9f91-096a5b6c913c:91a0494f-8427-4500-ac11-66f8a89b9398</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>6250f852-64b3-49d1-b4fd-53f4d325422e:385e26c9-9d86-4e3c-a78f-df6746bbaa57</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>c8827227-82f2-4b6d-a846-5383d89f97ff</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>eb9d8e5e-7b14-4a5d-8aa2-c8b9dae5262a:b74d6c82-ebbb-46f2-adf3-35023c42fd30</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>581eedab-9e23-432f-954a-7b11472693a6:1a9d9cfa-0da4-44be-825e-52d32af6af6b</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>2ebad492-d041-43fe-a39a-26a5994fee41</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ecab9766-4d2d-4261-ae32-396e4ce4bdf2:7f737199-76b8-438f-be12-474073935f8f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>88cd6e5d-951f-4826-bafd-cc0105ed1529:8518e9c9-7376-4960-9dea-a265edf5c486</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>10416b65-dc45-438b-8b25-fec16296ce6c</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c7c2aa1f-b6fb-4d8d-9a12-97f043f7d6fd:d6c0bfea-b232-4309-8fe6-c1a7f53f1730</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>649772f6-1f77-440d-9d56-377cbfb8bb30:dc16e0a4-a92e-411b-8a2e-b13d421a9088</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>8d4e555e-50ae-423f-b7be-cc5a39ebfab1</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4ea55505-d712-44b0-9b8b-a6a4ad11e0ed:050636c9-18cb-48b0-a735-ca9acb9a0206</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4096ed37-0290-42b3-a4df-26bb310691af:3f0a7b7f-9038-4027-961d-c7f816973737</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">100.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">108.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>17bc4e38-7571-4dcd-96fc-543f685de7ab</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d3ced970-595d-46bd-aceb-b2d5f2bb99b2:162d2e90-78af-4898-9da9-8a57e8197228</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>1447a851-da6f-46a9-9507-95e4299258c8:7dd4149b-960c-49eb-872f-55a8de27ba5b</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>38a78fec-0aaa-4e13-bf13-422a939e6e0e</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>5b986104-0bc4-4128-884d-e4bb142c324a:76dfe143-aa83-4f64-bdfe-20adfa4cb4b8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>6ff6892d-a169-4f2e-936f-3482f86c1ec0:b567b672-ea6b-439a-a73b-badebb68aea9</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>d4ff10d5-c819-4eb2-8a36-29b75a8187d5</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f32710f3-88f0-4869-907a-4244b09c68d6:d8f076bf-743f-4c6f-8787-5086d708df6a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>9a6ec725-31b7-49b4-b602-8fb7d4814e3e:52b38b58-77e3-4bfc-af5e-d3a50faad07f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>5bfdac2f-6fcc-42a0-a925-9231e751b9d4</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>5e188021-9d13-424a-bbb1-e43507d2cbb1:ef403946-2c1b-47e9-a09c-15d1f6497bb6</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b0e6de3f-bd8e-4c97-8095-802f125ff5e6:598a13dd-d42c-4f14-92d3-76adefcfbd91</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>4c7e199c-5628-4628-8455-16048551d4e8</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>826e88e8-baae-4e21-92cc-9192c840dba3:605a3b27-60b9-4b89-8215-b6ef8249aa3c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b3591e32-efc6-4149-87e1-26e2b0fff535:d1cedc31-deba-4595-8095-47d0f349bcf8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>805e4de9-d78c-4327-83cd-76e57eb5ee12</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>1a4d74c6-4477-47ad-87d1-ac753e914d12:88ee6052-4dfb-4730-94a0-18be39c607e9</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>02995f46-9a1d-40cf-a86f-0b50b746b242:cfdea5fd-f4cf-4f39-a6b8-af13701b0ff0</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>57e785c3-3084-4b78-aad2-68c80169fa3d</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f8ebed04-c8a9-4be4-8e2c-54b148fc3442:f148cd33-c335-4a2e-963d-63bf1d768e8c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c9ce7754-0a96-4414-8019-78645f925ac0:09f23bc3-61e7-4765-af1a-abc1107e3999</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>40d0b4fc-36e3-431a-90dc-aac2c75fe9c2</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>82d00947-00b0-4814-b268-e3c55770bc46:e758c3cb-fce7-4ab9-9e9e-06d97187ad79</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>0a016038-bddf-4380-8dcc-2f84d95d0ebd:9bb80035-b2fa-4815-8a51-73c7d7f1fe1a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">109.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">121.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>e9e3b16a-ab91-4392-81b5-8ae3ee7bf380</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>725d0ca7-456d-4288-9d13-d80cf676062e:da2f208b-7e54-4536-a1e1-1d352e05f9d8</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>15d20b4f-c225-4e14-a61e-fc5587266067:21da8877-d4cd-4bf2-8c77-4a5ffee05c99</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>3e1a947b-fca9-4e5d-8740-ea8d3f728fd9</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>55113dab-0ad4-4c05-9e09-080a72f4151c:db8d2d26-75ac-4b93-9bef-c0c4f012c30f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b2a771fb-214a-40d6-a575-92b729591ff5:624b480c-84e8-47cf-8c88-5a7e8375c6b4</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>4270d7e9-55a5-45a4-ac5a-2d8211288e90</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>5d36b89b-00bb-4051-8a9d-9c8abbc8592e:b04daee8-291f-41ff-822d-3679cb228630</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4ea3904e-67be-408c-b5a2-2d23d3a75237:26a9c559-e5c3-4af3-940b-e3d5524d7d85</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>5b3bfedd-9258-41cf-8115-78059c283417</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>dea41275-97f9-4a08-bdb2-e2391a2e6c57:cc134fc0-88f1-4a2e-9fab-0ec4b16f19c7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>d38bf9b1-f5c4-4175-9a79-1c4d9c44e6c1:1ad9484c-5d19-4011-b976-7ff90b126b53</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>ef836c27-ec56-4039-9641-1de7ee88a9a9</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>aa3aef4d-9853-4144-a068-11fc7a395bfa:2d3f9e03-3afd-4869-b2f4-501f8fefdb3e</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>fed08ae6-c77a-471c-add6-fdb4448170f0:6ba0373a-c86c-495a-bfc3-f215be422f37</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>f9fb89ba-6d98-4c9d-b3a8-eb1dfb75c32a</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>12741608-c88b-4c63-bca0-1fe4ef76a772:0a57ec0e-e3f0-489f-b596-7475f5234cb7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>6759d40e-e70c-4e79-9007-f5bc3a0c1bb6:3e1a6199-e9bf-4678-a832-c8c357352a80</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>75d6d2ed-b3f5-4e4e-a533-905d0775cd7f</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f5d27cf8-ff7b-4782-8a4a-efe40b8fc413:7bf53f09-846c-4b48-b7a8-f637be91b994</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">4.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8000388d-9ff5-4985-9f0f-0a653e9c11c8:78d6e6ce-79fe-4e66-abab-6c36d2cb0630</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>b0f7015d-6cd1-4c85-ad99-bf143566511f</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b95272ab-b008-438f-be9f-7fae2f080b80:39af6f9b-9741-4b72-b197-fbca9aa1c3bb</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>Y_NOTREBOOK</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC1</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>bf9b80a8-1f8a-4b71-9032-379771707311:83471f14-f061-4348-a47d-31f563c33a91</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">0.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">3.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">125.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">136.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>abfbeeeb-88e5-45c1-9bc2-dc548c9c1bbd</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>33b0d335-3dd6-4ea1-a2a3-1a6392d61413:627e1f97-8b2a-4e32-b3ca-1cd2a79a05ed</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>2d1f6ba0-c64a-4a2e-b64d-0f2aace7252b:e1db5075-8640-4f4f-ae86-345eefa1fd51</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>f9962420-f08a-41e3-ab6c-aea4295223cc</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>580e433a-63eb-467a-a344-9b9478f06036:2af693b1-e65a-491d-a108-c4ecb3b37a5a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>eaa0536b-1b17-4a61-b615-5df39a2fcef7:40fb4fb3-15f1-4f9b-b8b6-087f27b1f34c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>83f025be-de72-4ebb-9b0a-06b82c37b70c</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>bf47c1c3-599f-4ef7-a3fc-a29b989f24cc:8484ace9-91cc-4a57-bdc6-7194dab62384</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b1988f65-b990-45f7-bba0-1e6d5e46934c:7267cc6a-2363-483c-a8d8-3ed9ebed0e63</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>cc62fc64-33b4-4a54-aeaa-0282c5e83462</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>387bde89-0f5e-4703-a8c1-51865b17926d:951c8e09-4472-4618-8655-c1dcc2750489</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>675c789d-abe9-4134-8d29-51be37dc23d8:0eb857f2-da22-40f2-90b2-35b5a8591a8f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>575e21cd-56a5-4bf9-98fe-b511023563c7</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a9d0e02e-aa7a-472d-b902-5aa440057c4f:b1941e5a-51c6-4285-a09a-3f365a0fa5b7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a01e22dc-d413-48b2-884c-9d3c9e50d5b5:fb9cebe2-d67e-4aaf-830e-2b8bfa518e16</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>ec895d34-03b0-4dea-902d-754b7264394e</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>78d7e044-8884-4532-babd-9d19a3e98f47:dae3748d-aa35-4057-9eeb-85a700134eef</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">17.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>9150a8fb-f6c0-4370-b0af-b25fa0a6edb2:56d2ae63-aca0-40c4-b138-e9788d56080c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>5f5d5abe-5a09-41cb-8c1e-328402e9b512</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>35d6e855-fbde-4733-a150-576bccd41ab6:418c01fc-663f-457d-9dd5-49b4909884f0</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b7189521-9942-41f3-83c0-fa3b3d354196:f7ec7a0b-7d54-4b46-8bd2-b6fa0c1322f2</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>3e26e40d-feac-46dd-b6b7-6bfe7ef70b93</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8f998582-6dbd-4ac2-ba1a-260b8019b83f:baa04961-a115-42e5-b8b4-29cdaaff8854</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>RESIDENTBOS</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC2</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8ab7a3f2-6af7-4646-a1d3-028b07b9eaa5:dc023576-f59d-434d-a922-256738a0a51c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">9.5</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">16.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">134.5</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">149.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>bb8c5b06-788f-4db7-b5a3-c0ed0b1e0867</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>18fce3b9-77aa-4ed9-a7aa-29118c4ef2c7:f9ea42e7-d1cf-415b-8fa0-c29f659b99a7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ae4c6c17-6616-4edb-8a35-e19d26955358:fa72d851-dc78-444f-ae8d-a8d28f612d52</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">200.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">208.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>e0d6525b-0626-4f15-b681-9acc6b7e50de</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ced81520-8aef-428d-80ac-91f9005c4c44:c00ee766-6e8f-429e-83ab-355d154a49c2</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>87a427af-3ed1-4897-b7b3-29018cbab2ac:65e36f3e-4f36-4a9e-a52a-15c06aae51fa</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">200.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">208.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>8907ca0a-9dca-4e1a-9392-4deebbc8d6ae</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>3a1405de-8d27-4c14-8f3a-46e6fb773ad5:81988c44-6b03-4d09-8c98-9ad6d0afd8b7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8580197f-e745-49af-90d4-82f87bd7f6b7:597c5c9c-b63b-40ec-93be-e88065b4d4f2</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">200.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">208.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>fa384e4c-3942-4ae2-b697-099184e8b820</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>494612e7-67e4-4eda-b6fe-e7dc38d77a89:725e663d-774c-4cd2-a461-1f943e3b01e7</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>dad2e0af-1afc-45bb-b9b3-52eb857ad214:67a22646-3f3f-4237-bdec-9913d292dfcb</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">200.0</BaseAmount>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">208.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>07934bf8-2127-47b1-ae8d-709c8123b26e</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>3f0822a0-272c-42c1-9649-c1e5ed6c8433:9ffbd2db-2350-415f-955b-b631804a2c58</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>448da48e-6125-4bba-b437-d871f3a5c2d4:4ff3c855-99ad-4a01-a5f8-e3fb1de18741</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>0fa1b27d-92e1-4473-9535-fff831abdc2f</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>4981eb63-4d9a-4628-80ea-68857e8f20ce:b6b48709-cc08-4fd0-8741-a6c68e5260fa</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>9cb46b27-85e6-4fc5-b1b3-431ca07eb5e6:64c2061d-3b30-4f35-900b-4ff2d454c976</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>d54e4d7b-0b13-4ceb-ada8-6f93b1c135f9</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>471da8dc-029d-4d76-9e47-664b14621dde:1cb379ce-a2e3-4f15-9f1f-7da30b07a61f</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a945fc1e-eab1-456d-ab72-b7c1e42891da:fab91a1b-ddc2-40a5-8a6a-987b6bbacbb2</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>aba0062c-e5ef-4107-98fe-1081bd6541c8</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8aea279f-a13c-417f-bbdb-c21536c2c44d:bd0561f4-715e-401b-90bc-73243f950dbd</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>29578804-2220-4357-9a9e-02aa7a423998:8124dbbf-9da0-4e50-8bea-4aa541615769</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>0979dd5b-823e-4996-b2c2-438dc1a4dc6a</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>180f42aa-c850-463d-b479-26540205f015:caea0a62-9897-48d0-905e-e0b58735d48a</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>b06b3ce8-097c-49ea-93e3-83274a73036a:5b5dbe7b-64a8-4b8f-8ea4-3d72c6f310dd</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">103.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>2123d3b2-5da0-47cb-a936-1a0e2f53f01b</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>5118733b-073f-4b7d-a850-756d0a003289:044f832c-a6f9-40dc-a502-5a7ae825d67b</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>7ec93781-8332-4b15-afef-99a8fe843619:6b051063-a5b7-40c4-b49b-91c10c6b13c3</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>c1e6bf5d-1132-4a6f-8b7a-6ce10478b601</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>a3d04b7c-0c24-49c9-8f98-e2b2cd5c8ed8:64bd57df-26ce-40b5-a4e1-e826a7e4d0f5</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>f3ec2dd7-c953-40e6-a104-f86bd01a8847:efa6822c-bdff-4fbe-b4f7-901a7656cb2c</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>23f17140-e84c-4b1f-ab6c-959c1df60459</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>SIT_ECO_PNLTY</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC3</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>422ef8c8-01cc-4e8e-b9d8-9693f06fb608:2649df16-d516-4362-9385-3f4eec6c5eff</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">100.0</BaseAmount>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">104.68</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>303d9bab-a26c-4afa-ae21-b22929676753:0cbe4b27-104e-4036-bfc3-951ccf56615b</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">225.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">3.5</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">236.86</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>ccf7b2b8-faf4-44e2-bf71-71dae4cac6e5</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>815c21c2-d7a2-4cbb-a2d9-5af986b3ee83:9d88165f-0546-412d-93fd-6d36285a3966</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>324c098b-059c-4ae7-8b19-83b79ff37939:f29ae513-55d1-4841-aa3d-8f8a0c367577</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">250.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">265.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>200306e5-1703-4e81-be87-6534cee7eee2</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>e72d6455-d551-4172-b0e4-6d10a05f8000:fb690847-5132-4582-946c-e9a7fa4ce6ba</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG2</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>77d25088-7311-4df4-8af7-edc9240fdd02:23d71cae-1587-4da1-b497-46d1aeaa3c3d</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">250.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">265.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>00ae5dec-fa9c-4e60-99a3-27c136e47119</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>8d9cea4a-9a17-44dc-aa27-b30d59f3f48f:b76a51d3-ddb9-4640-ba73-485e65bd10c1</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>ffb37b31-9410-47e5-b975-2d0fb5f1c3be:3631375c-eb9c-431f-a2aa-14e361bd9f6b</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">250.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">265.36</TotalAmount>
                    </TotalPrice>
                </Offer>
                <Offer>
                    <OfferID>0fc63303-b63e-4715-9afc-b3ddbb51fd65</OfferID>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG3</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>c574ea05-f9ed-4a44-8f36-22581866afcd:dcd36c63-3094-4881-996a-ab1b7eebf03e</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">4.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">4.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">133.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <OfferItem>
                        <FareDetail>
                            <FareComponent>
                                <CabinType/>
                                <FareBasisCode>ECOBOSCUR</FareBasisCode>
                                <PaxSegmentRefID>SEG4</PaxSegmentRefID>
                                <PriceClassRefID>PC4</PriceClassRefID>
                            </FareComponent>
                            <PaxRefID>ADT1</PaxRefID>
                        </FareDetail>
                        <OfferItemID>620f7325-6e02-4cc4-aca7-9a22cc6552b9:a4c6012a-ad5e-45ae-b7c9-b39ed0916422</OfferItemID>
                        <Price>
                            <BaseAmount CurCode="USD">125.0</BaseAmount>
                            <Fee>
                                <Amount CurCode="USD">3.5</Amount>
                                <DescText>reservation</DescText>
                                <DesigText>reservation</DesigText>
                            </Fee>
                            <TaxSummary>
                                <Tax>
                                    <Amount CurCode="USD">3.68</Amount>
                                    <DescText>Tax description</DescText>
                                    <TaxCode>E4</TaxCode>
                                    <TaxName>E4</TaxName>
                                </Tax>
                                <TotalTaxAmount CurCode="USD">3.68</TotalTaxAmount>
                            </TaxSummary>
                            <TotalAmount CurCode="USD">132.18</TotalAmount>
                        </Price>
                        <Service>
                            <PaxRefID>ADT1</PaxRefID>
                            <ServiceID>1</ServiceID>
                        </Service>
                    </OfferItem>
                    <TotalPrice>
                        <BaseAmount CurCode="USD">250.0</BaseAmount>
                        <Fee>
                            <Amount CurCode="USD">7.0</Amount>
                            <DescText>reservation</DescText>
                            <DesigText>reservation</DesigText>
                        </Fee>
                        <TaxSummary>
                            <Tax>
                                <Amount CurCode="USD">8.36</Amount>
                                <DescText>Tax description</DescText>
                                <TaxCode>E4</TaxCode>
                                <TaxName>E4</TaxName>
                            </Tax>
                            <TotalTaxAmount CurCode="USD">8.36</TotalTaxAmount>
                        </TaxSummary>
                        <TotalAmount CurCode="USD">265.36</TotalAmount>
                    </TotalPrice>
                </Offer>
            </CarrierOffers>
        </OffersGroup>
    </ns2:Response>
    <ns2:PayloadAttributes>
        <CorrelationID>32f9ddf2-bda9-4ca4-83ee-82a873c509f6</CorrelationID>
        <Timestamp>2026-05-07T18:11:33.876+07:00</Timestamp>
        <TrxID>TRX-123456789</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_AirShoppingRS>
```

</details>

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

<details>
<summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_AirShoppingRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>911</Code>
        <DescText>Bad Request - 400 No availability</DescText>
        <ErrorID>13cbd55d-ca60-4030-8ae0-501401371615</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Business</TypeCode>
    </ns2:Error>
</ns2:IATA_AirShoppingRS>
```

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/AirShopping \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @airshopping-request.xml
    ```

## Validation Rules

### Passenger Type Codes (PTC)
- **Supported values**: `ADT` (Adult), `CHD` (Child), `INF` (Infant)
- **Required**: Yes, for each passenger
- **Invalid values**: Will result in 400 error

### Dates
- **Format**: `YYYY-MM-DD`
- **Validation**: Must not be in the past, must be within schedule window
- **Invalid dates**: Will result in 400 error

### Airport Codes
- **Format**: 3-letter IATA airport codes
- **Validation**: Origin and destination must be different

## Notes

1. **Minimum Required Fields**: `Request.FlightRequest` with at least one `OriginDestCriteria`, and `Request.PaxList` with at least one `Pax`.
2. **Round-Trip Searches**: Include multiple `OriginDestCriteria` elements for round-trip or multi-city searches.
3. **Offer IDs**: Use the `OfferID` and `OfferItemID` from the response in subsequent `OfferPrice` requests.
