---
layout: default
title: Order Create (OrderCreate)
---

# Order Create

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/OrderCreate`

The method allows you to create a new booking order based on selected offers.

**Language**

Shell | Node | Ruby | PHP | Python

---

## Description

The Order Create API creates a new booking order based on selected offers from an Offer Price response. Supports both pay-later (holding) bookings without PaymentFunctions and instant payment flows when payment details are provided. Returns an OrderViewRS response with order confirmation details.

## Workflow (NDC API guide)

**Step 3** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderCreate` · **`CreateOrder`** → **`AcceptSelectedQuotedOfferList`** using **`OfferRefID`** / **`OfferItemRefID`** / **`OwnerCode`** / **`PaxRefID`** from **OfferPriceRS**. Scenarios: **`#ordercreate-pay-later`**, **`#ordercreate-instant-pay`**.

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

The request body must be a valid `IATA_OrderCreateRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `PayloadAttributes` | Object | No | Payload metadata |
| `POS` | Object | No | Point of sale information |
| `POS.Country.CountryCode` | String | No | Country code (e.g., "FR") |
| `Request` | Object | **Yes** | Main request body |
| `Request.CreateOrder` | Object | **Yes** | Order creation details |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList` | Object | **Yes** | Selected offers to create order |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer` | Object | **Yes** | Selected priced offer |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer.OfferRefID` | String | **Yes** | Offer reference ID from Offer Price response |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer.OwnerCode` | String | **Yes** | Airline owner code |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer.SelectedOfferItem` | Object | **Yes** | Selected offer item (can be multiple) |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer.SelectedOfferItem.OfferItemRefID` | String | **Yes** | Offer item reference ID |
| `Request.CreateOrder.AcceptSelectedQuotedOfferList.SelectedPricedOffer.SelectedOfferItem.PaxRefID` | String | **Yes** | Passenger reference ID |
| `Request.PaymentFunctions` | Object | No | Payment information (required for instant payment) |
| `Request.PaymentFunctions.PaymentProcessingDetails.Amount` | Decimal | No | Payment amount with currency |
| `Request.PaymentFunctions.PaymentProcessingDetails.PaymentMethod.OfflinePayment.PaymentTypeCode` | String | No | Payment type code (e.g., "CA", "CASH") |
| `Request.DataLists` | Object | No | Additional data lists |
| `Request.DataLists.ContactInfoList` | Object | No | Contact information |
| `Request.DataLists.PaxList` | Object | No | Passenger details with identity documents |

### Example Request

#### Pay Later (Holding) Booking
{: #ordercreate-pay-later}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderCreateRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        <ns2:CorrelationID>MXI1926035557</ns2:CorrelationID>
        <ns2:Timestamp>2025-12-11T12:38:28.819Z</ns2:Timestamp>
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
                    <ns2:OfferRefID>444d338d-6a9c-481a-8cac-2ee69a6d2078</ns2:OfferRefID>
                    <ns2:OwnerCode>VS</ns2:OwnerCode>
                    <ns2:SelectedOfferItem>
                        <ns2:OfferItemRefID>4dc81ae7-3460-490b-a758-38ec7b68e778:9aa5f349-24b9-4589-b2ed-87055c508bcc</ns2:OfferItemRefID>
                        <ns2:PaxRefID>PAX1</ns2:PaxRefID>
                    </ns2:SelectedOfferItem>
                </ns2:SelectedPricedOffer>
            </ns2:AcceptSelectedQuotedOfferList>
        </ns2:CreateOrder>
        <!-- No PaymentFunctions => hold booking, pay later -->
    </Request>
</IATA_OrderCreateRQ>
```

Omit **`PaymentFunctions`** for pay-later: the order commonly returns **`DRAFT`** until paid. For **round-trip pay later**, add a second **`SelectedOfferItem`** for the inbound priced item.

#### Instant Payment Booking
{: #ordercreate-instant-pay}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderCreateRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        <ns2:CorrelationID>MXI1926035557</ns2:CorrelationID>
        <ns2:Timestamp>2025-12-11T12:38:28.819Z</ns2:Timestamp>
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
                    <ns2:OfferRefID>444d338d-6a9c-481a-8cac-2ee69a6d2078</ns2:OfferRefID>
                    <ns2:OwnerCode>VS</ns2:OwnerCode>
                    <ns2:SelectedOfferItem>
                        <ns2:OfferItemRefID>4dc81ae7-3460-490b-a758-38ec7b68e778:9aa5f349-24b9-4589-b2ed-87055c508bcc</ns2:OfferItemRefID>
                        <ns2:PaxRefID>PAX1</ns2:PaxRefID>
                    </ns2:SelectedOfferItem>
                </ns2:SelectedPricedOffer>
            </ns2:AcceptSelectedQuotedOfferList>
        </ns2:CreateOrder>
        <ns2:PaymentFunctions>
            <ns2:PaymentProcessingDetails>
                <ns2:Amount CurCode="EUR">450.00</ns2:Amount>
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

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with order confirmation details.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <ns2:Order>
            <ns2:OrderID>5f9312c6-87b5-4aef-ac04-8ada74e1562f</ns2:OrderID>
            <ns2:OwnerCode>VS</ns2:OwnerCode>
            <ns2:StatusCode>OPEN</ns2:StatusCode>
            <ns2:TotalPrice>
                <ns2:BaseAmount CurCode="USD">400.00</ns2:BaseAmount>
                <ns2:TotalAmount CurCode="USD">450.00</ns2:TotalAmount>
            </ns2:TotalPrice>
            <ns2:OrderItem>
                <ns2:OrderItemID>OI1</ns2:OrderItemID>
                <ns2:Service>
                    <ns2:PaxRefID>PAX1</ns2:PaxRefID>
                    <ns2:OrderServiceAssociation>
                        <ns2:PaxSegmentRef>
                            <ns2:PaxSegmentRefID>SEG1</ns2:PaxSegmentRefID>
                        </ns2:PaxSegmentRef>
                    </ns2:OrderServiceAssociation>
                </ns2:Service>
            </ns2:OrderItem>
        </ns2:Order>
        <ns2:DataLists>
            <ns2:PaxList>
                <ns2:Pax>
                    <ns2:PaxID>PAX1</ns2:PaxID>
                    <ns2:PTC>ADT</ns2:PTC>
                </ns2:Pax>
            </ns2:PaxList>
        </ns2:DataLists>
    </Response>
</IATA_OrderViewRS>
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
        <Details>Request validation failed: Missing required field 'Request.Order'</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderCreate \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @ordercreate-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('ordercreate-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/OrderCreate',
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

    url = "https://api.go7.io/v21.3.5/OrderCreate"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('ordercreate-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
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
