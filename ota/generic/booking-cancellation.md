---
layout: default
title: Booking Cancellation
---

# Cancel Booking

The purpose is to cancel entire bookings or specific segments/passengers.

## Table of Contents

- [Cancel Booking](#cancel-booking)
  - [Table of Contents](#table-of-contents)
  - [Base URLs](#base-urls)
  - [Endpoints](#endpoints)
  - [Basic Request Format](#basic-request-format)
    - [With JWT Authentication](#with-jwt-authentication)
    - [With API Key Authentication](#with-api-key-authentication)
  - [HTTP Headers](#http-headers)
  - [Full Booking Cancellation](#full-booking-cancellation)
    - [JSON Request](#json-request)
    - [JSON Response](#json-response)
  - [Cancel Specific Passengers](#cancel-specific-passengers)
    - [Request Format](#request-format)
    - [JSON Request](#json-request-1)
    - [JSON Response](#json-response-1)
  - [Cancel Specific Segments](#cancel-specific-segments)
    - [Request Format](#request-format-1)
    - [JSON Request](#json-request-2)
    - [JSON Response](#json-response-2)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoints

- Method: `POST`
- Path: `/ota/v2015b/OTA_CancelRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_CancelRQ` (choose base URL per environment above)

## Basic Request Format

### With JWT Authentication

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_CancelRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @OTA_CancelRQ.json
```

### With API Key Authentication

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_CancelRQ' \
  -H 'X-API-Key: {api_key}' \
  -H 'Content-Type: application/json' \
  -d @OTA_CancelRQ.json
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

## Full Booking Cancellation

Cancel the entire booking and all associated passengers.

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "isoCurrency": "{currency_code}",
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "uniqueID": [
    {
      "id": "{record_locator}",
      "type": "14"
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
  "cancelType": "Cancel",
  "pos": {
    "source": [
      {
        "isoCurrency": "USD",
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "uniqueID": [
    {
      "id": "VRNCKG",
      "type": "14"
    }
  ]
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
  "success": {},
  "uniqueID": [
    {
      "type": "14",
      "id": "VRNCKG"
    }
  ],
  "segment": [],
  "status": "CANCELLED",
  "timeStamp": "2025-11-27T08:39:46.241Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>
</details>

## Cancel Specific Passengers

Remove individual passengers from group bookings.

### Request Format

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirBookModifyRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @AirBookModifyRQ.json
```

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": "{pos}",
  "airReservation": "{airReservation}",
  "airBookModifyRQ": {
    "modificationType": "2",
    "travelerInfo": "{travelerInfo}"
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
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "AAC",
                  "terminal": "1A"
                },
                "arrivalAirport": {
                  "locationCode": "AAL",
                  "terminal": "2B"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "DX",
                  "flightNumber": "7878"
                },
                "equipment": [],
                "departureDateTime": "2025-12-29T10:00:00.000+02:00",
                "arrivalDateTime": "2025-12-29T12:00:00.000+01:00",
                "stopQuantity": 0,
                "rph": "1",
                "marketingAirline": {
                  "value": "",
                  "code": "DX"
                },
                "flightNumber": "7878",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YID",
                  "fareRule": {
                    "code": "ID",
                    "name": "${[en]:pricing.farerules.general.name.ID}",
                    "value": "Test ID fare"
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
            "amount": 0.00
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "value": "",
                "taxCode": "MI",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.76
              }
            ]
          },
          "fees": {
            "fee": [
              {
                "value": "",
                "feeCode": "VAT_MI",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "VAT_reservation",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "reservation",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 4.48
              }
            ]
          },
          "totalFare": {
            "currencyCode": "USD",
            "amount": 5.24
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
                  "value": "YID"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 0.00
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "value": "",
                      "taxCode": "MI",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.76
                    }
                  ]
                },
                "fees": {
                  "fee": [
                    {
                      "value": "",
                      "feeCode": "VAT_MI",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "VAT_reservation",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "reservation",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 4.48
                    }
                  ]
                },
                "totalFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 5.24
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
              "QA2"
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
            },
            {
              "phoneTechType": "5",
              "phoneNumber": "78945612"
            }
          ],
          "email": [
            {
              "value": "qa2@example.com"
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
          }
        }
      ]
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [],
        "travelerRefNumber": [],
        "ticketDocumentNbr": "2772770020315",
        "passengerTypeCode": "ADT",
        "miscTicketingCode": [],
        "tpaextensions": {
          "couponInfos": [
            {
              "flightRefRPH": "1",
              "number": "1",
              "status": "E"
            }
          ]
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [],
        "travelerRefNumber": [
          "1"
        ],
        "ticketDocumentNbr": "2772468871145",
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
        "id": "AVJQY2",
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
          "id": "2169495",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137265",
              "status": "PAID",
              "totalAmount": "5.24"
            }
          }
        },
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
          "id": "2169496",
          "tpaextensions": {
            "orderInfo": {
              "action": "CHANGE_NAME",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137266",
              "status": "PAID",
              "totalAmount": "0.00"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-27T08:13:57.000Z",
    "emdinfo": []
  },
  "airBookModifyRQ": {
    "modificationType": "2",
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "QA2"
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
            },
            {
              "phoneTechType": "5",
              "phoneNumber": "78945612"
            }
          ],
          "email": [
            {
              "value": "qa2@example.com"
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
      "specialReqDetails": []
    }
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
  "airReservation": {
    "ticketing": [],
    "bookingReferenceID": [
      {
        "companyName": {
          "value": "",
          "code": "DX"
        },
        "type": "14",
        "id": "AVJQY2",
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
          "id": "2169495",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137265",
              "status": "PAID",
              "totalAmount": "5.24"
            }
          }
        },
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
          "id": "2169496",
          "tpaextensions": {
            "orderInfo": {
              "action": "CHANGE_NAME",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137266",
              "status": "PAID",
              "totalAmount": "0.00"
            }
          }
        },
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
          "id": "2169499",
          "tpaextensions": {
            "orderInfo": {
              "action": "OTHER",
              "currencyCode": "USD",
              "direction": "REFUND",
              "orderType": "BOOKING",
              "status": "PENDING",
              "totalAmount": "5.24"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-27T08:13:57.000Z",
    "emdinfo": []
  },
  "success": {},
  "timeStamp": "2025-11-27T08:21:53.352Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>
</details>

## Cancel Specific Segments

For multi-segment bookings, cancel individual flights.

### Request Format

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirBookModifyRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @AirBookModifyRQ.json
```

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": "{pos}",
  "airReservation": "{airReservation}",
  "airBookModifyRQ": {
    "modificationType": "10",
    "airItinerary": "{airItinerary}"
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
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "AAC",
                  "terminal": "1A"
                },
                "arrivalAirport": {
                  "locationCode": "AAL",
                  "terminal": "2B"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "DX",
                  "flightNumber": "7878"
                },
                "equipment": [],
                "departureDateTime": "2025-12-29T10:00:00.000+02:00",
                "arrivalDateTime": "2025-12-29T12:00:00.000+01:00",
                "stopQuantity": 0,
                "rph": "1",
                "marketingAirline": {
                  "value": "",
                  "code": "DX"
                },
                "flightNumber": "7878",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YID",
                  "fareRule": {
                    "code": "ID",
                    "name": "${[en]:pricing.farerules.general.name.ID}",
                    "value": "Test ID fare"
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
            "amount": 0.00
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "value": "",
                "taxCode": "MI",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.76
              }
            ]
          },
          "fees": {
            "fee": [
              {
                "value": "",
                "feeCode": "VAT_MI",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "VAT_reservation",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 0.00
              },
              {
                "value": "",
                "feeCode": "reservation",
                "currencyCode": "USD",
                "decimalPlaces": 2,
                "amount": 4.48
              }
            ]
          },
          "totalFare": {
            "currencyCode": "USD",
            "amount": 5.24
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
                  "value": "YID"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 0.00
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "value": "",
                      "taxCode": "MI",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.76
                    }
                  ]
                },
                "fees": {
                  "fee": [
                    {
                      "value": "",
                      "feeCode": "VAT_MI",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "VAT_reservation",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 0.00
                    },
                    {
                      "value": "",
                      "feeCode": "reservation",
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 4.48
                    }
                  ]
                },
                "totalFare": {
                  "currencyCode": "USD",
                  "decimalPlaces": 2,
                  "amount": 5.24
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
              "value": "qa@example.com"
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
          }
        }
      ]
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketTimeLimit": "2025-11-27T08:59:29.000Z",
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [],
        "travelerRefNumber": [],
        "miscTicketingCode": []
      }
    ],
    "bookingReferenceID": [
      {
        "companyName": {
          "value": "",
          "code": "DX"
        },
        "type": "14",
        "id": "I27YLF",
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
          "id": "2169500",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PENDING",
              "totalAmount": "5.24"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-27T08:29:29.000Z",
    "emdinfo": []
  },
  "airBookModifyRQ": {
    "modificationType": "10",
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "AAC",
                  "terminal": "1A"
                },
                "arrivalAirport": {
                  "locationCode": "AAL",
                  "terminal": "2B"
                },
                "operatingAirline": {
                  "value": "",
                  "code": "DX",
                  "flightNumber": "7878"
                },
                "equipment": [],
                "departureDateTime": "2025-12-29T10:00:00.000+02:00",
                "arrivalDateTime": "2025-12-29T12:00:00.000+01:00",
                "stopQuantity": 0,
                "rph": "1",
                "marketingAirline": {
                  "value": "",
                  "code": "DX"
                },
                "flightNumber": "7878",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30",
                "tpaextensions": {
                  "fareBasis": "YID",
                  "fareRule": {
                    "code": "ID",
                    "name": "${[en]:pricing.farerules.general.name.ID}",
                    "value": "Test ID fare"
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
    }
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
  "airReservation": {
    "ticketing": [],
    "bookingReferenceID": [
      {
        "companyName": {
          "value": "",
          "code": "DX"
        },
        "type": "14",
        "id": "I27YLF",
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
          "id": "2169500",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "USD",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "paymentTransactionId": "2137268",
              "status": "PAID",
              "totalAmount": "5.24"
            }
          }
        },
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
          "id": "2169503",
          "tpaextensions": {
            "orderInfo": {
              "action": "OTHER",
              "currencyCode": "USD",
              "direction": "REFUND",
              "orderType": "BOOKING",
              "status": "PENDING",
              "totalAmount": "5.24"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-27T08:29:29.000Z",
    "emdinfo": []
  },
  "success": {},
  "timeStamp": "2025-11-27T08:33:27.999Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>
</details>

