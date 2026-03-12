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
    "origin": {
      "code": "AAC",
      "name": "El Arish International Airport",
      "cityName": "El Arish",
      "cityCode": "AAC",
      "country": "EG"
    },
    "destinations": [
      {
        "code": "AAL",
        "name": "Aalborg Airport",
        "cityName": "Aalborg",
        "cityCode": "AAL",
        "country": "DK"
      },
      {
        "code": "AAH",
        "name": "Aachen-Merzbrück Airport",
        "cityName": "Aachen",
        "cityCode": "AAH",
        "country": "DE"
      }
    ]
  },
  {
    "origin": {
      "code": "AAE",
      "name": "Rabah Bitat Airport",
      "cityName": "Annaba",
      "cityCode": "AAE",
      "country": "DZ"
    },
    "destinations": [
      {
        "code": "ARN",
        "name": "Stockholm-Arlanda Airport",
        "cityName": "Stockholm",
        "cityCode": "STO",
        "country": "SE"
      }
    ]
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

| Parameter | Location | Required | Description | Format | Example             |
|-----------|----------|----------|-------------|--------|---------------------|
| start_date | Query | Yes | Start date for availability check | ISO 8601 | 2025-12-01T00:00:00 |
| end_date | Query | Yes | End date for availability check | ISO 8601 | 2025-12-30T00:00:00 |
| departure_airport | Query | Yes | Departure airport IATA code | String | KRP                 |
| arrival_airport | Query | Yes | Arrival airport IATA code | String | CPH                 |
| direct | Query | No | Filter for direct flights only | Boolean | false                |

### Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "startDate": "2025-12-01",
  "endDate": "2025-12-30",
  "departureAirport": "KRP",
  "arrivalAirport": "CPH",
  "dates": [
    "2025-12-30",
    "2025-12-29",
    "2025-12-28",
    "2025-12-27",
    "2025-12-26",
    "2025-12-25",
    "2025-12-24",
    "2025-12-23",
    "2025-12-22",
    "2025-12-21",
    "2025-12-20",
    "2025-12-19",
    "2025-12-18",
    "2025-12-17",
    "2025-12-16",
    "2025-12-15",
    "2025-12-14",
    "2025-12-13",
    "2025-12-12",
    "2025-12-11",
    "2025-12-10",
    "2025-12-09",
    "2025-12-08",
    "2025-12-07",
    "2025-12-06",
    "2025-12-05",
    "2025-12-04",
    "2025-12-03",
    "2025-12-02",
    "2025-12-01"
  ]
}
```

</div>

</details>