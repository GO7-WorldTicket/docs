---
layout: default
title: Order Change (OrderChange)
---

# Order Change

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/OrderChange`

The method allows you to modify an existing order or process payment for on-hold bookings.

**Language**

Shell | Node | Ruby | PHP | Python

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

| Header | Required | Description |
|--------|----------|-------------|
| `x-tenant` | Yes | Tenant identifier |
| `x-SalesChannel` | Yes | Sales channel identifier |
| `x-api-key` | Yes | API key for authentication |
| `Content-Type` | Yes | `application/xml` or `application/xml;charset=UTF-8` |

### Request Body

The request body must be a valid `IATA_OrderChangeRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `PayloadAttributes` | Object | No | Payload metadata |
| `POS` | Object | No | Point of sale information |
| `Request` | Object | **Yes** | Main request body |
| `Request.ChangeOrderChoice` | Object | No | Order modification choice (for rebooking) |
| `Request.ChangeOrderChoice.AcceptSelectedQuotedOfferList` | Object | No | Selected offers for rebooking |
| `Request.ChangeOrderChoice.AcceptSelectedQuotedOfferList.SelectedPricedOffer` | Object | No | Selected priced offer |
| `Request.ChangeOrderChoice.AcceptSelectedQuotedOfferList.SelectedPricedOffer.OfferRefID` | String | No | Offer reference ID |
| `Request.ChangeOrderChoice.AcceptSelectedQuotedOfferList.SelectedPricedOffer.OwnerCode` | String | No | Airline owner code |
| `Request.ChangeOrderChoice.AcceptSelectedQuotedOfferList.SelectedPricedOffer.SelectedOfferItem` | Object | No | Selected offer item |
| `Request.Order` | Object | **Yes** | Order to modify |
| `Request.Order.OrderID` | String | **Yes** | Order ID from previous OrderCreate response |
| `Request.Order.OwnerCode` | String | **Yes** | Airline owner code |
| `Request.PaymentFunctions` | Object | No | Payment information (required for payment processing) |
| `Request.PaymentFunctions.PaymentProcessingDetails.Amount` | Decimal | No | Payment amount with currency |
| `Request.PaymentFunctions.PaymentProcessingDetails.PaymentMethod.OfflinePayment.PaymentTypeCode` | String | No | Payment type code (e.g., "CA", "CASH") |

### Example Request

