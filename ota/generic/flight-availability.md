---
layout: default
title: Flight Availability
---

# Available Routes and Flights

This section covers APIs for retrieving available routes, calendar availability, and detailed flight information.

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net/sms5 |
| Test        | https://test-api.worldticket.net/sms5 |

## Routes

Lists all possible city pairs selling by the airline.

### Request

```bash
GET https://test-api.worldticket.net/sms5/schedule/routes?sales_channel=OTA
```

### Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token or API key | Bearer {access_token} or X-API-Key: {api_key} |

### Response

The response contains an array of available route objects with origin and destination airport codes.

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

## Calendar Availability

Lists available dates per route. Usually used in calendar picker implementations.

### Request

```bash
GET https://test-api.worldticket.net/sms5/schedule/calendar/availability?start_date={start_date}&end_date={end_date}&departure_airport_code={departure_code}&arrival_airport_code={arrival_code}
```

### Parameters

| Parameter | Required | Description | Format | Example |
|-----------|----------|-------------|--------|---------|
| start_date | Yes | Start date for availability check | ISO 8601 | 2023-12-03T00:00:00 |
| end_date | Yes | End date for availability check | ISO 8601 | 2023-12-28T00:00:00 |
| departure_airport_code | Yes | Departure airport IATA code | String | JFK |
| arrival_airport_code | Yes | Arrival airport IATA code | String | LAX |

### Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token or API key | Bearer {access_token} |
| X-REALM | Airline realm identifier | {tenant-name} |

### Response

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

## AirAvail RQ/RS

A flight availability request is performed to receive airline-specific flight inventory for a requested city pair on a specific date.

### Request Headers

| Header | Description | Example |
|--------|-------------|---------|
| X-REALM | Airline realm identifier | {tenant-name} |
| x-api-key | API access token | {api-key} |
| Content-Type | Request content type | application/xml or application/json |
| local-name | OTA method name | OTA_AirAvailRQ |

### XML Request Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirAvailRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{departure_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <CabinPref Cabin="{cabin_class}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
            <PassengerTypeQuantity Code="CHD" Quantity="{child_count}"/>
            <PassengerTypeQuantity Code="INF" Quantity="{infant_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
</OTA_AirAvailRQ>
```

### JSON Request Example

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

### XML Response Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirAvailRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Success/>
    <OriginDestinationOptions>
        <OriginDestinationOption>
            <FlightSegment DepartureDateTime="{departure_datetime}" 
                          ArrivalDateTime="{arrival_datetime}"
                          FlightNumber="{flight_number}"
                          ResBookDesigCode="{booking_class}">
                <DepartureAirport LocationCode="{origin_code}"/>
                <ArrivalAirport LocationCode="{destination_code}"/>
                <MarketingAirline Code="{airline_code}"/>
                <BookingClassAvails>
                    <BookingClassAvail ResBookDesigCode="Y" 
                                     ResBookDesigQuantity="{available_seats}"
                                     RPH="1"/>
                    <BookingClassAvail ResBookDesigCode="C" 
                                     ResBookDesigQuantity="{available_seats}"
                                     RPH="2"/>
                </BookingClassAvails>
            </FlightSegment>
        </OriginDestinationOption>
    </OriginDestinationOptions>
</OTA_AirAvailRS>
```

### JSON Response Example

```json
{
  "version": "2.001",
  "success": {},
  "originDestinationOptions": [
    {
      "originDestinationOption": [
        {
          "flightSegment": {
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
        }
      ]
    }
  ]
}
```

## SSR Availability and Pricing

The API returns both Special Service Request (SSR) availability and pricing information.

### Request Headers

| Header | Description | Example |
|--------|-------------|---------|
| X-REALM | Airline realm identifier | {tenant-name} |
| x-api-key | API access token | {api-key} |

### Request Parameters (All Required)

| Parameter | Description | Example |
|-----------|-------------|---------|
| flight_designator | Flight Designator | FL123 |
| departure_airport_code | Departure airport IATA code | JFK |
| arrival_airport_code | Arrival airport IATA code | LAX |
| departure_date | Departure date | 2023-12-22 |
| currency_code | ISO Currency Code | USD |

### Request

```bash
GET /{service-name}/ssr-configurations?flight_designator={flight_designator}&departure_airport_code={departure_airport_code}&arrival_airport_code={arrival_airport_code}&departure_date={departure_date}&currency_code={currency_code}
```

### Response

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

## Error Responses

Common error responses for flight availability requests:

### No Availability

```xml
<OTA_AirAvailRS>
    <Errors>
        <Error Code="NO_AVAILABILITY" ShortText="No flights available">
            No flights available for the requested route and date.
        </Error>
    </Errors>
</OTA_AirAvailRS>
```

### Invalid Route

```json
{
  "errors": [
    {
      "code": "INVALID_ROUTE",
      "message": "The requested route is not served by this airline",
      "details": "Origin: {origin_code}, Destination: {destination_code}"
    }
  ]
}
```