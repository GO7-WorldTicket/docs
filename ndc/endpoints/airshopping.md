---
layout: default
title: Air Shopping (AirShopping)
---

# Air Shopping

**Ask AI**

`POST` `https://api.go7.io/v21.3.5/AirShopping`

The method allows you to search for available flight offers based on origin, destination, dates, and passenger information.

**Language**

Shell | Node | Ruby | PHP | Python

---

## Description

The Air Shopping API searches for available flight offers matching your criteria. Provide origin/destination airports, travel dates, passenger types, and optional cabin preferences. The response includes available offers with pricing and flight segment details.

## Workflow (NDC API guide)

**Step 1** in the Phased 1 chain ([NDC API — Offers & Orders workflow](../NDC_API.md#ndc-for-offers--orders-workflow)). `POST …/AirShopping` · messages **`IATA_AirShoppingRQ`** / **`IATA_AirShoppingRS`**. Capture **`OfferID`**, **`OfferItemID`**, **`OwnerCode`**, and **`PaxRefID`** for **[Offer Price](offerprice.md)**. Scenario anchors: **`#airshopping-one-way-trip`**, **`#airshopping-round-trip`**.

See [Authentication](../NDC_API.md#authentication) for **`x-tenant`**, **`x-SalesChannel`**, and **`x-api-key`**.

## Request

### Headers

| Header | Required | Description |
|--------|----------|-------------|
| `x-tenant` | Yes | Tenant identifier |
| `x-SalesChannel` | Yes | Sales channel identifier |
| `x-api-key` | Yes | API key for authentication |
| `Content-Type` | Yes | `application/xml` or `application/xml;charset=UTF-8` |

#### Header Details

| Header | Purpose | Format | Required | Example |
|--------|---------|--------|----------|---------|
| `x-tenant` | Identifies the tenant/organization context for the request | String (e.g., `tenant-a`, `test-qa-rc`) | Yes | `x-tenant: test-qa-rc` |
| `x-SalesChannel` | Specifies the sales channel (maps to account IDs per tenant configuration) | String (e.g., `NDC`, `IBE`) | Yes | `x-SalesChannel: NDC` |
| `x-api-key` | API key for authenticating the request | String | Yes | `x-api-key: abc123def456ghi789` |
| `Content-Type` | Request body media type | `application/xml` or `application/xml;charset=UTF-8` | Yes | `Content-Type: application/xml` |

**Note:** The `x-SalesChannel` value is used to determine the account ID based on tenant configuration.

### Request Body

The request body must be a valid `IATA_AirShoppingRQ` XML document following IATA NDC v21.3.5 standard.

#### Request Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `DistributionChain` | Object | No | Distribution chain information |
| `PayloadAttributes` | Object | No | Payload metadata |
| `PayloadAttributes.CorrelationID` | String | No | Unique correlation identifier |
| `PayloadAttributes.Timestamp` | DateTime | No | Request timestamp (ISO 8601) |
| `PayloadAttributes.TrxID` | String | No | Transaction identifier |
| `PayloadAttributes.VersionNumber` | String | No | NDC version (e.g., "21.3") |
| `Request` | Object | **Yes** | Main request body |
| `Request.FlightRequest` | Object | **Yes** | Flight search criteria |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria` | Object | **Yes** | Origin-destination criteria |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria` | Object | **Yes** | Origin-destination pair (can be multiple) |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.CabinType.CabinTypeCode` | String | No | `Y` (Economy), `C` (Business), `F` (First) |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.DestArrivalCriteria.Date` | Date | **Yes** | Arrival date (YYYY-MM-DD) |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.DestArrivalCriteria.IATA_LocationCode` | String | **Yes** | Destination airport code (3 letters) |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.OriginDepCriteria.Date` | Date | **Yes** | Departure date (YYYY-MM-DD) |
| `Request.FlightRequest.FlightRequestOriginDestinationsCriteria.OriginDestCriteria.OriginDepCriteria.IATA_LocationCode` | String | **Yes** | Origin airport code (3 letters) |
| `Request.PaxList` | Object | **Yes** | Passenger list |
| `Request.PaxList.Pax` | Object | **Yes** | Passenger information (can be multiple) |
| `Request.PaxList.Pax.PaxID` | String | **Yes** | Unique passenger identifier (e.g., "PAX1") |
| `Request.PaxList.Pax.PTC` | String | **Yes** | Passenger type: `ADT` (Adult), `CHD` (Child), `INF` (Infant) |

### AirShopping — One-way trip
{: #airshopping-one-way-trip}

Single **`OriginDestCriteria`** (outbound only).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_AirShoppingRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
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
        <cns:FlightRequest>
            <cns:FlightRequestOriginDestinationsCriteria>
                <cns:OriginDestCriteria>
                    <cns:CabinType>
                        <cns:CabinTypeCode>Y</cns:CabinTypeCode>
                        <cns:PrefLevel>
                            <cns:PrefLevelCode>Required</cns:PrefLevelCode>
                        </cns:PrefLevel>
                    </cns:CabinType>
                    <cns:DestArrivalCriteria>
                        <cns:Date>2025-11-30</cns:Date>
                        <cns:IATA_LocationCode>AAC</cns:IATA_LocationCode>
                    </cns:DestArrivalCriteria>
                    <cns:OriginDepCriteria>
                        <cns:Date>2025-11-29</cns:Date>
                        <cns:IATA_LocationCode>AAL</cns:IATA_LocationCode>
                    </cns:OriginDepCriteria>
                </cns:OriginDestCriteria>
            </cns:FlightRequestOriginDestinationsCriteria>
        </cns:FlightRequest>

        <cns:PaxList>
            <cns:Pax>
                <cns:PaxID>PAX1</cns:PaxID>
                <cns:PTC>ADT</cns:PTC>
            </cns:Pax>
            <cns:Pax>
                <cns:PaxID>PAX2</cns:PaxID>
                <cns:PTC>CHD</cns:PTC>
            </cns:Pax>
            <cns:Pax>
                <cns:PaxID>PAX3</cns:PaxID>
                <cns:PTC>INF</cns:PTC>
            </cns:Pax>
        </cns:PaxList>
    </Request>
</IATA_AirShoppingRQ>
```

### AirShopping — Round trip
{: #airshopping-round-trip}

Two **`OriginDestCriteria`** blocks (outbound + inbound).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_AirShoppingRQ xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                    xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <PayloadAttributes>
        <cns:CorrelationID>SHOP-RT-001</cns:CorrelationID>
        <cns:VersionNumber>21.3</cns:VersionNumber>
    </PayloadAttributes>
    <Request>
        <cns:FlightRequest>
            <cns:FlightRequestOriginDestinationsCriteria>
                <cns:OriginDestCriteria>
                    <cns:OriginDepCriteria>
                        <cns:Date>2026-06-10</cns:Date>
                        <cns:IATA_LocationCode>BKK</cns:IATA_LocationCode>
                    </cns:OriginDepCriteria>
                    <cns:DestArrivalCriteria>
                        <cns:Date>2026-06-10</cns:Date>
                        <cns:IATA_LocationCode>SIN</cns:IATA_LocationCode>
                    </cns:DestArrivalCriteria>
                </cns:OriginDestCriteria>
                <cns:OriginDestCriteria>
                    <cns:OriginDepCriteria>
                        <cns:Date>2026-06-17</cns:Date>
                        <cns:IATA_LocationCode>SIN</cns:IATA_LocationCode>
                    </cns:OriginDepCriteria>
                    <cns:DestArrivalCriteria>
                        <cns:Date>2026-06-17</cns:Date>
                        <cns:IATA_LocationCode>BKK</cns:IATA_LocationCode>
                    </cns:DestArrivalCriteria>
                </cns:OriginDestCriteria>
            </cns:FlightRequestOriginDestinationsCriteria>
        </cns:FlightRequest>
        <cns:PaxList>
            <cns:Pax><cns:PaxID>PAX1</cns:PaxID><cns:PTC>ADT</cns:PTC></cns:Pax>
        </cns:PaxList>
    </Request>
</IATA_AirShoppingRQ>
```

## Response

### Success Response (200 OK)

Returns an `IATA_AirShoppingRS` XML document containing available flight offers.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<IATA_AirShoppingRS xmlns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersMessage"
                    xmlns:cns="http://www.iata.org/IATA/2015/EASD/00/IATA_OffersAndOrdersCommonTypes">
    <Response>
        <cns:OfferGroup>
            <cns:Offer>
                <cns:OfferID>9b4f1c08-e4da-4a65-8011-9beb57109611</cns:OfferID>
                <cns:OwnerCode>VS</cns:OwnerCode>
                <cns:OfferItem>
                    <cns:OfferItemID>77402942-760d-408f-a839-c96be57d42c5:940ab3f0-89c0-4779-8ddc-d16016f5929a</cns:OfferItemID>
                    <cns:Service>
                        <cns:ServiceDefinitionRef>SEG1</cns:ServiceDefinitionRef>
                    </cns:Service>
                    <cns:PaxRefID>PAX1</cns:PaxRefID>
                    <cns:Price>
                        <cns:TotalAmount CurCode="USD">450.00</cns:TotalAmount>
                    </cns:Price>
                </cns:OfferItem>
            </cns:Offer>
        </cns:OfferGroup>
        <cns:DataLists>
            <cns:DatedMarketingSegmentList>
                <cns:DatedMarketingSegment>
                    <cns:DatedMarketingSegmentID>DMS1</cns:DatedMarketingSegmentID>
                    <cns:Departure>
                        <cns:AirportCode>AAL</cns:AirportCode>
                        <cns:Date>2025-11-29</cns:Date>
                        <cns:Time>10:30</cns:Time>
                    </cns:Departure>
                    <cns:Arrival>
                        <cns:AirportCode>AAC</cns:AirportCode>
                        <cns:Date>2025-11-30</cns:Date>
                        <cns:Time>12:45</cns:Time>
                    </cns:Arrival>
                </cns:DatedMarketingSegment>
            </cns:DatedMarketingSegmentList>
        </cns:DataLists>
    </Response>
</IATA_AirShoppingRS>
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
        <Details>Request validation failed: Missing required field 'Request.FlightRequest'</Details>
    </Error>
</ErrorResponse>
```

## Code Examples

=== "Shell"

    ```bash
    curl -X POST https://api.go7.io/v21.3.5/AirShopping \
      -H "x-tenant: tenant-a" \
      -H "x-SalesChannel: NDC" \
      -H "x-api-key: your-api-key-here" \
      -H "Content-Type: application/xml" \
      -d @airshopping-request.xml
    ```

=== "Node"

    ```javascript
    const axios = require('axios');
    const fs = require('fs');

    const xmlRequest = fs.readFileSync('airshopping-request.xml', 'utf8');

    const response = await axios.post(
      'https://api.go7.io/v21.3.5/AirShopping',
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

    url = "https://api.go7.io/v21.3.5/AirShopping"
    
    headers = {
        "x-tenant": "tenant-a",
        "x-SalesChannel": "NDC",
        "x-api-key": "your-api-key-here",
        "Content-Type": "application/xml"
    }

    with open('airshopping-request.xml', 'r') as f:
        xml_request = f.read()

    response = requests.post(url, headers=headers, data=xml_request)
    print(response.text)
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
