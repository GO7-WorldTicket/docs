
## Changelog
### 2025-07-11

#### Segments cancellation with automatic refund
- Add a new feature of cancellation based on flight segments with automatic refund. ([See more details](endpoints/segments_cancellation))

#### Update error message for sold-out segment
- Updated error message when booking sold-out segment ([See more details](endpoints/error-response))

### 2025-07-02

#### Add policy for OTA_AirBookRS, OTA_AirPriceRS

- Add policy information in /airReservation/priceInfo/fareInfos/fareInfo/ruleInfo/tpaextensions.
  ```json
            "fareInfos": {
                "fareInfo": [
                    {
                        "fareReference": [
                            {
                                "value": "EELMOWMC"
                            }
                        ],
                        "ruleInfo": {
                            "tpaextensions": {
                                "cancellationTimeLimit": "2026-07-01T10:11:07Z",
                                "confirmationTimeLimit": "2025-07-01T10:40:55Z",
                                "updateTravellersTimeLimit": "2025-07-26T07:50:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "JED"
                        },
                        "arrivalAirport": {
                            "locationCode": "DMX"
                        },
                        "date": [],
                        "fareInfo": [],
                        "city": [],
                        "airport": [],
                        "rph": "1"
                    }
                ]
            }
  ```
  
### 2025-06-26

