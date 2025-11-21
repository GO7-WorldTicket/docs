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
        "bookingChannel": {
          "type": "OTA"
        },
        "isoCurrency": "{currency_code}"
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "{record_locator}",
          "type": "14"
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
          "type": "OTA"
        },
        "isoCurrency": "USD"
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "7YF3OW",
          "type": "14"
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
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "KRP"
                },
                "arrivalAirport": {
                  "locationCode": "CPH"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "DX",
                  "flightNumber": "9901"
                },
                "equipment": [],
                "departureDateTime": "2025-11-29T18:10:00.000+01:00",
                "arrivalDateTime": "2025-11-29T19:00:00.000+01:00",
                "stopQuantity": 0,
                "rph": "1",
                "marketingAirline": {
                  "value": "",
                  "code": "DX"
                },
                "flightNumber": "9901",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YDXBED",
                  "priceGroup": "Bedre",
                  "fareRule": {
                    "code": "ECOBOW",
                    "name": "BEDRE",
                    "value": "Time/date can be changed prior to departure for a fee of DKK 200 per segment + fare difference. Cannot be rebooked to a less expensive fare. Name change for a fee of DKK 200 per segment. Refund not allowed. 1 piece (23 kg) checked-in luggage included. 8 kg of hand luggage included. 24 hour cancellation grace period after booking if departure is not within 24 hours. Children (2-15 years) pay 75% of the net fare (ex. taxes). Infants not requiring a separate seat can be added for free. An administration fee of DKK 95 per flight is charged for processing a refund. General terms and conditions also apply."
                  },
                  "operations": [
                    {
                      "modificationType": "10",
                      "name": "CANCEL"
                    },
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
            "currencyCode": "USD",
            "amount": 31.76
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "value": "",
                "taxCode": "DC",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 2.04
              },
              {
                "value": "",
                "taxCode": "EU",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 4.07
              }
            ]
          },
          "fees": {
            "fee": [
              {
                "value": "",
                "feeCode": "VAT_DC",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "VAT_EU",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "VAT_NET",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 2.78
              }
            ]
          },
          "totalFare": {
            "currencyCode": "USD",
            "amount": 39.73
          },
          "fareBaggageAllowance": [],
          "remark": []
        }
      ],
      "ptcfareBreakdowns": {
        "ptcfareBreakdown": [
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 1
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "YDXBED"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 31.76
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "value": "",
                      "taxCode": "DC",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 2.04
                    },
                    {
                      "value": "",
                      "taxCode": "EU",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 4.07
                    }
                  ]
                },
                "fees": {
                  "fee": [
                    {
                      "value": "",
                      "feeCode": "VAT_DC",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "VAT_EU",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "VAT_NET",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 2.86
                    }
                  ]
                },
                "totalFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 40.73
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          }
        ]
      }
    },
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "QA"
            ],
            "middleName": [],
            "surname": "TESTER",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "66",
              "phoneNumber": "78945612"
            }
          ],
          "email": [
            {
              "value": "johndoe@example.com"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "741852369",
              "docType": "2",
              "docHolderNationality": "TH",
              "expireDate": "2025-12-31"
            }
          ],
          "travelerRefNumber": {
            "rph": "1"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Male",
          "comment": []
        }
      ],
      "specialReqDetails": [
        {
          "specialServiceRequests": {
            "specialServiceRequest": [
              {
                "text": "PP 741852369",
                "serviceQuantity": 1,
                "status": "30",
                "number": 1,
                "travelerRefNumberRPHList": [
                  "1"
                ],
                "flightRefNumberRPHList": [
                  "1"
                ],
                "ssrcode": "FOID"
              }
            ]
          },
          "specialRemarks": {
            "specialRemark": [
              {
                "travelerRefNumber": [
                  {
                    "rph": "1"
                  }
                ],
                "flightRefNumber": [],
                "text": "PREPAID",
                "airline": [],
                "remarkType": "9",
                "id": "XBAG"
              }
            ]
          }
        }
      ]
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [],
        "travelerRefNumber": [
          "1"
        ],
        "ticketDocumentNbr": "2772770020247",
        "passengerTypeCode": "ADT",
        "miscTicketingCode": [],
        "tpaextensions": {
          "couponInfos": [
            {
              "flightRefRPH": "1",
              "number": "1",
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
          "code": "DX"
        },
        "type": "14",
        "id": "7YF3OW",
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
          "id": "2166329",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137168",
              "status": "PAID",
              "totalAmount": "39.73"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-19T10:03:37.000Z",
    "emdinfo": []
  },
  "success": {},
  "timeStamp": "2025-11-19T10:29:14.857Z",
  "version": 2.001,
  "retransmissionIndicator": false
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

