---
layout: default
title: Order Retrieve (OrderRetrieve)
---

# Order Retrieve

`POST` `https://api.go7.io/v21.3.5/OrderRetrieve`

---

## Description

The Order Retrieve API returns the current view of an existing order. Use the `OrderID` returned by `OrderCreate` for a direct lookup, or use `BookingID` when retrieving by booking reference / record locator. The response is an `IATA_OrderViewRS` XML document.

## Workflow (NDC API guide)

**Step 4** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderRetrieve` · send `IATA_OrderRetrieveRQ` with either **`OrderID`** or **`BookingID`**. The gateway returns **`IATA_OrderViewRS`**. Scenarios: **`#orderretrieve-by-order-id`**, **`#orderretrieve-by-booking-reference`**.

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

The request body must be a valid `IATA_OrderRetrieveRQ` XML document following IATA NDC v21.3.5 standard.

Provide either `OrderID` or `BookingID`. If both are present, the gateway uses `OrderID`.

### OrderRetrieve — By Order ID
{: #orderretrieve-by-order-id}

Use `OrderID` for direct retrieval when you have the order identifier from `OrderCreateRS` / `OrderViewRS`.

<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderRetrieveRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <DistributionChain>
        <ns2:DistributionChainLink>
            <ns2:Ordinal>1</ns2:Ordinal>
            <ns2:OrgRole>Seller</ns2:OrgRole>
            <ns2:ParticipatingOrg>
                <ns2:Name>Travel Agency XYZ</ns2:Name>
                <ns2:OrgID>SELLER123</ns2:OrgID>
            </ns2:ParticipatingOrg>
        </ns2:DistributionChainLink>
    </DistributionChain>
    <PayloadAttributes>
        <ns2:CorrelationID>c46f2365-b1be-4df2-b472-17389ee9ac00</ns2:CorrelationID>
        <ns2:Timestamp>2025-11-05T10:00:00Z</ns2:Timestamp>
        <ns2:TrxID>TRX-123456789</ns2:TrxID>
        <ns2:VersionNumber>21.3</ns2:VersionNumber>
    </PayloadAttributes>
    <Request>
        <ns2:OrderValidationFilterCriteria>
            <ns2:OrderFilterCriteria>
                <ns2:OrderID>8d5deca7-5e1f-4203-b5a9-aa79029fe33d</ns2:OrderID>
                <ns2:OwnerCode>VS</ns2:OwnerCode>
            </ns2:OrderFilterCriteria>
        </ns2:OrderValidationFilterCriteria>
    </Request>
</IATA_OrderRetrieveRQ>
```

</details>

### OrderRetrieve — By Booking Reference
{: #orderretrieve-by-booking-reference}

Use `BookingID` when retrieving by booking reference / record locator.

<details>
  <summary>Request Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderRetrieveRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <DistributionChain>
        <ns2:DistributionChainLink>
            <ns2:Ordinal>1</ns2:Ordinal>
            <ns2:OrgRole>Seller</ns2:OrgRole>
            <ns2:ParticipatingOrg>
                <ns2:Name>Travel Agency XYZ</ns2:Name>
                <ns2:OrgID>SELLER123</ns2:OrgID>
            </ns2:ParticipatingOrg>
        </ns2:DistributionChainLink>
    </DistributionChain>
    <PayloadAttributes>
        <ns2:CorrelationID>{{$randomUUID}}</ns2:CorrelationID>
        <ns2:Timestamp>2025-11-05T10:00:00Z</ns2:Timestamp>
        <ns2:TrxID>TRX-123456789</ns2:TrxID>
        <ns2:VersionNumber>21.3</ns2:VersionNumber>
    </PayloadAttributes>
    <Request>
        <ns2:OrderValidationFilterCriteria>
            <ns2:BookingRefFilterCriteria>
                <ns2:BookingID>CSHUNH</ns2:BookingID>
            </ns2:BookingRefFilterCriteria>
        </ns2:OrderValidationFilterCriteria>
    </Request>
</IATA_OrderRetrieveRQ>
```

</details>

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with the retrieved order details.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Response>
        <DataLists>
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
                <StatusCode>CANCELLED</StatusCode>
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
                <StatusCode>CANCELLED</StatusCode>
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
                <StatusCode>CANCELLED</StatusCode>
            </OrderItem>
            <StatusCode>OPEN</StatusCode>
            <TotalPrice>
                <BaseAmount CurCode="USD">115.17</BaseAmount>
                <TaxSummary>
                    <Tax>
                        <Amount CurCode="USD">-4.07</Amount>
                        <TaxCode>EU</TaxCode>
                    </Tax>
                    <Tax>
                        <Amount CurCode="USD">-0.64</Amount>
                        <TaxCode>QQ</TaxCode>
                    </Tax>
                    <Tax>
                        <Amount CurCode="USD">-2.31</Amount>
                        <TaxCode>DC</TaxCode>
                    </Tax>
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
                <OrgID>SELLER123</OrgID>
            </ParticipatingOrg>
        </DistributionChainLink>
    </ns2:DistributionChain>
    <ns2:PayloadAttributes>
        <CorrelationID>f5b3f69c-e78c-4353-9530-960f7f0496d4</CorrelationID>
        <Timestamp>2025-11-05T10:00:00Z</Timestamp>
        <TrxID>TRX-123456789</TrxID>
        <VersionNumber>21.3</VersionNumber>
    </ns2:PayloadAttributes>
</ns2:IATA_OrderViewRS>
```

</details>

### Error Responses

#### 400 Bad Request

Invalid XML, missing retrieve criteria, or an `OrderID` value that is not a valid UUID.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>914</Code>
        <DescText>no record locator found</DescText>
        <ErrorID>244cc6d4-da58-4f4f-9b47-fc55ef4e521c</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Validation</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderViewRS>
```

</details>

#### 404 Not Found

Order or booking reference not found.

<details>
  <summary>Response Payload</summary>

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes" xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" xmlns:ns3="http://www.w3.org/2000/09/xmldsig#">
    <ns2:Error>
        <Code>911</Code>
        <DescText>Order not found - Order by recordLocator [CSHUNB] with lastName [null] not found.</DescText>
        <ErrorID>9c2df809-13f9-4cd0-8803-9df888ac694f</ErrorID>
        <LangCode>EN</LangCode>
        <TypeCode>Business</TypeCode>
    </ns2:Error>
</ns2:IATA_OrderViewRS>
```

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