#### Process Payment for On-Hold Booking
{: #orderchange-payment-on-hold}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderChangeRQ xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"
        xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
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
        <ns2:CorrelationID>8d2ef131-c213-4239-8ed8-9be5f8240417</ns2:CorrelationID>
        <ns2:Timestamp>2025-12-29T10:30:00.000Z</ns2:Timestamp>
        <ns2:TrxID>TRX-PAYMENT-001</ns2:TrxID>
        <ns2:VersionNumber>21.3</ns2:VersionNumber>
    </PayloadAttributes>
    <POS>
        <ns2:Country>
            <ns2:CountryCode>FR</ns2:CountryCode>
        </ns2:Country>
    </POS>
    <Request>
        <ns2:Order>
            <ns2:OrderID>4f43a321-8324-4061-bbcf-eba6d541c3a8</ns2:OrderID>
            <ns2:OwnerCode>W2</ns2:OwnerCode>
        </ns2:Order>
        <ns2:PaymentFunctions>
            <ns2:PaymentProcessingDetails>
                <ns2:Amount CurCode="USD">450.00</ns2:Amount>
                <ns2:PaymentMethod>
                    <ns2:OfflinePayment>
                        <ns2:PaymentTypeCode>CA</ns2:PaymentTypeCode>
                    </ns2:OfflinePayment>
                </ns2:PaymentMethod>
            </ns2:PaymentProcessingDetails>
        </ns2:PaymentFunctions>
    </Request>
</IATA_OrderChangeRQ>
```

Same **`Order`** + **`PaymentFunctions`** envelope as above; only **`PaymentTypeCode`** differs (confirm codes with your airline / PADIS mapping).

#### Payment with debit (`OfflinePayment`)
{: #orderchange-payment-debit}

```xml
<ns2:OfflinePayment>
    <ns2:PaymentTypeCode>DC</ns2:PaymentTypeCode>
</ns2:OfflinePayment>
```

#### Payment with credit (`OfflinePayment`)
{: #orderchange-payment-credit}

```xml
<ns2:OfflinePayment>
    <ns2:PaymentTypeCode>CC</ns2:PaymentTypeCode>
</ns2:OfflinePayment>
```

#### Rebook with New Offers
{: #orderchange-rebook}

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<IATA_OrderChangeRQ xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes"
        xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
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
        <ns2:CorrelationID>8d2ef131-c213-4239-8ed8-9be5f8240417</ns2:CorrelationID>
        <ns2:Timestamp>2025-12-29T10:30:00.000Z</ns2:Timestamp>
        <ns2:TrxID>TRX-REBOOK-001</ns2:TrxID>
        <ns2:VersionNumber>21.3</ns2:VersionNumber>
    </PayloadAttributes>
    <POS>
        <ns2:Country>
            <ns2:CountryCode>FR</ns2:CountryCode>
        </ns2:Country>
    </POS>
    <Request>
        <ns2:ChangeOrderChoice>
            <ns2:AcceptSelectedQuotedOfferList>
                <ns2:SelectedPricedOffer>
                    <ns2:OfferRefID>646f2456-2572-41da-9c1c-0d77faafaf0c</ns2:OfferRefID>
                    <ns2:OwnerCode>W2</ns2:OwnerCode>
                    <ns2:SelectedOfferItem>
                        <ns2:OfferItemRefID>2e4c0ca1-4769-467e-a653-734b8d1a3670</ns2:OfferItemRefID>
                        <ns2:PaxRefID>ADT1</ns2:PaxRefID>
                    </ns2:SelectedOfferItem>
                </ns2:SelectedPricedOffer>
            </ns2:AcceptSelectedQuotedOfferList>
        </ns2:ChangeOrderChoice>
        <ns2:Order>
            <ns2:OrderID>4f43a321-8324-4061-bbcf-eba6d541c3a8</ns2:OrderID>
            <ns2:OwnerCode>W2</ns2:OwnerCode>
        </ns2:Order>
        <ns2:PaymentFunctions>
            <ns2:PaymentProcessingDetails>
                <ns2:Amount CurCode="USD">109.27</ns2:Amount>
                <ns2:PaymentMethod>
                    <ns2:OfflinePayment>
                        <ns2:PaymentTypeCode>CA</ns2:PaymentTypeCode>
                    </ns2:OfflinePayment>
                </ns2:PaymentMethod>
            </ns2:PaymentProcessingDetails>
        </ns2:PaymentFunctions>
    </Request>
</IATA_OrderChangeRQ>
```

## Response

### Success Response (200 OK)

Returns an `IATA_OrderViewRS` XML document with updated order details.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderViewRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:ns2="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <ns2:Order>
            <ns2:OrderID>4f43a321-8324-4061-bbcf-eba6d541c3a8</ns2:OrderID>
            <ns2:OwnerCode>W2</ns2:OwnerCode>
            <ns2:StatusCode>OPEN</ns2:StatusCode>
            <ns2:TotalPrice>
                <ns2:BaseAmount CurCode="USD">500.00</ns2:BaseAmount>
                <ns2:TotalAmount CurCode="USD">609.27</ns2:TotalAmount>
            </ns2:TotalPrice>
            <ns2:OrderItem>
                <ns2:OrderItemID>OI1</ns2:OrderItemID>
                <ns2:Service>
                    <ns2:PaxRefID>ADT1</ns2:PaxRefID>
                </ns2:Service>
            </ns2:OrderItem>
        </ns2:Order>
    </Response>
</IATA_OrderViewRS>
```

### Error Responses

#### 400 Bad Request

Invalid request, missing required fields, or order not in DRAFT status.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ErrorResponse>
    <Error>
        <Code>400</Code>
        <Message>Bad Request - Invalid request, missing required fields, or order not in DRAFT status</Message>
        <Details>Order is not in DRAFT status</Details>
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
        <Details>Order with ID 4f43a321-8324-4061-bbcf-eba6d541c3a8 not found</Details>
    </Error>
</ErrorResponse>
```

#### 422 Unprocessable Entity

Payment method not supported or payment validation failed.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ErrorResponse>
    <Error>
        <Code>422</Code>
        <Message>Unprocessable Entity - Payment method not supported or payment validation failed</Message>
        <Details>Payment type code CASH is not supported</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderChange \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderchange-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('orderchange-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/OrderChange',
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

    url = "https://api.go7.io/v21.3.5/OrderChange"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('orderchange-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
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
