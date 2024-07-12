# Available Routes and Flights Calendar

## Routes

<details open>
  <summary><b>Lists all possible city pairs selling by the airline.</b></summary>

  <h4>Request</h4>
  <pre>
    GET /schedule/routes?sales_channel=OTA
    Base URL: https://test-api.worldticket.net/sms-gateway
    Header: x-api-key: {api_key}
  </pre>

  <h4>Response</h4>
  <pre>
    [
      {
        "origin": {
          "code": "DMX",
          "name": "Madinah",
          "cityName": "Madinah",
          "cityCode": "DMX",
          "country": "SA"
        },
        "destinations": [
          {
            "code": "JXD",
            "name": "Al-Sulimaniyah",
            "cityName": "Jeddah",
            "cityCode": "JXD",
            "country": "SA"
          },
          {
            "code": "KCX",
            "name": "KCX",
            "cityName": "King Abdullah Economic City",
            "cityCode": "KCX",
            "country": "SA"
          },
          {
            "code": "MKX",
            "name": "Makkah",
            "cityName": "Makkah",
            "cityCode": "MKX",
            "country": "SA"
          }
        ]
      },
      {
        "origin": {
          "code": "JXD",
          "name": "Al-Sulimaniyah",
          "cityName": "Jeddah",
          "cityCode": "JXD",
          "country": "SA"
        },
        "destinations": [
          {
            "code": "DMX",
            "name": "Madinah",
            "cityName": "Madinah",
            "cityCode": "DMX",
            "country": "SA"
          },
          {
            "code": "KCX",
            "name": "KCX",
            "cityName": "King Abdullah Economic City",
            "cityCode": "KCX",
            "country": "SA"
          },
          {
            "code": "MKX",
            "name": "Makkah",
            "cityName": "Makkah",
            "cityCode": "MKX",
            "country": "SA"
          }
        ]
      },
      {
        "origin": {
          "code": "KCX",
          "name": "KCX",
          "cityName": "King Abdullah Economic City",
          "cityCode": "KCX",
          "country": "SA"
        },
        "destinations": [
          {
            "code": "DMX",
            "name": "Madinah",
            "cityName": "Madinah",
            "cityCode": "DMX",
            "country": "SA"
          },
          {
            "code": "JXD",
            "name": "Al-Sulimaniyah",
            "cityName": "Jeddah",
            "cityCode": "JXD",
            "country": "SA"
          },
          {
            "code": "MKX",
            "name": "Makkah",
            "cityName": "Makkah",
            "cityCode": "MKX",
            "country": "SA"
          }
        ]
      },
      {
        "origin": {
          "code": "MKX",
          "name": "Makkah",
          "cityName": "Makkah",
          "cityCode": "MKX",
          "country": "SA"
        },
        "destinations": [
          {
            "code": "DMX",
            "name": "Madinah",
            "cityName": "Madinah",
            "cityCode": "DMX",
            "country": "SA"
          },
          {
            "code": "JXD",
            "name": "Al-Sulimaniyah",
            "cityName": "Jeddah",
            "cityCode": "JXD",
            "country": "SA"
          },
          {
            "code": "KCX",
            "name": "KCX",
            "cityName": "King Abdullah Economic City",
            "cityCode": "KCX",
            "country": "SA"
          }
        ]
      }
    ]
  </pre>
</details>

## Calendar Availability

<details open>
  <summary><b>Lists available dates per route. Usually used in the calendar picker.</b></summary>

  <h4>Request</h4>
  <pre>
    GET /schedule/calendar/availability?start_date=2023-12-03T00:00:00&end_date=2023-12-28T00:00:00&departure_airport=XMD&arrival_airport=JED&direct=true
    Base URL: https://test-api.worldticket.net/sms-gateway
    Header:
      x-api-key: {api_key}
  </pre>

  <h4>Response</h4>
  <pre>
    {
        "departureAirport": "XMK",
        "arrivalAirport": "XMD",
        "startDate": "2024-04-01",
        "endDate": "2024-04-15",
        "dates": [
            "2024-04-01",
            "2024-04-02",
            "2024-04-03",
            "2024-04-04",
            "2024-04-05",
            "2024-04-06",
            "2024-04-07",
            "2024-04-08",
            "2024-04-09",
            "2024-04-10",
            "2024-04-11",
            "2024-04-12",
            "2024-04-13",
            "2024-04-14",
            "2024-04-15"
        ]
    }
  </pre>
</details>
