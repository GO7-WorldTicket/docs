---
layout: default
title: Offer Price (OfferPrice)
---

# Offer Price

`POST` `https://api.go7.io/v21.3.5/OfferPrice`

---

## Description

The Offer Price API returns detailed pricing information for selected offers from an Air Shopping response. Use the `OfferID` and `OfferItemID` values from the Air Shopping response to request specific pricing details including base amounts, taxes, and total prices.

## Workflow (NDC API guide)

**Step 2** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OfferPrice` · use **`OfferRefID`** (= **`OfferID`**), **`OfferItemRefID`** (= **`OfferItemID`**), **`OwnerCode`**, **`PaxRefID`** from **AirShoppingRS**. Priced offer feeds **[Order Create](ordercreate.md)**. Scenarios: **`#offerprice-one-way-trip`**, **`#offerprice-round-trip`**.

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

The request body must be a valid `IATA_OfferPriceRQ` XML document following IATA NDC v21.3.5 standard.

### OfferPrice — One-way trip
{: #offerprice-one-way-trip}

One **`SelectedOffer`** with typically **one `SelectedOfferItem`** per direction when the shopping offer contained a single outbound slice (adjust **`PaxRefID`** to match shopping).
<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OfferPriceRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                   xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <DistributionChain>
        <cns:DistributionChainLink>
            <cns:Ordinal>1</cns:Ordinal>
            <cns:OrgRole>Seller</cns:OrgRole>
            <cns:ParticipatingOrg>
                <cns:Name>Travel Agency XYZ</cns:Name>
                <cns:OrgID>SELLER123</cns:OrgID>
            </cns:ParticipatingOrg>
        </cns:DistributionChainLink>
    </DistributionChain>
    <PayloadAttributes>
        <cns:CorrelationID>ASR-001-2026</cns:CorrelationID>
        <cns:Timestamp>2025-11-05T10:00:00Z</cns:Timestamp>
        <cns:TrxID>TRX-123456789</cns:TrxID>
        <cns:VersionNumber>21.3</cns:VersionNumber>
    </PayloadAttributes>
    <Request>
        <cns:PricedOffer>
            <cns:SelectedOfferList>
                <cns:SelectedOffer>
                    <cns:OfferRefID>9292c7a4-a0d6-4f30-befa-2c197def7ac9</cns:OfferRefID>
                    <cns:OwnerCode>VS</cns:OwnerCode>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>982ec9bd-bcff-452d-a1e4-c1d4ba131eb8:46cd5362-2582-42bb-82e1-3fb260f1ac85</cns:OfferItemRefID>
                        <cns:PaxRefID>ADT1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>3cbc88b1-ab28-45c7-a4bf-6a52a2153c48:12b9a65a-35d3-4a3f-93d2-5160ffc16eca</cns:OfferItemRefID>
                        <cns:PaxRefID>CHD1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>4e6be961-b8c4-4cec-8f9c-1d586e22f87f:b1226bf0-5901-4f48-977f-34089fbcec91</cns:OfferItemRefID>
                        <cns:PaxRefID>INF1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                </cns:SelectedOffer>
            </cns:SelectedOfferList>
        </cns:PricedOffer>
    </Request>
</IATA_OfferPriceRQ>
```

</details>

### OfferPrice — Round trip
{: #offerprice-round-trip}

Same **`OfferRefID`** when both directions sit under one offer; **two `SelectedOfferItem`** rows (IDs from **AirShoppingRS**).
<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OfferPriceRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
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
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-05-07T18:34:11.567+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <Request>
        <PricedOffer xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <SelectedOfferList>
                <SelectedOffer>
                    <OfferRefID>0d8ef628-02f3-4f3b-ba6b-d6bbf8e661d1</OfferRefID>
                    <OwnerCode>VS</OwnerCode>
                    <SelectedOfferItem>
                        <OfferItemRefID>a3db17db-e4d7-4d30-95ce-8f634d16bafc:af9c85a0-e93b-4f2c-91b2-eb7d7e7d1e48</OfferItemRefID>
                        <PaxRefID>ADT1</PaxRefID>
                    </SelectedOfferItem>
                    <SelectedOfferItem>
                        <OfferItemRefID>19fff8c1-ad9f-4a23-ad4a-fd434356350e:e7756a5a-7194-4c7e-a0ec-28da794e8562</OfferItemRefID>
                        <PaxRefID>ADT1</PaxRefID>
                    </SelectedOfferItem>
                </SelectedOffer>
            </SelectedOfferList>
        </PricedOffer>
    </Request>
</IATA_OfferPriceRQ>
```

</details>

Round-trip **responses** match the one-way shape but include **two** `OfferItem` blocks (taxes/fees per carrier rules).

## Response

### Success Response (200 OK)

Returns an `IATA_OfferPriceRS` XML document containing detailed pricing information.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OfferPriceRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
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
            </DatedOperatingSegmentList>
            <OriginDestList>
                <OriginDest>
                    <DestCode>CUR</DestCode>
                    <OriginCode>BOS</OriginCode>
                    <OriginDestID>OD1</OriginDestID>
                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                </OriginDest>
                <OriginDest>
                    <DestCode>BOS</DestCode>
                    <OriginCode>CUR</OriginCode>
                    <OriginDestID>OD2</OriginDestID>
                    <PaxJourneyRefID>JOUR1</PaxJourneyRefID>
                </OriginDest>
            </OriginDestList>
            <PaxJourneyList>
                <PaxJourney>
                    <Duration>PT6H55M</Duration>
                    <PaxJourneyID>JOUR1</PaxJourneyID>
                    <PaxSegmentRefID>SEG1</PaxSegmentRefID>
                    <PaxSegmentRefID>SEG2</PaxSegmentRefID>
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
            </PaxSegmentList>
            <PriceClassList>
                <PriceClass>
                    <Code>NOTREBOOK</Code>
                    <Name>NOTREBOOK</Name>
                    <PriceClassID>PC1</PriceClassID>
                </PriceClass>
            </PriceClassList>
        </DataLists>
        <PricedOffer>
            <OfferID>0d8ef628-02f3-4f3b-ba6b-d6bbf8e661d1</OfferID>
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
                <OfferItemID>a3db17db-e4d7-4d30-95ce-8f634d16bafc:af9c85a0-e93b-4f2c-91b2-eb7d7e7d1e48</OfferItemID>
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
                <OfferItemID>19fff8c1-ad9f-4a23-ad4a-fd434356350e:e7756a5a-7194-4c7e-a0ec-28da794e8562</OfferItemID>
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
        </PricedOffer>
    </ns2:Response>
    <ns2:PayloadAttributes>
        <CorrelationID>3ffe0001-fbe9-4080-bac9-3e9d042d0e22</CorrelationID>
        <Timestamp>2026-05-07T18:34:11.567+07:00</Timestamp>
        <TrxID>TRX-123456789</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_OfferPriceRS>
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
        <Details>Request validation failed: Missing required field 'Request.Offer'</Details>
    </Error>
</ErrorResponse>
```

</details>

## Code Examples

=== "Curl"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OfferPrice \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @offerprice-request.xml
    ```

## Notes

1. **Prerequisites**: You must first call `AirShopping` to get `OfferID` and `OfferItemID` values.
2. **Offer References**: Use the exact `OfferRefID` and `OfferItemRefID` from the Air Shopping response.
3. **Pricing Details**: The response includes base amounts, taxes, and total prices for each offer item.
4. **Use in OrderCreate**: Use the priced offer information from this response when creating an order.
