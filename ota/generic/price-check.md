---
layout: default
title: Price Check
---

# Price Check (AirPriceRQ)

The Air-Price Request message requests pricing information for specific flights on certain dates for a specific number and type of passengers. The purpose is to verify the price prior to making a reservation and get an additional fare breakdown that might not be included in LowFareSearchRS.

## Table of Contents

- [Base URLs](#base-urls)
- [Endpoints](#endpoints)
- [Basic Request Format](#basic-request-format)
  - [With JWT Authentication](#with-jwt-authentication)
  - [With API Key Authentication](#with-api-key-authentication)
- [HTTP Headers](#http-headers)
- [Request Parameters](#request-parameters)
- [JSON Request](#json-request)
- [JSON Response](#json-response)
- [Error Responses](#error-responses)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoints

- Method: `POST` — Path: `/ota/v2015b/OTA` — Local-Name: `OTA_AirPriceRQ`

## Basic Request Format

### With JWT Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Local-Name: OTA_AirPriceRQ' \
  -H 'Content-Type: application/json' \
  -d @AirPriceRQ.json
```

### With API Key Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA' \
  -H 'X-API-Key: {api_key}' \
  -H 'Local-Name: OTA_AirPriceRQ' \
  -H 'Content-Type: application/json' \
  -d @AirPriceRQ.json
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Local-Name    | OTA operation identifier            | OTA_AirPriceRQ           |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

## Request Parameters

All parameters are required for the AirPriceRQ request.

| Parameter | Description | Example |
|-----------|-------------|---------|
| base_url | Base URL | https://test-api.worldticket.net/ota/v2015b/OTA |
| access_token | Access Token | *** |
| local-name | Custom HTTP header | OTA_AirPriceRQ |

## JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": [
      {
        "flightSegments": [
          {
            "departureDateTime": "{departure_datetime}",
            "arrivalDateTime": "{arrival_datetime}",
            "flightNumber": "{flight_number}",
            "resBookDesigCode": "{booking_class}",
            "departureAirport": {
              "locationCode": "{origin_code}"
            },
            "arrivalAirport": {
              "locationCode": "{destination_code}"
            },
            "marketingAirline": {
              "code": "{airline_code}"
            }
          }
        ]
      }
    ]
  },
  "travelerInfoSummary": {
    "airTravelerAvail": {
      "passengerTypeQuantity": [
        {
          "code": "ADT",
          "quantity": "{adult_count}"
        },
        {
          "code": "CHD",
          "quantity": "{child_count}"
        },
        {
          "code": "INF",
          "quantity": "{infant_count}"
        }
      ]
    }
  }
}
```

</div>

</details>

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "requestorID": {
          "type": "5",
          "id": "AGENT123",
          "name": "AGENCY1"
        }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": [
      {
        "flightSegments": [
          {
            "departureDateTime": "2024-12-25T08:00:00",
            "arrivalDateTime": "2024-12-25T11:30:00",
            "flightNumber": "FL123",
            "resBookDesigCode": "Y",
            "departureAirport": {
              "locationCode": "JED"
            },
            "arrivalAirport": {
              "locationCode": "XMK"
            },
            "marketingAirline": {
              "code": "DX"
            }
          }
        ]
      }
    ]
  },
  "travelerInfoSummary": {
    "airTravelerAvail": {
      "passengerTypeQuantity": [
        {
          "code": "ADT",
          "quantity": 2
        },
        {
          "code": "CHD",
          "quantity": 1
        },
        {
          "code": "INF",
          "quantity": 0
        }
      ]
    }
  }
}
```

</div>

</details>

## JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "success": {},
  "pricedItinerary": {
    "sequenceNumber": "1",
    "airItinerary": {
      "originDestinationOptions": [
        {
          "flightSegments": [
            {
              "departureDateTime": "2024-12-25T08:00:00",
              "arrivalDateTime": "2024-12-25T11:30:00",
              "flightNumber": "FL123",
              "resBookDesigCode": "Y",
              "departureAirport": {
                "locationCode": "JED"
              },
              "arrivalAirport": {
                "locationCode": "XMK"
              },
              "marketingAirline": {
                "code": "DX"
              }
            }
          ]
        }
      ]
    },
    "airItineraryPricingInfo": {
      "itinTotalFare": {
        "baseFare": {
          "amount": "250.00",
          "currencyCode": "USD"
        },
        "taxes": [
          {
            "amount": "50.00",
            "currencyCode": "USD",
            "taxCode": "YQ"
          }
        ],
        "totalFare": {
          "amount": "300.00",
          "currencyCode": "USD"
        }
      },
      "ptc_FareBreakdowns": [
        {
          "passengerTypeQuantity": {
            "code": "ADT",
            "quantity": 2
          },
          "fareBasisCodes": [
            "Y"
          ],
          "passengerFare": {
            "baseFare": {
              "amount": "100.00",
              "currencyCode": "USD"
            },
            "taxes": [
              {
                "amount": "20.00",
                "currencyCode": "USD",
                "taxCode": "YQ"
              }
            ],
            "totalFare": {
              "amount": "120.00",
              "currencyCode": "USD"
            }
          }
        },
        {
          "passengerTypeQuantity": {
            "code": "CHD",
            "quantity": 1
          },
          "fareBasisCodes": [
            "Y"
          ],
          "passengerFare": {
            "baseFare": {
              "amount": "50.00",
              "currencyCode": "USD"
            },
            "taxes": [
              {
                "amount": "10.00",
                "currencyCode": "USD",
                "taxCode": "YQ"
              }
            ],
            "totalFare": {
              "amount": "60.00",
              "currencyCode": "USD"
            }
          }
        }
      ],
      "fareInfos": [
        {
          "fareReference": "Y_ECON",
          "fareRuleInfo": {
            "fareRuleRef": "Y_RULE_001",
            "ruleName": "Economy Fare Rules"
          }
        }
      ]
    }
  }
}
```

</div>

</details>

## Error Responses

Common error responses for price check requests:

### Price Not Available

```json
{
  "errors": [
    {
      "code": "PRICE_NOT_AVAILABLE",
      "message": "Pricing not available for requested flight",
      "details": "The flight may no longer be available or the fare has changed."
    }
  ]
}
```

### Invalid Flight Segment

```json
{
  "errors": [
    {
      "code": "INVALID_FLIGHT_SEGMENT",
      "message": "Invalid flight segment provided",
      "details": "Flight number: {flight_number}, Date: {date}"
    }
  ]
}
```

### Fare Expired

```json
{
  "errors": [
    {
      "code": "FARE_EXPIRED",
      "message": "The fare has expired",
      "details": "Please perform a new search to get current pricing."
    }
  ]
}
```