#### Clarify request and response for AirLowFareSearch (one-way with booking class)

 - Updated sample request and response to reflect actual structure and booking class usage ([See more details](endpoints/low_fare_search.md#airlowfaresearchrq-for-oneway-trip-with-booking-class-preference))

### 2025-06-21

#### Deprecate download endpoint using passenger details and introduce the new one

- Introduced new endpoint to download specific ticket using `ticketNumber` and `couponNumber`
- Marked the existing endpoint using `firstName`, `lastName`, `departure`, and `arrival` as deprecated

**Example**

**Deprecated Request Format:**
```bash
curl '{base_url}/tickets/confirmation/{bookingReference}/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX' \
    -H 'x-api-key: {api-key}' \
    --output ticket.pdf
```

**New Request Format:**
```bash
curl '{base_url}/tickets/confirmation/{bookingReference}/download/passenger-segment?ticketNumber=3333330292535&couponNumber=1' \
    -H 'x-api-key: {api-key}' \
    --output ticket.pdf
```

### 2025-04-23

#### Updated error response behavior documentation

The following changes in how errors are returned have been documented and moved from the main error-response guide:

- **No train availability**: External HHR used to return `204 No Content`. 
  - **Before**: API returned `404 Not Found`.
  - **After**: API returns `200 OK` with empty `pricedItinerary`.

  ```json
  {
    "success": {},
    "pricedItineraries": {
      "pricedItinerary": []
    }
  }
  ```

- **No price exists for the tariff**: For mismatched `flightNumber`, `fareBasis`, or other criteria.
  - **Before**: API returned `400 Bad Request`.
  - **After**: API returns `422 Unprocessable Entity` with error details.

  ```json
  {
    "status": 422,
    "error": "Unprocessable Entity",
    "code": "53",
    "title": "No price exists for the tariff",
    "detail": "No fare information match with the request",
    "correlationId": "e76b44e8-91e2-4fba-88d8-562a6ed7d755",
    "service": "ota-service",
    "instance": "/v2015b/OTA",
    "tenant": "test-skywork-dev",
    "timestamp": "2025-04-17T02:48:50.175504998Z",
    "cause": {
      "status": 422,
      "code": "53",
      "title": "No price exists for the tariff",
      "detail": "No fare information match with the request",
      "correlationId": "e76b44e8-91e2-4fba-88d8-562a6ed7d755",
      "service": "hhr-proxy",
      "instance": "/v2015b/OTA",
      "tenant": "test-skywork-dev",
      "timestamp": "2025-04-17T02:48:50.171876533Z"
    }
  }
  ```

- **Service not Available**: When HHR EBKS service is unavailable.
  - **Before** – GO7 adds whole content of external error and responds with `502 bad gateway`
  - **After** – return the original error from the HHR EBKS system with its status, wrapped in our standard response structure (Problem JSON)

<details>
  <summary>Before</summary>
  <pre>
{
  "timestamp": "2025-01-13T09:12:24.574+00:00",
  "status": 502,
  "error": "Bad Gateway",
  "exception": "org.springframework.web.client.HttpServerErrorException$BadGateway",
  "message": "",
  "title": "",
  "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
  "service": "ota-service",
  "instance": "/v2015b/OTA",
  "tenant": "test-rs3",
  "cause": {
    "status": 502,
    "instance": "/reservations",
    "cause": {
      "title": "Bad Gateway",
      "status": 502,
      "detail": "503 Service Unavailable: \"",
      "instance": "/reservations",
      "cause": {
        "timestamp": "2025-04-13T06:25:20.652+00:00",
        "path": "/transport/api/v1/purchase",
        "status": 503,
        "error": "Service Unavailable",
        "requestId": "e1e1f214-407919"
      },
      "exception": "org.springframework.web.client.HttpServerErrorException$InternalServerError",
      "timestamp": "2025-01-13T09:12:24.549302606Z",
      "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
      "service": "hhr-proxy",
      "tenant": "test-rs3"
    },
    "tenant": "test-rs3",
    "service": "reservation-service",
    "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
    "message": "",
    "exception": "org.springframework.web.client.HttpServerErrorException$BadGateway",
    "error": "Bad Gateway",
    "timestamp": "2025-01-13T09:12:24.572+00:00"
  }
}
  </pre>
</details>

<details>
  <summary>After</summary>
  <pre>
{
  "status": 503,
  "error": "Service Unavailable",
  "code": "450",
  "title": "Unable to process",
  "correlationId": "b1589271-9e52-4a57-98bf-6f05c6a15dbb",
  "service": "ota-service",
  "instance": "/v2015b/OTA",
  "tenant": "test-rs3",
  "timestamp": "2025-04-13T06:20:03.173515305Z",
  "cause": {
    "status": 503,
    "error": "Service Unavailable",
    "title": "",
    "correlationId": "b1589271-9e52-4a57-98bf-6f05c6a15dbb",
    "service": "reservation-service",
    "instance": "/reservations",
    "tenant": "test-rs3",
    "timestamp": "2025-04-13T06:20:03.170+00:00",
    "exception": "org.springframework.web.client.HttpServerErrorException$ServiceUnavailable",
    "cause": {
      "status": 503,
      "code": 0,
      "title": null,
      "correlationId": "b1589271-9e52-4a57-98bf-6f05c6a15dbb",
      "service": "hhr-proxy",
      "instance": "/reservations",
      "tenant": "test-rs3",
      "timestamp": "2025-04-13T06:20:03.163394791Z"
    },
    "message": ""
  }
}
  </pre>
</details>
<br/>
- **The error from external service (3rd party integration)**

> **Note:** The external error response will be formatted to our standard response structure (Problem JSON)

1. **Before** – GO7 wraps the original external error deeply nested in the `cause` tree and returns a `502 Bad Gateway`
2. **After** – response is reformatted to standard Problem JSON structure with original error's `status`, `code`, `title`, and `detail`

<details>
  <summary>Before</summary>
  <pre>
{
  "timestamp": "2025-01-13T09:12:24.574+00:00",
  "status": 502,
  "error": "Bad Gateway",
  "exception": "org.springframework.web.client.HttpServerErrorException$BadGateway",
  "message": "",
  "title": "",
  "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
  "service": "ota-service",
  "instance": "/v2015b/OTA",
  "tenant": "test-skywork-dev",
  "cause": {
    "status": 502,
    "instance": "/reservations",
    "cause": {
      "title": "Bad Gateway",
      "status": 502,
      "detail": "500 Internal Server Error: \"{\\\"code\\\":9999,\\\"message\\\":\\\"Unknown error\\\",\\\"details\\\":[{\\\"reason\\\":\\\"Could not commit JPA transaction\\\"}]}\"",
      "instance": "/reservations",
      "cause": {
        "details": [
          {
            "reason": "Could not commit JPA transaction"
          }
        ],
        "message": "Unknown error",
        "code": 9999
      },
      "exception": "org.springframework.web.client.HttpServerErrorException$InternalServerError",
      "timestamp": "2025-01-13T09:12:24.549302606Z",
      "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
      "service": "hhr-proxy",
      "tenant": "test-rs3"
    },
    "tenant": "test-skywork-dev",
    "service": "reservation-service",
    "correlationId": "a68ad759-daf5-48a2-bdaf-50c6c221a3a3",
    "message": "",
    "exception": "org.springframework.web.client.HttpServerErrorException$BadGateway",
    "error": "Bad Gateway",
    "timestamp": "2025-01-13T09:12:24.572+00:00"
  }
}
  </pre>
</details> 

<details>
  <summary>After</summary>
  <pre>
{
  "status": 500,
  "error": "Internal Server Error",
  "code": "9999",
  "title": "Unknown error",
  "detail": "Could not commit JPA transaction",
  "correlationId": "79f48120-952c-4ebe-b889-809c129932ee",
  "service": "ota-service",
  "instance": "/v2015b/OTA",
  "tenant": "test-skywork-dev",
  "timestamp": "2025-04-17T02:48:11.178912262Z",
  "cause": {
    "status": 500,
    "error": "Internal Server Error",
    "title": "Unknown error",
    "detail": "Could not commit JPA transaction",
    "correlationId": "79f48120-952c-4ebe-b889-809c129932ee",
    "service": "hhr-proxy",
    "instance": "/reservations",
    "tenant": "test-rs3",
    "timestamp": "2025-04-17T02:48:10.145711265Z"
  }
}
  </pre>
</details>


### 2025-04-16

#### Improved documents URLs in `TPAExtension` for `OTA_AirDemandTicketRS` and `OTA_AirBookRS`

To remove ambiguity in document download URLs and to simplify handling service responses, 
the `links` element has been added instead of the string field `urls`. 
The old field (`urls`) will remain for backward compatibility. 
The new field will contain the actual URL (`href`), a relation type (`rel`), and **optional** `segmentRPH` and `travelerRPH`.

```
 "links": [
    {
      "href" : "https://domain.com/tickets/download?ref=11",
      "rel" : "downloadTicket",
      "segmentRPH" : "1", // Optional
      "travelerRPH" : "1" // Optional
    }
  ]
```

<details open>
  <summary>Old version</summary>
  <pre><code>
    "tpaextensions": {
      "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX"
    }
  </code></pre>
</details>

<details open>
  <summary>New version</summary>
  <pre><code>
    "tpaextensions": {
      "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX",
      "links": [
        {
          "href" : "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX",
          "rel" : "downloadTicket",
          "segmentRPH" : "1",
          "travelerRPH" : "1"
        },
        {
          "href" : "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX",
          "rel" : "downloadTicket",
          "segmentRPH" : "2",
          "travelerRPH" : "1"
        }
      ]
    }
  </code></pre>
</details>

**Example**
- [See Response Payload (named passengers) in Payment and Ticketing](endpoints/payment_and_ticketing.md#request)
- [See Response Payload in Read booking](endpoints/read_booking.md#response)
