---
layout: default
title: Flight Availability
---

# Available Routes and Flights

This section covers APIs for retrieving available routes, calendar availability, and detailed flight information.

## Table of Contents

- [Endpoints](#endpoints)
- [Routes](#routes)
- [Calendar Availability](#calendar-availability)

[//]: # (- [Air Availability &#40;AirAvailRQ/RS&#41;]&#40;#air-availability-airavailrqrs&#41;)

[//]: # (- [SSR Availability and Pricing]&#40;#ssr-availability-and-pricing&#41;)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoints

- Method: `GET` — Path: `/sms-gateway/schedule/routes`
- Method: `GET` — Path: `/sms-gateway/calendar/availability`
- Method: `POST` — OTA: `/ota/v2015b/OTA_AirAvailRQ` (Air availability)

## Routes

Lists all possible city pairs selling by the airline.

### Basic Request Format

#### With JWT Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/routes?sales_channel=OTA' \
  -H 'Authorization: Bearer {access_token}'
```

#### With API Key Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/routes?sales_channel=OTA' \
  -H 'X-API-Key: {api_key}'
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

### Request Parameters

| Parameter | Location | Required | Description | Example |
|-----------|----------|----------|-------------|---------|
| sales_channel | Query | Yes | Sales channel identifier | OTA |

### Response

The response contains an array of available route objects with origin and destination airport codes.

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
[
  {
    "origin": "JFK",
    "destination": "LAX",
    "active": true
  },
  {
    "origin": "LAX",
    "destination": "JFK",
    "active": true
  }
]
```

</div>

</details>

## Calendar Availability

Lists available dates per route. Usually used in calendar picker implementations.

### Basic Request Format

#### With JWT Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/calendar/availability?start_date={start_date}&end_date={end_date}&departure_airport={departure_airport}&arrival_airport={arrival_airport}&direct={direct}' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'X-Realm: {tenant-name}'
```

#### With API Key Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/calendar/availability?start_date={start_date}&end_date={end_date}&departure_airport={departure_airport}&arrival_airport={arrival_airport}&direct={direct}' \
  -H 'X-API-Key: {api_key}' \
  -H 'X-Realm: {tenant-name}'
```

### HTTP Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| X-Realm | Airline realm identifier | {tenant-name} |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

### Request Parameters

| Parameter | Location | Required | Description | Format | Example |
|-----------|----------|----------|-------------|--------|---------|
| start_date | Query | Yes | Start date for availability check | ISO 8601 | 2023-12-03T00:00:00 |
| end_date | Query | Yes | End date for availability check | ISO 8601 | 2023-12-28T00:00:00 |
| departure_airport | Query | Yes | Departure airport IATA code | String | XMD |
| arrival_airport | Query | Yes | Arrival airport IATA code | String | JED |
| direct | Query | No | Filter for direct flights only | Boolean | true |

### Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "availability": [
    {
      "date": "2023-12-03",
      "available": true,
      "flights": [
        {
          "flight_number": "FL123",
          "departure_time": "08:00",
          "arrival_time": "11:30",
          "available_seats": 45
        }
      ]
    },
    {
      "date": "2023-12-04",
      "available": false,
      "flights": []
    }
  ]
}
```

</div>

</details>

## Air Availability (AirAvailRQ/RS)

A flight availability request is performed to receive airline-specific flight inventory for a requested city pair on a specific date.

### Basic Request Format

#### With JWT Authentication
```bash
curl -X POST \
  '{base_url}/ota/v2015b/OTA_AirAvailRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @AirAvailRQ.json
```

#### With API Key Authentication
```bash
curl -X POST \
  '{base_url}/ota/v2015b/OTA_AirAvailRQ' \
  -H 'X-API-Key: {api_key}' \
  -H 'Content-Type: application/json' \
  -d @AirAvailRQ.json
```

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
  "originDestinationInformation": [
    {
      "departureDateTime": "{departure_date}",
      "originLocation": {
        "locationCode": "{origin_code}"
      },
      "destinationLocation": {
        "locationCode": "{destination_code}"
      }
    }
  ],
  "travelPreferences": {
    "cabinPref": {
      "cabin": "{cabin_class}"
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
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
    ]
  }
}
```

</div>

</details>

### JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "requestorID": { "type": "5", "id": "AGENT123", "name": "AGENCY1" }
      }
    ]
  },
  "originDestinationInformation": [
    {
      "departureDateTime": "2024-12-25",
      "originLocation": { "locationCode": "JED" },
      "destinationLocation": { "locationCode": "XMK" }
    }
  ],
  "travelPreferences": { "cabinPref": { "cabin": "ECONOMY" } },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          { "code": "ADT", "quantity": 2 },
          { "code": "CHD", "quantity": 1 },
          { "code": "INF", "quantity": 0 }
        ]
      }
    ]
  }
}
```

</div>

</details>

```json
{
  "version": "2.001",
  "success": {},
  "originDestinationOptions": {
    "originDestinationOption": [
      {
        "flightSegment": [
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
            },
            "bookingClassAvails": [
              {
                "resBookDesigCode": "Y",
                "resBookDesigQuantity": "{available_seats}",
                "rph": "1"
              },
              {
                "resBookDesigCode": "C",
                "resBookDesigQuantity": "{available_seats}",
                "rph": "2"
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## SSR Availability and Pricing

The API returns both Special Service Request (SSR) availability and pricing information.

### HTTP Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| X-Realm | Airline realm identifier | {tenant-name} |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

### Request Parameters (All Required)

| Parameter | Description | Example |
|-----------|-------------|---------|
| flight_designator | Flight Designator | FL123 |
| departure_airport_code | Departure airport IATA code | JFK |
| arrival_airport_code | Arrival airport IATA code | LAX |
| departure_date | Departure date | 2023-12-22 |
| currency_code | ISO Currency Code | USD |

### Basic Request Format

```bash
curl -X GET \
  '/{service-name}/ssr-configurations?flight_designator={flight_designator}&departure_airport_code={departure_airport_code}&arrival_airport_code={arrival_airport_code}&departure_date={departure_date}&currency_code={currency_code}' \
  -H 'X-Realm: {tenant-name}' \
  -H 'X-API-Key: {api_key}'
```

### Response
[id_rsa](../../../../.ssh/id_rsa)
```json
{
  "ssrConfigurations": [
    {
      "ssrCode": "MEAL",
      "description": "Special Meal",
      "price": {
        "amount": 25.00,
        "currency": "USD"
      },
      "available": true,
      "maxQuantity": 2
    },
    {
      "ssrCode": "SEAT",
      "description": "Preferred Seating",
      "price": {
        "amount": 15.00,
        "currency": "USD"
      },
      "available": true,
      "maxQuantity": 1
    }
  ]
}
```
