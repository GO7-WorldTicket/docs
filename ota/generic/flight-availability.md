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
  -H 'Authorization: Bearer {{access_token}}'
```

#### With API Key Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/routes?sales_channel=OTA' \
  -H 'X-API-Key: {{api_key}}'
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {{access_token}}     |
| X-API-Key     | API key for key-based authentication| {{api_key}}                 |
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
  'https://test-api.worldticket.net/sms-gateway/schedule/calendar/availability?start_date={{start_date}}&end_date={{end_date}}&departure_airport={{departure_airport}}&arrival_airport={{arrival_airport}}&direct={{direct}}' \
  -H 'Authorization: Bearer {{access_token}}' \
  -H 'X-Realm: {{tenant-name}}'
```

#### With API Key Authentication
```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/schedule/calendar/availability?start_date={{start_date}}&end_date={{end_date}}&departure_airport={{departure_airport}}&arrival_airport={{arrival_airport}}&direct={{direct}}' \
  -H 'X-API-Key: {{api_key}}' \
  -H 'X-Realm: {{tenant-name}}'
```

### HTTP Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {{access_token}} |
| X-API-Key | API key for key-based authentication | {{api_key}} |
| X-Realm | Airline realm identifier | {{tenant-name}} |

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