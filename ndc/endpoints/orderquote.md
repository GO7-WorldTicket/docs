---
layout: default
title: Order Quote (OrderQuote)
---

# Order Quote

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/OrderQuote`

The method allows you to get a quote for modifying an existing order.

**Language**

Shell | Node | Ruby | PHP | Python

---

## Description

The Order Quote API returns pricing information for modifying an existing order. Provide the existing order ID and the new offers you want to use. The response includes reshop offers with updated pricing information.

## Workflow (NDC API guide)

**Step 6** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OrderQuote` · **`Payload.ExistingOrder`** + **`Payload.SelectedOffers`** with **`OfferRefID` / `OfferItemRefID`** from **AirShopping**, **OfferPrice**, or **OrderReshopRS**. Scenarios: **`#orderquote-rebook`**, **`#orderquote-cancel`**, **`#orderquote-booking`**.

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

The request body must be a valid `IATA_OrderQuoteRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `Payload` | Object | **Yes** | Payload containing order and offer information |
| `Payload.ExistingOrder` | Object | **Yes** | Existing order to modify |
| `Payload.ExistingOrder.OrderID` | String | **Yes** | Order ID from previous OrderCreate response |
| `Payload.ExistingOrder.OwnerCode` | String | **Yes** | Airline owner code |
| `Payload.SelectedOffers` | Object | **Yes** | New offers to use for the order |
| `Payload.SelectedOffers.OfferRefID` | String | **Yes** | Offer reference ID from Air Shopping response |
| `Payload.SelectedOffers.OwnerCode` | String | **Yes** | Airline owner code |
| `Payload.SelectedOffers.SelectedOfferItem` | Object | **Yes** | Selected offer item (can be multiple) |
| `Payload.SelectedOffers.SelectedOfferItem.OfferItemRefID` | String | **Yes** | Offer item reference ID |
| `Payload.SelectedOffers.SelectedOfferItem.PaxRefID` | String | **Yes** | Passenger reference ID |
| `PayloadAttributes` | Object | No | Payload metadata |

### OrderQuote — Rebook quote
{: #orderquote-rebook}

**`Payload.ExistingOrder`** + **`Payload.SelectedOffers`** with **`OfferRefID` / `OfferItemRefID`** from **OrderReshopRS** (rebook path).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderQuoteRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage">
    <Payload>
        <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OrderID>54dda4d6-0bf7-4ad0-9860-630c0c89369b</OrderID>
            <OwnerCode>VS</OwnerCode>
        </ExistingOrder>
        <SelectedOffers xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
            <OfferRefID>reshop-offer-rebook-001</OfferRefID>
            <OwnerCode>VS</OwnerCode>
            <SelectedOfferItem>
                <OfferItemRefID>reshop-item-001</OfferItemRefID>
                <PaxRefID>PAX1</PaxRefID>
            </SelectedOfferItem>
        </SelectedOffers>
    </Payload>
</IATA_OrderQuoteRQ>
```

**Response** (`OrderReshopRS`-style quote):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <cns:Reshop><cns:ReshopOffer><cns:OfferID>reshop-offer-rebook-001</cns:OfferID></cns:ReshopOffer></cns:Reshop>
        <cns:Order><cns:OrderID>54dda4d6-0bf7-4ad0-9860-630c0c89369b</cns:OrderID></cns:Order>
    </Response>
</IATA_OrderReshopRS>
```

### OrderQuote — Cancel quote
{: #orderquote-cancel}

Phase 1 often **skips** **`OrderQuote`** when refunds are unsupported. If your airline enables cancel quoting, shape matches the rebook quote but **`SelectedOffers`** carry IDs returned from **cancel reshop** (when present):

```xml
<Payload>
    <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
        <OrderID>73677775-4643-4ac5-9e7e-d261dadf643c</OrderID>
        <OwnerCode>VS</OwnerCode>
    </ExistingOrder>
    <SelectedOffers xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
        <OfferRefID>cancel-quote-offer-id</OfferRefID>
        <OwnerCode>VS</OwnerCode>
        <SelectedOfferItem>
            <OfferItemRefID>cancel-quote-item-id</OfferItemRefID>
            <PaxRefID>PAX1</PaxRefID>
        </SelectedOfferItem>
    </SelectedOffers>
</Payload>
```

### OrderQuote — Booking (confirm on-hold)
{: #orderquote-booking}

Use **`ExistingOrder`** = held booking UUID and **`SelectedOffers`** from a **fresh shop/price** or quoted offer set after retrieve:

```xml
<Payload>
    <ExistingOrder xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
        <OrderID>5f9312c6-87b5-4aef-ac04-8ada74e1562f</OrderID>
        <OwnerCode>VS</OwnerCode>
    </ExistingOrder>
    <SelectedOffers xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
        <OfferRefID>quoted-offer-after-hold</OfferRefID>
        <OwnerCode>VS</OwnerCode>
        <SelectedOfferItem>
            <OfferItemRefID>quoted-item-001</OfferItemRefID>
            <PaxRefID>PAX1</PaxRefID>
        </SelectedOfferItem>
    </SelectedOffers>
</Payload>
```

## Response

### Success Response (200 OK)

Returns an `IATA_OrderReshopRS` XML document with order quote information.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OrderReshopRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
        xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <cns:Reshop>
            <cns:ReshopOffer>
                <cns:OfferID>7cf62c43-d9ec-46f6-a026-0e7087e0ba7c</cns:OfferID>
                <cns:OwnerCode>VS</cns:OwnerCode>
                <cns:OfferItem>
                    <cns:OfferItemID>c6efb2ea-786e-4029-a7a9-3f52bf1d557f</cns:OfferItemID>
                    <cns:Price>
                        <cns:TotalAmount CurCode="USD">550.00</cns:TotalAmount>
                    </cns:Price>
                    <cns:PaxRefID>PAX1</cns:PaxRefID>
                </cns:OfferItem>
            </cns:ReshopOffer>
        </cns:Reshop>
        <cns:Order>
            <cns:OrderID>54dda4d6-0bf7-4ad0-9860-630c0c89369b</cns:OrderID>
            <cns:OwnerCode>VS</cns:OwnerCode>
            <cns:StatusCode>OPEN</cns:StatusCode>
        </cns:Order>
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
        <Details>Request validation failed: Missing required field 'Payload.ExistingOrder'</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OrderQuote \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @orderquote-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('orderquote-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/OrderQuote',
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

    url = "https://api.go7.io/v21.3.5/OrderQuote"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('orderquote-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
    ```

## Notes

1. **Prerequisites**: You must have an existing order (from `OrderCreate`) and new offers (from `AirShopping`).
2. **Order Status**: The existing order must be in `OPEN` status to get a quote.
3. **Use Case**: Use this API to get pricing before actually modifying an order with `OrderChange`.
4. **Response Format**: The response is an `OrderReshopRS` format, similar to reshop operations.
5. **Next Steps**: After getting the quote, use `OrderChange` with the same offer references to apply the changes.
