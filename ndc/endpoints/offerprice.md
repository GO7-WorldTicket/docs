---
layout: default
title: Offer Price (OfferPrice)
---

# Offer Price

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/OfferPrice`

The method allows you to get detailed pricing information for selected flight offers.

**Language**

Shell | Node | Ruby | PHP | Python

---

## Description

The Offer Price API returns detailed pricing information for selected offers from an Air Shopping response. Use the `OfferID` and `OfferItemID` values from the Air Shopping response to request specific pricing details including base amounts, taxes, and total prices.

## Workflow (NDC API guide)

**Step 2** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/OfferPrice` · use **`OfferRefID`** (= **`OfferID`**), **`OfferItemRefID`** (= **`OfferItemID`**), **`OwnerCode`**, **`PaxRefID`** from **AirShoppingRS**. Priced offer feeds **[Order Create](ordercreate.md)**. Scenarios: **`#offerprice-one-way-trip`**, **`#offerprice-round-trip`**.

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

The request body must be a valid `IATA_OfferPriceRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `PayloadAttributes` | Object | No | Payload metadata |
| `Request` | Object | **Yes** | Main request body |
| `Request.PricedOffer` | Object | **Yes** | Priced offer information |
| `Request.PricedOffer.SelectedOfferList` | Object | **Yes** | List of selected offers |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer` | Object | **Yes** | Selected offer (can be multiple) |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer.OfferRefID` | String | **Yes** | Offer reference ID from Air Shopping response |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer.OwnerCode` | String | **Yes** | Airline owner code (e.g., "VS") |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer.SelectedOfferItem` | Object | **Yes** | Selected offer item (can be multiple) |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer.SelectedOfferItem.OfferItemRefID` | String | **Yes** | Offer item reference ID from Air Shopping response |
| `Request.PricedOffer.SelectedOfferList.SelectedOffer.SelectedOfferItem.PaxRefID` | String | **Yes** | Passenger reference ID (e.g., "PAX1", "ADT1") |

### OfferPrice — One-way trip
{: #offerprice-one-way-trip}

One **`SelectedOffer`** with typically **one `SelectedOfferItem`** per direction when the shopping offer contained a single outbound slice (adjust **`PaxRefID`** to match shopping).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OfferPriceRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                   xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <PayloadAttributes>
        <cns:VersionNumber>21.3</cns:VersionNumber>
    </PayloadAttributes>
    <Request>
        <cns:PricedOffer>
            <cns:SelectedOfferList>
                <cns:SelectedOffer>
                    <cns:OfferRefID>9b4f1c08-e4da-4a65-8011-9beb57109611</cns:OfferRefID>
                    <cns:OwnerCode>VS</cns:OwnerCode>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>77402942-760d-408f-a839-c96be57d42c5:940ab3f0-89c0-4779-8ddc-d16016f5929a</cns:OfferItemRefID>
                        <cns:PaxRefID>PAX1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                </cns:SelectedOffer>
            </cns:SelectedOfferList>
        </cns:PricedOffer>
    </Request>
</IATA_OfferPriceRQ>
```

### OfferPrice — Round trip
{: #offerprice-round-trip}

Same **`OfferRefID`** when both directions sit under one offer; **two `SelectedOfferItem`** rows (IDs from **AirShoppingRS**).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OfferPriceRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                   xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Request>
        <cns:PricedOffer>
            <cns:SelectedOfferList>
                <cns:SelectedOffer>
                    <cns:OfferRefID>rt-offer-uuid-001</cns:OfferRefID>
                    <cns:OwnerCode>VS</cns:OwnerCode>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>rt-item-outbound:seg-a</cns:OfferItemRefID>
                        <cns:PaxRefID>PAX1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                    <cns:SelectedOfferItem>
                        <cns:OfferItemRefID>rt-item-inbound:seg-b</cns:OfferItemRefID>
                        <cns:PaxRefID>PAX1</cns:PaxRefID>
                    </cns:SelectedOfferItem>
                </cns:SelectedOffer>
            </cns:SelectedOfferList>
        </cns:PricedOffer>
    </Request>
</IATA_OfferPriceRQ>
```

Round-trip **responses** match the one-way shape but include **two** `OfferItem` blocks (taxes/fees per carrier rules).

## Response

### Success Response (200 OK)

Returns an `IATA_OfferPriceRS` XML document containing detailed pricing information.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_OfferPriceRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                   xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <cns:PricedOffer>
            <cns:Offer>
                <cns:OfferID>9b4f1c08-e4da-4a65-8011-9beb57109611</cns:OfferID>
                <cns:OwnerCode>VS</cns:OwnerCode>
                <cns:OfferItem>
                    <cns:OfferItemID>77402942-760d-408f-a839-c96be57d42c5:940ab3f0-89c0-4779-8ddc-d16016f5929a</cns:OfferItemID>
                    <cns:Price>
                        <cns:BaseAmount CurCode="USD">400.00</cns:BaseAmount>
                        <cns:TotalAmount CurCode="USD">450.00</cns:TotalAmount>
                        <cns:FareDetail>
                            <cns:FareComponent>
                                <cns:PriceClassRefID>PC1</cns:PriceClassRefID>
                                <cns:Amount CurCode="USD">400.00</cns:Amount>
                            </cns:FareComponent>
                        </cns:FareDetail>
                    </cns:Price>
                    <cns:PaxRefID>ADT1</cns:PaxRefID>
                </cns:OfferItem>
            </cns:Offer>
        </cns:PricedOffer>
    </Response>
</IATA_OfferPriceRS>
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
        <Details>Request validation failed: Missing required field 'Request.Offer'</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/OfferPrice \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @offerprice-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('offerprice-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/OfferPrice',
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

    url = "https://api.go7.io/v21.3.5/OfferPrice"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('offerprice-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
    ```

## Notes

1. **Prerequisites**: You must first call `AirShopping` to get `OfferID` and `OfferItemID` values.
2. **Offer References**: Use the exact `OfferRefID` and `OfferItemRefID` from the Air Shopping response.
3. **Pricing Details**: The response includes base amounts, taxes, and total prices for each offer item.
4. **Use in OrderCreate**: Use the priced offer information from this response when creating an order.
