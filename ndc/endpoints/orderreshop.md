---
layout: default
title: Order Reshop (OrderReshop)
---

# Order Reshop

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/OrderReshop`

The method allows you to reshop an existing order and get alternative offers for modifying or canceling segments.

**Language**

Shell | Node | Ruby | PHP | Python

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

| Header | Required | Description |
|--------|----------|-------------|
| `x-tenant` | Yes | Tenant identifier |
| `x-SalesChannel` | Yes | Sales channel identifier |
| `x-api-key` | Yes | API key for authentication |
| `Content-Type` | Yes | `application/xml` or `application/xml;charset=UTF-8` |

### Request Body

The request body must be a valid `IATA_OrderReshopRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `PayloadAttributes` | Object | No | Payload metadata |
| `Request` | Object | **Yes** | Main request body |
| `Request.OrderRefID` | String | **Yes** | Order reference ID from previous OrderCreate response |
| `Request.UpdateOrder` | Object | **Yes** | Order update information |
| `Request.UpdateOrder.ReshopOrder` | Object | No | Reshop order details (for rebooking) |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice` | Object | No | Reshop order choice |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder` | Object | No | Service order modifications |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems` | Object | No | Add new offer items |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest` | Object | No | Flight request for new segments |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest.FlightRequestOriginDestinationsCriteria` | Object | No | Origin-destination criteria |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria` | Object | No | Origin-destination pair |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.DestArrivalCriteria.IATA_LocationCode` | String | No | Destination airport code |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.OriginDepCriteria.Date` | Date | No | Departure date (YYYY-MM-DD) |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.AddOfferItems.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.OriginDepCriteria.IATA_LocationCode` | String | No | Origin airport code |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.DeleteOrderItem` | Object | No | Delete order item (can be multiple) |
| `Request.UpdateOrder.ReshopOrder.ReshopOrderChoice.ServiceOrder.DeleteOrderItem.OrderItemRefID` | String | No | Order item reference ID to delete |
| `Request.UpdateOrder.CancelOrderRef` | Object | No | Cancel order reference (for cancellation) |
| `Request.UpdateOrder.CancelOrderRef.OrderRefID` | String | No | Order reference ID to cancel |

### Example Request

