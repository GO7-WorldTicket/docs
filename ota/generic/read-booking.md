---
layout: default
title: Read Booking
---

# Read Booking (ReadRQ)

The purpose is to read the existing booking in the airline system to display the booking information. This allows you to retrieve complete booking details including passenger information, flight segments, pricing, and booking status.

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
- [Booking Status Codes](#booking-status-codes)
- [Error Responses](#error-responses)

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

## Request Parameters

All parameters are required for the ReadRQ request.

| Parameter | Description | Example |
|-----------|-------------|---------|
| base_url | Base URL | https://test-api.worldticket.net/ota/v2015b/OTA_ReadRQ |
| access_token | Access Token | *** |

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
        "bookingChannel": {
          "type": "{booking_channel_type}"
        },
        "isocurrency": "{currency_code}",
        "requestorID": {
          "type": "5",
          "id": "{agentId}",
          "name": "{agencyId}"
        }
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "{record_locator}",
          "type": "14"
        },
        "verification": {
          "personName": {
            "surname": "{contact_person_surname}"
          }
        }
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
        "bookingChannel": {
          "type": "COM"
        },
        "isocurrency": "USD",
        "requestorID": {
          "type": "5",
          "id": "agent123",
          "name": "AGENT1"
        }
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "ABCXYZ",
          "type": "14"
        },
        "verification": {
          "personName": {
            "surname": "SMITH"
          }
        }
      }
    ]
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
  "success": {},
  "version": 2.001,
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "XMD"
                },
                "arrivalAirport": {
                  "locationCode": "JED"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "HHR",
                  "flightNumber": "7211"
                },
                "equipment": [],
                "departureDateTime": "2023-12-13T21:00:00.000+03:00",
                "arrivalDateTime": "2023-12-13T22:54:00.000+03:00",
                "stopQuantity": 0,
                "rph": "1",
                "marketingAirline": {
                  "value": "",
                  "code": "HHR"
                },
                "flightNumber": "7211",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YECOSTD",
                  "priceGroup": "Eco",
                  "fareRule": {
                    "code": "Economy",
                    "name": "${[en_US]:pricing.farerules.general.name.Economy}",
                    "value": "Economy"
                  },
                  "operations": [
                    {
                      "modificationType": "30",
                      "name": "REBOOK"
                    },
                    {
                      "modificationType": "3",
                      "name": "CHANGE_NAME"
                    }
                  ]
                }
              }
            ]
          },
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "JED"
                },
                "arrivalAirport": {
                  "locationCode": "XMD"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "HHR",
                  "flightNumber": "7210"
                },
                "equipment": [],
                "departureDateTime": "2023-12-16T21:00:00.000+03:00",
                "arrivalDateTime": "2023-12-16T22:54:00.000+03:00",
                "stopQuantity": 0,
                "rph": "2",
                "marketingAirline": {
                  "value": "",
                  "code": "HHR"
                },
                "flightNumber": "7210",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YECOSTD",
                  "priceGroup": "Eco",
                  "fareRule": {
                    "code": "Economy",
                    "name": "${[en_US]:pricing.farerules.general.name.Economy}",
                    "value": "Economy"
                  },
                  "operations": [
                    {
                      "modificationType": "30",
                      "name": "REBOOK"
                    },
                    {
                      "modificationType": "3",
                      "name": "CHANGE_NAME"
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    },
    "priceInfo": {
      "itinTotalFare": [
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 869.56
          },
          "equivFare": [],
          "fees": {
            "fee": [
              {
                "value": "",
                "feeCode": "VAT_TOTAL",
                "currencyCode": "SAR",
                "decimalPlaces": 2,
                "amount": 130.44
              }
            ]
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 1000.00
          },
          "fareBaggageAllowance": [],
          "remark": []
        }
      ]
    },
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [
              "Mr"
            ],
            "givenName": [
              "ONE"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "twer4543r",
              "docType": "2",
              "docIssueCountry": "AL",
              "docHolderNationality": "AX",
              "expireDate": "2023-12-27"
            }
          ],
          "travelerRefNumber": {
            "rph": "1"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "birthDate": "2023-12-01",
          "passengerTypeCode": "ADT",
          "gender": "Male",
          "comment": []
        }
      ],
      "specialReqDetails": []
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [],
        "travelerRefNumber": [
          "1"
        ],
        "ticketDocumentNbr": "2772460002620",
        "passengerTypeCode": "ADT",
        "miscTicketingCode": [],
        "tpaextensions": {
          "couponInfos": [
            {
              "flightRefRPH": "1",
              "number": "1",
              "status": "O"
            },
            {
              "flightRefRPH": "2",
              "number": "2",
              "status": "O"
            }
          ]
        }
      }
    ],
    "bookingReferenceID": [
      {
        "companyName": {
          "value": "",
          "code": "W2"
        },
        "type": "14",
        "id": "VTOQF4",
        "flightRefNumberRPHList": []
      }
    ],
    "offer": {
      "summary": [],
      "priced": [
        {
          "shortDescription": [],
          "longDescription": [],
          "originDestination": [],
          "otherServices": [],
          "restriction": [],
          "termsAndConditions": [],
          "commission": [],
          "multimedia": [],
          "bookingReferenceID": [],
          "id": "1296300",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "SAR",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PAID",
              "totalAmount": 0.00,
              "action": "CREATE_BOOKING",
              "currencyCode": "SAR",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PAID",
              "totalAmount": 0.00
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2023-12-06T03:42:50.000Z",
    "emdinfo": []
  },
  "timeStamp": "2023-12-08T04:22:27.312Z",
  "retransmissionIndicator": false
}
```
</div>

</details>

### JSON Response Structure

#### JSON Response

| Field                   | Type      | Description                                | Required |
|--------------------------|-----------|--------------------------------------------|----------|
| success                 | object    | Empty object indicating success             | Required |
| version                 | number    | Schema version (e.g., `2.001`)             | Required |
| airReservation          | object    | Contains all reservation details            | Required |
| timeStamp               | string (date-time) | Response creation timestamp      | Required |
| retransmissionIndicator | boolean   | Indicates retransmission                   | Optional |

---

#### airReservation.airItinerary.originDestinationOptions.originDestinationOption[].flightSegment[]

| Field                                | Type      | Description                          | Required |
|--------------------------------------|-----------|--------------------------------------|----------|
| departureAirport.locationCode        | string    | Departure airport IATA code          | Required |
| arrivalAirport.locationCode          | string    | Arrival airport IATA code            | Required |
| operatingAirline.value               | string    | Operating airline name               | Optional |
| operatingAirline.code                | string    | Operating carrier code               | Required |
| operatingAirline.flightNumber        | string    | Operating flight number              | Required |
| equipment                            | array     | Equipment info (e.g., aircraft type) | Optional |
| departureDateTime                    | string (date-time) | Departure time             | Required |
| arrivalDateTime                      | string (date-time) | Arrival time               | Required |
| stopQuantity                         | integer   | Number of stops                      | Required |
| rph                                  | string    | Reference placeholder                | Required |
| marketingAirline.value               | string    | Marketing airline name               | Optional |
| marketingAirline.code                | string    | Marketing airline code               | Required |
| flightNumber                         | string    | Marketing flight number              | Required |
| resBookDesigCode                     | string    | Booking class code                   | Required |
| bookingClassAvails                   | array     | Booking class availability           | Optional |
| comment                              | array     | Comments                             | Optional |
| stopLocation                         | array     | Stop location details                 | Optional |
| status                               | string    | Segment status code                  | Required |
| tpaextensions.fareBasis              | string    | Fare basis code                      | Required |
| tpaextensions.priceGroup             | string    | Price group (e.g., `Eco`)            | Required |
| tpaextensions.fareRule.code          | string    | Fare rule code                       | Required |
| tpaextensions.fareRule.name          | string    | Fare rule display name               | Required |
| tpaextensions.fareRule.value         | string    | Fare rule value                      | Required |
| tpaextensions.operations[].modificationType | string | Modification type code     | Required |
| tpaextensions.operations[].name      | string    | Modification action name             | Required |

---

#### airReservation.priceInfo.itinTotalFare[]

| Field                     | Type    | Description                          | Required |
|----------------------------|---------|--------------------------------------|----------|
| baseFare.currencyCode      | string  | Base fare currency                   | Required |
| baseFare.amount            | number  | Base fare amount                     | Required |
| equivFare                  | array   | Equivalent fare amounts              | Optional |
| fees.fee[].value           | string  | Fee description                      | Optional |
| fees.fee[].feeCode         | string  | Fee code (e.g., `VAT_TOTAL`)         | Required |
| fees.fee[].currencyCode    | string  | Fee currency code                    | Required |
| fees.fee[].decimalPlaces   | integer | Fee decimal precision                | Required |
| fees.fee[].amount          | number  | Fee amount                           | Required |
| totalFare.currencyCode     | string  | Total fare currency                  | Required |
| totalFare.amount           | number  | Total fare amount                    | Required |
| fareBaggageAllowance       | array   | Baggage allowance                    | Optional |
| remark                     | array   | Remarks                              | Optional |

---

#### airReservation.travelerInfo.airTraveler[]

| Field                              | Type    | Description                         | Required |
|-----------------------------------|---------|-------------------------------------|----------|
| personName.namePrefix[]           | array[string] | Name prefix (e.g., `Mr`)     | Optional |
| personName.givenName[]            | array[string] | Given name(s)                | Required |
| personName.middleName[]           | array   | Middle names                        | Optional |
| personName.surname                | string  | Surname/last name                   | Required |
| personName.nameSuffix[]           | array   | Name suffix                         | Optional |
| personName.nameTitle[]            | array   | Name title                          | Optional |
| telephone                         | array   | Traveler telephone numbers           | Optional |
| email                             | array   | Traveler emails                      | Optional |
| address                           | array   | Traveler addresses                   | Optional |
| custLoyalty                       | array   | Loyalty program memberships          | Optional |
| document[].docID                  | string  | Document ID (e.g., passport number) | Required |
| document[].docType                | string  | Document type                        | Required |
| document[].docIssueCountry        | string  | Document issuing country             | Required |
| document[].docHolderNationality   | string  | Holder nationality                   | Required |
| document[].expireDate             | string (date) | Document expiration date     | Required |
| travelerRefNumber.rph             | string  | Traveler reference ID                | Required |
| flightSegmentRPHs.flightSegmentRPH[] | array[string] | Linked flight references | Required |
| socialMediaInfo                   | array   | Social media info                    | Optional |
| birthDate                         | string (date) | Date of birth                 | Required |
| passengerTypeCode                 | string  | Passenger type (e.g., `ADT`)         | Required |
| gender                            | string  | Traveler gender                      | Required |
| comment                           | array   | Traveler comments                    | Optional |

---

#### airReservation.ticketing[]

| Field                            | Type    | Description                   | Required |
|----------------------------------|---------|-------------------------------|----------|
| ticketAdvisory                   | array   | Ticket advisories             | Optional |
| ticketType                       | string  | Ticket type (e.g., `E_TICKET`)| Required |
| flightSegmentRefNumber           | array   | Referenced flight segments    | Optional |
| travelerRefNumber[]              | array[string] | Traveler reference numbers | Required |
| ticketDocumentNbr                | string  | Ticket number                 | Required |
| passengerTypeCode                | string  | Passenger type                 | Required |
| miscTicketingCode                | array   | Misc ticketing codes          | Optional |
| tpaextensions.couponInfos[].flightRefRPH | string | Flight reference RPH | Required |
| tpaextensions.couponInfos[].number | string | Coupon number                | Required |
| tpaextensions.couponInfos[].status | string | Coupon status                | Required |

---

#### airReservation.bookingReferenceID[]

| Field                     | Type    | Description                | Required |
|----------------------------|---------|----------------------------|----------|
| companyName.value          | string  | Company name (optional)    | Optional |
| companyName.code           | string  | Company code               | Required |
| type                       | string  | Reference type             | Required |
| id                         | string  | Booking reference ID       | Required |
| flightRefNumberRPHList     | array   | Linked flight references   | Optional |

---

#### airReservation.offer

| Field                                        | Type    | Description                 | Required |
|----------------------------------------------|---------|-----------------------------|----------|
| summary                                      | array   | Offer summary               | Optional |
| priced[].id                                  | string  | Offer ID                    | Required |
| priced[].shortDescription                    | array   | Short description           | Optional |
| priced[].longDescription                     | array   | Long description            | Optional |
| priced[].originDestination                   | array   | Origin/Destination details  | Optional |
| priced[].otherServices                       | array   | Additional services         | Optional |
| priced[].restriction                         | array   | Restrictions                | Optional |
| priced[].termsAndConditions                  | array   | Terms and conditions        | Optional |
| priced[].commission                          | array   | Commission info             | Optional |
| priced[].multimedia                          | array   | Multimedia content          | Optional |
| priced[].bookingReferenceID                  | array   | Booking references          | Optional |
| priced[].tpaextensions.orderInfo.action      | string  | Order action                | Required |
| priced[].tpaextensions.orderInfo.currencyCode| string  | Order currency              | Required |
| priced[].tpaextensions.orderInfo.direction   | string  | Transaction direction       | Required |
| priced[].tpaextensions.orderInfo.orderType   | string  | Order type                  | Required |
| priced[].tpaextensions.orderInfo.status      | string  | Order status                | Required |
| priced[].tpaextensions.orderInfo.totalAmount | number  | Order total amount          | Required |
| purchased                                    | array   | Purchased offers            | Optional |

---

#### airReservation (Other fields)

| Field            | Type    | Description                     | Required |
|------------------|---------|---------------------------------|----------|
| createDateTime   | string (date-time) | Reservation creation time | Required |
| emdinfo          | array   | EMD info (Electronic Misc Doc) | Optional |


## Error Responses

Common error responses for read booking requests:

### Booking Not Found

```json
{
  "title": "System error",
  "status": 400,
  "detail": "Cannot retrieve the reservation for ABCXYZ",
  "instance": "/v2015b/OTA",
  "code": "448",
  "language": "en",
  "error": "Bad Request",
  "timestamp": "2025-09-24T06:43:33.715261976Z",
  "correlationId": "{reference id to track the issue}",
  "service": "ota-service",
}
```

### Invalid API Key

```json
{
  "errorDescription": "Invalid API Key",
  "apiKey": "{sent-api-key}",
  "message": "API key not found",
  "status": 401,
  "timestamp": "2025-09-24T06:45:57.262246403"
}
```
