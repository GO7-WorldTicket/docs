---
layout: default
title: Read Booking
---

# Read Booking (ReadRQ)

The purpose is to read the existing booking in the airline system to display the booking information. This allows you to retrieve complete booking details including passenger information, flight segments, pricing, and booking status.

## Table of Contents

- [Read Booking (ReadRQ)](#read-booking-readrq)
  - [Table of Contents](#table-of-contents)
  - [Base URLs](#base-urls)
  - [Endpoint](#endpoint)
  - [Basic Request Format](#basic-request-format)
    - [With JWT Authentication](#with-jwt-authentication)
    - [With API Key Authentication](#with-api-key-authentication)
  - [HTTP Headers](#http-headers)
  - [JSON Request](#json-request)
  - [JSON Response](#json-response)
  - [Booking Status Codes](#booking-status-codes)
  - [Error Responses](#error-responses)
    - [Booking Not Found](#booking-not-found)
    - [Invalid Record Locator](#invalid-record-locator)
    - [Booking Access Denied](#booking-access-denied)
    - [Booking Expired](#booking-expired)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoint

- Method: `POST`
- Path: `/ota/v2015b/OTA_ReadRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_ReadRQ` (choose base URL per environment above)

## Basic Request Format

### With JWT Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_ReadRQ \
    -H 'Authorization: Bearer {access_token}' \
    -H 'Content-Type: application/json' \
    -d @ReadRQ.json
```

### With API Key Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_ReadRQ \
    -H 'X-API-Key: {api_key}' \
    -H 'Content-Type: application/json' \
    -d @ReadRQ.json
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| X-Realm | Airline realm identifier | {tenant-name} |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

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
  "readRequests": [
    {
      "bookingReferenceID": [
        {
          "type": "14",
          "id": "{record_locator}",
          "companyName": {
            "code": "{airline_code}"
          }
        }
      ]
    }
  ]
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
  "readRequests": [
    {
      "bookingReferenceID": [
        {
          "type": "14",
          "id": "ABC123",
          "companyName": {
            "code": "DX"
          }
        }
      ]
    }
  ]
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
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
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
                },
                "bookingStatus": "HK"
              }
            ]
          }
        ]
      }
    },
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "givenName": "John",
            "surname": "Doe"
          },
          "passengerTypeQuantity": {
            "code": "ADT",
            "quantity": 1
          },
          "travelerRefNumber": {
            "rph": "1"
          }
        }
      ]
    },
    "bookingReferenceID": [
      {
        "type": "14",
        "id": "ABC123",
        "companyName": {
          "code": "DX"
        }
      }
    ],
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
      }
    },
    "ticketingInfo": [
      {
        "ticketTimeLimit": "2024-12-20T23:59:00",
        "ticketType": "eTicket"
      }
    ]
  }
}
```

</div>

</details>

## Booking Status Codes

Common booking status codes returned in the response:

| Status Code | Description |
|-------------|-------------|
| HK | Holding Confirmed |
| UC | Unable to Confirm |
| UN | Unable, Need More Time |
| HX | Holding Cancelled |
| XX | Cancelled |
| NO | No Action Taken |

## Error Responses

Common error responses for read booking requests:

### Booking Not Found

```json
{
  "errors": [
    {
      "code": "BOOKING_NOT_FOUND",
      "message": "Booking not found",
      "details": "No booking found with record locator: {record_locator}"
    }
  ]
}
```

### Invalid Record Locator

```json
{
  "errors": [
    {
      "code": "INVALID_RECORD_LOCATOR",
      "message": "Invalid record locator format",
      "details": "Record locator must be 6 alphanumeric characters"
    }
  ]
}
```

### Booking Access Denied

```json
{
  "errors": [
    {
      "code": "ACCESS_DENIED",
      "message": "Access to booking denied",
      "details": "You do not have permission to access this booking"
    }
  ]
}
```

### Booking Expired

```json
{
  "errors": [
    {
      "code": "BOOKING_EXPIRED",
      "message": "Booking has expired",
      "details": "The booking has passed its ticketing time limit and is no longer available"
    }
  ]
}
```