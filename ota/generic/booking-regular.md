---
layout: default
title: Regular Booking (AirBookRQ)
---

# Create a Regular Booking (AirBookRQ)

The purpose is to create the booking in the airline system by providing a specific flight and fare in the request.

## Table of Contents

- [Endpoints](#endpoints)
- [Regular Booking Workflow](#regular-booking-workflow)
- [Basic Request Format](#basic-request-format)
- [AirBookRQ for One-way Trip](#airbookrq-for-one-way-trip)
- [AirBookRQ for Round Trip](#airbookrq-for-round-trip)
- [Special Service Requests (SSR)](#special-service-requests-ssr)
- [Payment Details](#payment-details)
- [Payment Types](#payment-types)
- [Response Structure](#response-structure)
- [Booking Status Codes](#booking-status-codes)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://api.worldticket.net |
| Test | https://test-api.worldticket.net |

## Endpoint

- Method: `POST`
- Path: `/ota/v2015b/OTA_AirBookRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_AirBookRQ` (choose base URL per environment above)

## HTTP Headers

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| X-Realm | Airline realm identifier | {tenant-name} |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

## Regular Booking Workflow

```mermaid
sequenceDiagram
    autonumber
    participant Customer as End Customer
    participant Application as Airline Application
    participant OTA

    rect rgba(255, 221, 221, 0.3)
        Note over Application: 3rd party
    end
    rect rgba(173, 216, 230, 0.3)
        Note over OTA: Worldticket
    end

    Note over Customer, OTA: Regular Booking Process
    Customer->>+Application: Provide booking information<br/>(passenger details, flight selection)
    Note right of Application: Passenger name, address,<br/>phone, email, document details
    Application->>+OTA: OTA_AirBookRQ
    Note right of OTA: Create booking in airline system<br/>assign record locator
    OTA-->>-Application: OTA_AirBookRS
    Note right of Application: Success: Booking information<br/>PNR Record Locator
    Application-->>-Customer: Show booking details<br/>with confirmation

    alt Booking modification required
        Customer->>+Application: Request modification<br/>(RepriceRequired="true")
        Note right of Customer: Modifications:<br/>- Change name<br/>- Add SSR<br/>- Rebook segment
        Application->>+OTA: OTA_AirBookModifyRQ
        Note right of OTA: Calculate modification<br/>fees and charges
        OTA-->>-Application: OTA_AirBookModifyRS
        Note right of Application: Service fee/charge<br/>for booking modification
        Application-->>-Customer: Show modification costs

        Customer->>+Application: Confirm modification<br/>(RepriceRequired="false")
        Application->>+OTA: OTA_AirBookModifyRQ
        Note right of OTA: Apply booking<br/>modifications
        OTA-->>-Application: OTA_AirBookModifyRS
        Application-->>-Customer: Show updated booking
    end
```

## Basic Request Format

### With JWT Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_AirBookRQ \
    -H 'Authorization: Bearer {access_token}' \
    -H 'Content-Type: application/json' \
    -d @AirBookRQ.json
```

### With API Key Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_AirBookRQ \
    -H 'X-API-Key: {api_key}' \
    -H 'Content-Type: application/json' \
    -d @AirBookRQ.json
```

## AirBookRQ for One-way Trip

In AirBookRQ request, an itinerary and passenger names are mandatory.

Some details can be provided optionally:
- Special Service Requests (SSR)
- Payment details

<!-- XML request removed to keep JSON-only documentation -->

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "isoCurrency": "{currency_code}",
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        },
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": {
      "originDestinationOption": [
        {
          "flightSegment": [
            {
              "departureDateTime": "{departure_datetime}",
              "arrivalDateTime": "{arrival_datetime}",
              "flightNumber": "{flight_number}",
              "resBookDesigCode": "{booking_class}",
              "numberInParty": "{total_passengers}",
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
    }
  },
  "travelerInfo": {
    "airTraveler": [
      {
        "passengerTypeCode": "CTC",
        "personName": {
          "givenName": [
            "{first_name}"
          ],
          "middleName": [
            "{middle_name}"
          ],
          "surname": "{last_name}"
        },
        "email": [
          {
            "value": "{email_address}"
          }
        ],
        "telephone": [
          {
            "countryAccessCode": "{country_code}",
            "phoneNumber": "{phone_number}"
          }
        ],
        "address": [
          {
            "cityName": "{city_name}",
            "countryName": {
              "value": "{country_name}",
              "code": "{country_code}"
            }
          }
        ]
      },
      {
        "passengerTypeCode": "ADT",
        "personName": {
          "namePrefix": [
            "{name_prefix}"
          ],
          "givenName": [
            "{first_name}"
          ],
          "surname": "{last_name}"
        },
        "telephone": [
          {
            "countryAccessCode": "{country_code}",
            "phoneNumber": "{phone_number}"
          }
        ],
        "email": [
          {
            "value": "{email_address}"
          }
        ],
        "document": [
          {
            "docID": "{document_number}",
            "docType": "{document_type}",
            "docHolderNationality": "{nationality_code}",
            "expireDate": "{expiry_date}",
            "birthDate": "{birth_date}"
          }
        ],
        "travelerRefNumber": {
          "rph": "{passenger_reference}"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "{segment_reference}"
          ]
        },
        "gender": "{gender}"
      }
    ]
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
        "isoCurrency": "USD",
        "requestorID": { "type": "5", "id": "AGENT123", "name": "AGENCY1" },
        "bookingChannel": { "type": "OTA" }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": {
      "originDestinationOption": [
        {
          "flightSegment": [
            {
              "departureDateTime": "2024-12-25T08:00:00",
              "arrivalDateTime": "2024-12-25T11:30:00",
              "flightNumber": "WT100",
              "resBookDesigCode": "Y",
              "numberInParty": "1",
              "departureAirport": { "locationCode": "JED" },
              "arrivalAirport": { "locationCode": "XMK" },
              "marketingAirline": { "code": "WT" }
            }
          ]
        }
      ]
    }
  },
  "travelerInfo": {
    "airTraveler": [
      {
        "passengerTypeCode": "CTC",
        "personName": {
          "givenName": [ "QA" ],
          "middleName": [ "TEST" ],
          "surname": "TESTER"
        },
        "email": [ { "value": "tester@example.com" } ],
        "telephone": [
          {
            "countryAccessCode": "1",
            "phoneNumber": "5551234567"
          }
        ],
        "address": [
          {
            "cityName": "New York",
            "countryName": {
              "value": "United States",
              "code": "US"
            }
          }
        ]
      },
      {
        "passengerTypeCode": "ADT",
        "personName": {
          "namePrefix": [ "MR" ],
          "givenName": [ "JOHN" ],
          "surname": "DOE"
        },
        "telephone": [
          {
            "countryAccessCode": "1",
            "phoneNumber": "5551234567"
          }
        ],
        "email": [ { "value": "john.doe@example.com" } ],
        "document": [
          {
            "docID": "X1234567",
            "docType": "5",
            "docHolderNationality": "US",
            "expireDate": "2030-12-31",
            "birthDate": "1990-01-15"
          }
        ],
        "travelerRefNumber": { "rph": "1" },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [ "1" ]
        },
        "gender": "Male"
      }
    ]
  }
}
```

</div>

</details>

## AirBookRQ for Round Trip

<!-- XML request removed to keep JSON-only documentation -->

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "isoCurrency": "{currency_code}",
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        },
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": {
      "originDestinationOption": [
        {
          "flightSegment": [
            {
              "departureDateTime": "{outbound_departure_datetime}",
              "arrivalDateTime": "{outbound_arrival_datetime}",
              "flightNumber": "{outbound_flight_number}",
              "resBookDesigCode": "{booking_class}",
              "numberInParty": "{total_passengers}",
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
        },
        {
          "flightSegment": [
            {
              "departureDateTime": "{inbound_departure_datetime}",
              "arrivalDateTime": "{inbound_arrival_datetime}",
              "flightNumber": "{inbound_flight_number}",
              "resBookDesigCode": "{booking_class}",
              "numberInParty": "{total_passengers}",
              "departureAirport": {
                "locationCode": "{destination_code}"
              },
              "arrivalAirport": {
                "locationCode": "{origin_code}"
              },
              "marketingAirline": {
                "code": "{airline_code}"
              }
            }
          ]
        }
      ]
    }
  },
  "travelerInfo": [
    {
      "airTraveler": {
        "personName": {
          "givenName": "{first_name}",
          "surname": "{last_name}"
        },
        "document": {
          "docType": "{document_type}",
          "docID": "{document_number}",
          "expireDate": "{expiry_date}"
        },
        "travelerRefNumber": {
          "rph": "1"
        }
      }
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
        "isoCurrency": "USD",
        "requestorID": { "type": "5", "id": "AGENT123", "name": "AGENCY1" },
        "bookingChannel": { "type": "OTA" }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": {
      "originDestinationOption": [
        {
          "flightSegment": [
            {
              "departureDateTime": "2024-12-25T08:00:00",
              "arrivalDateTime": "2024-12-25T11:30:00",
              "flightNumber": "WT100",
              "resBookDesigCode": "Y",
              "numberInParty": "2",
              "departureAirport": { "locationCode": "JED" },
              "arrivalAirport": { "locationCode": "XMK" },
              "marketingAirline": { "code": "WT" }
            }
          ]
        },
        {
          "flightSegment": [
            {
              "departureDateTime": "2025-01-02T16:00:00",
              "arrivalDateTime": "2025-01-02T19:30:00",
              "flightNumber": "WT101",
              "resBookDesigCode": "Y",
              "numberInParty": "2",
              "departureAirport": { "locationCode": "XMK" },
              "arrivalAirport": { "locationCode": "JED" },
              "marketingAirline": { "code": "WT" }
            }
          ]
        }
      ]
    }
  },
  "travelerInfo": {
    "airTraveler": [
      {
        "passengerTypeCode": "CTC",
        "personName": {
          "givenName": [ "QA" ],
          "middleName": [ "TEST" ],
          "surname": "TESTER"
        },
        "email": [ { "value": "tester@example.com" } ],
        "telephone": [
          {
            "countryAccessCode": "966",
            "phoneNumber": "501234567"
          }
        ],
        "address": [
          {
            "cityName": "Riyadh",
            "countryName": {
              "value": "Saudi Arabia",
              "code": "SA"
            }
          }
        ]
      },
      {
        "passengerTypeCode": "ADT",
        "personName": {
          "namePrefix": [ "MR" ],
          "givenName": [ "JOHN" ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "966",
            "phoneNumber": "501234567"
          }
        ],
        "email": [ { "value": "john.parker@example.com" } ],
        "document": [
          {
            "docID": "1234567890",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1985-06-20"
          }
        ],
        "travelerRefNumber": { "rph": "1" },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [ "1", "2" ]
        },
        "gender": "Male"
      },
      {
        "passengerTypeCode": "ADT",
        "personName": {
          "namePrefix": [ "MS" ],
          "givenName": [ "JANE" ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "966",
            "phoneNumber": "501234567"
          }
        ],
        "email": [ { "value": "jane.parker@example.com" } ],
        "document": [
          {
            "docID": "0987654321",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2028-08-15",
            "birthDate": "1988-03-10"
          }
        ],
        "travelerRefNumber": { "rph": "2" },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [ "1", "2" ]
        },
        "gender": "Female"
      }
    ]
  }
}
```

</div>

</details>

## Special Service Requests (SSR)

### Adding SSR to Booking Request

```json
{
  "travelerInfo": [
    {
      "airTraveler": {
        "personName": {
          "givenName": "{first_name}",
          "surname": "{last_name}"
        },
        "document": {
          "docType": "{document_type}",
          "docID": "{document_number}",
          "expireDate": "{expiry_date}"
        },
        "travelerRefNumber": {
          "rph": "1"
        },
        "specialServiceRequests": [
          {
            "ssrCode": "MEAL",
            "serviceQuantity": 1,
            "status": "Requested",
            "text": "Vegetarian meal"
          },
          {
            "ssrCode": "SEAT",
            "serviceQuantity": 1,
            "status": "Requested",
            "text": "Aisle seat preference"
          }
        ]
      }
    }
  ]
}
```

## Payment Details

### Including Payment Information

```json
{
  "fulfillment": {
    "paymentDetails": {
      "paymentDetail": {
        "paymentType": "1",
        "directBill": {
          "directBillID": "{account_id}"
        }
      }
    }
  }
}
```

### Payment Types

| Code | Payment Type |
|------|--------------|
| 1 | Cash |
| 4 | Debit Credit Account |
| 5 | Credit Card |
| 32 | External Payment |
| 40 | Invoice |

## Response Structure

<!-- XML response removed to keep JSON-only documentation -->

### JSON Response

```json
{
  "version": "2.001",
  "success": {},
  "airReservation": {
    "bookingReferenceID": {
      "id": "ABCDEF",
      "type": "14",
      "companyName": {
        "code": "WT"
      }
    },
    "airItinerary": {
      "originDestinationOptions": [
        {
          "flightSegment": {
            "departureDateTime": "2024-12-25T08:00:00",
            "arrivalDateTime": "2024-12-25T11:30:00",
            "flightNumber": "WT100",
            "resBookDesigCode": "Y",
            "status": "HK",
            "departureAirport": {
              "locationCode": "JED"
            },
            "arrivalAirport": {
              "locationCode": "XMK"
            },
            "marketingAirline": {
              "code": "WT"
            }
          }
        }
      ]
    },
    "travelerInfo": {
      "airTraveler": [
        {
          "passengerTypeCode": "CTC",
          "personName": {
            "givenName": [ "QA" ],
            "middleName": [ "TEST" ],
            "surname": "TESTER"
          },
          "email": [ { "value": "tester@example.com" } ],
          "telephone": [
            {
              "countryAccessCode": "1",
              "phoneNumber": "5551234567"
            }
          ],
          "address": [
            {
              "cityName": "New York",
              "countryName": {
                "value": "United States",
                "code": "US"
              }
            }
          ]
        },
        {
          "passengerTypeCode": "ADT",
          "personName": {
            "namePrefix": [ "MR" ],
            "givenName": [ "JOHN" ],
            "surname": "DOE"
          },
          "email": [ { "value": "john.doe@example.com" } ],
          "document": [
            {
              "docID": "X1234567",
              "docType": "5",
              "docHolderNationality": "US",
              "expireDate": "2030-12-31",
              "birthDate": "1990-01-15"
            }
          ],
          "travelerRefNumber": {
            "rph": "1"
          }
        }
      ]
    },
    "priceInfo": {
      "itinTotalFare": {
        "baseFare": {
          "amount": "250.00",
          "currencyCode": "USD"
        },
        "taxes": [
          {
            "amount": "50.00",
            "currencyCode": "USD"
          }
        ],
        "totalFare": {
          "amount": "300.00",
          "currencyCode": "USD"
        }
      }
    },
    "ticketingInfo": {
      "ticketTimeLimit": "2024-12-23T23:59:59"
    }
  }
}
```

## Booking Status Codes

| Status Code | Description |
|-------------|-------------|
| HK | Booking confirmed |
| UC | Unable to confirm |
| UN | Unable - need |
| WL | Waitlisted |