#### Rebook with New Segments
{: #orderreshop-rebook}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderReshopRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" 
                    xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
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
        <ns2:CorrelationID>ada69462-0b0a-4f18-ab3a-ffa37b25f7af</ns2:CorrelationID>
        <ns2:Timestamp>2025-12-24T14:37:12.444+07:00</ns2:Timestamp>
        <ns2:TrxID>TRX-123456789</ns2:TrxID>
        <ns2:VersionNumber>21.3</ns2:VersionNumber>
    </PayloadAttributes>
    <Request>
        <ns2:OrderRefID>76e7fc09-d951-4053-a24f-7b8edc4285e0</ns2:OrderRefID>
        <ns2:UpdateOrder>
            <ns2:ReshopOrder>
                <ns2:ReshopOrderChoice>
                    <ns2:ServiceOrder>
                        <ns2:AddOfferItems>
                            <ns2:FlightRequest>
                                <ns2:FlightRequestOriginDestinationsCriteria>
                                    <ns2:OriginDestCriteria>
                                        <ns2:DestArrivalCriteria>
                                            <ns2:IATA_LocationCode>CUR</ns2:IATA_LocationCode>
                                        </ns2:DestArrivalCriteria>
                                        <ns2:OriginDepCriteria>
                                            <ns2:Date>2026-01-02</ns2:Date>
                                            <ns2:IATA_LocationCode>BOS</ns2:IATA_LocationCode>
                                        </ns2:OriginDepCriteria>
                                    </ns2:OriginDestCriteria>
                                </ns2:FlightRequestOriginDestinationsCriteria>
                            </ns2:FlightRequest>
                        </ns2:AddOfferItems>
                        <ns2:DeleteOrderItem>
                            <ns2:OrderItemRefID>b8d34ce4-8f46-4fa8-89fa-49aad0086d5f</ns2:OrderItemRefID>
                        </ns2:DeleteOrderItem>
                    </ns2:ServiceOrder>
                </ns2:ReshopOrderChoice>
            </ns2:ReshopOrder>
        </ns2:UpdateOrder>
    </Request>
</IATA_OrderReshopRQ>
```

Use **`OrderRefID`** from the active order; **`AddOfferItems`** + optional **`DeleteOrderItem`** replace segments. From **OrderReshopRS**, pass **`ReshopOffer.OfferID`** (and item IDs) into **OrderQuote** / **OrderChange**.

#### Cancel Order
{: #orderreshop-cancel-order}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderReshopRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage" 
                    xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
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
        <CorrelationID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">c46f2365-b1be-4df2-b472-17389ee9ac00</CorrelationID>
        <Timestamp xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">2026-01-09T10:52:53.450+07:00</Timestamp>
        <TrxID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">TRX-123456789</TrxID>
        <VersionNumber xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">21.3</VersionNumber>
    </PayloadAttributes>
    <Request>
        <OrderRefID xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">73677775-4643-4ac5-9e7e-d261dadf643c</OrderRefID>
        <UpdateOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <CancelOrderRef>
                <ns2:OrderRefID>73677775-4643-4ac5-9e7e-d261dadf643c</ns2:OrderRefID>
            </CancelOrderRef>
        </UpdateOrder>
    </Request>
</IATA_OrderReshopRQ>
```

## Response

### Success Response (200 OK)

Returns an `IATA_OrderReshopRS` XML document containing alternative offers.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <cns:Reshop>
            <cns:ReshopOffer>
                <cns:OfferID>new-offer-id-12345</cns:OfferID>
                <cns:OwnerCode>VS</cns:OwnerCode>
                <cns:OfferItem>
                    <cns:OfferItemID>new-offer-item-id</cns:OfferItemID>
                    <cns:Price>
                        <cns:TotalAmount CurCode="USD">600.00</cns:TotalAmount>
                    </cns:Price>
                    <cns:PaxRefID>PAX1</cns:PaxRefID>
                </cns:OfferItem>
            </cns:ReshopOffer>
        </cns:Reshop>
        <cns:Order>
            <cns:OrderID>76e7fc09-d951-4053-a24f-7b8edc4285e0</cns:OrderID>
            <cns:OwnerCode>VS</cns:OwnerCode>
            <cns:StatusCode>OPEN</cns:StatusCode>
            <cns:TotalPrice>
                <cns:BaseAmount CurCode="USD">550.00</cns:BaseAmount>
                <cns:TotalAmount CurCode="USD">600.00</cns:TotalAmount>
            </cns:TotalPrice>
        </cns:Order>
        <cns:DataLists>
            <cns:DatedMarketingSegmentList>
                <cns:DatedMarketingSegment>
                    <cns:DatedMarketingSegmentID>DMS1</cns:DatedMarketingSegmentID>
                    <cns:Departure>
                        <cns:AirportCode>BOS</cns:AirportCode>
                        <cns:Date>2026-01-02</cns:Date>
                        <cns:Time>14:30</cns:Time>
                    </cns:Departure>
                    <cns:Arrival>
                        <cns:AirportCode>CUR</cns:AirportCode>
                        <cns:Date>2026-01-02</cns:Date>
                        <cns:Time>18:45</cns:Time>
                    </cns:Arrival>
                </cns:DatedMarketingSegment>
            </cns:DatedMarketingSegmentList>
        </cns:DataLists>
    </Response>
</IATA_OrderReshopRS>
```

### Error Responses

#### 400 Bad Request

Invalid request format or missing required fields.

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

#### 404 Not Found

Order not found.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ErrorResponse>
    <Error>
        <Code>404</Code>
        <Message>Order not found</Message>
        <Details>Order with ID 76e7fc09-d951-4053-a24f-7b8edc4285e0 not found</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderReshop \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderreshop-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('orderreshop-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/OrderReshop',
      xmlRequest,
      {
        headers: {
          'x-tenant': 'tenant-a',
          'x-SalesChannel': 'NDC',
          'x-api-key': 'your-api-key-here',
          'Content-Type': 'application/xml'
        }
      }
    );

    console.log(response.data);
    ```

=== "Python"

    ```python
    import requests

    url = "https://api.go7.io/v21.3.5/OrderReshop"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('orderreshop-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
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
