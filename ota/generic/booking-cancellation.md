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
  "echoToken": "{echo_token}",
  "timeStamp": "{timestamp}",
  "target": "Production",
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "erSPUserID": "{ersp_user_id}",
        "agentSine": "{agent_sine}",
        "pseudoCityCode": "{pseudo_city_code}",
        "isocountry": "{iso_country}",
        "isoCurrency": "{iso_currency}",
        "airlineVendorID": "{airline_vendor_id}",
        "requestorID": {
          "type": "5",
          "id": "{requestor_id}"
        },
        "bookingChannel": {
          "type": "COM"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "idContext": "{airline_code}"
  },
  "verification": {
    "personName": {
      "surname": "{passenger_last_name}"
    }
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
  "echoToken": "36732",
  "timeStamp": "2003-11-14T10:30:00",
  "target": "Production",
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "erSPUserID": "1#Preved",
        "agentSine": "2BB",
        "pseudoCityCode": "ATL",
        "isocountry": "US",
        "isoCurrency": "EUR",
        "airlineVendorID": "1P",
        "requestorID": {
          "type": "5",
          "id": "35896241"
        },
        "bookingChannel": {
          "type": "COM"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "11XS4L",
    "idContext": "EK"
  },
  "verification": {
    "personName": {
      "surname": "WorldTicket"
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
  "version": "2.001",
  "success": {},
  "uniqueID": {
    "type": "14",
    "id": "11XS4L"
  }
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
    "travelerInfo": "{travelerInfo}",
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
        "isocurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "umrahme",
          "name": "umrahme"
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
                  "locationCode": "MKX"
                },
                "arrivalAirport": {
                  "locationCode": "JXD"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-14T15:00:00.000+03:00",
                "arrivalDateTime": "2025-11-14T15:30:00.000+03:00",
                "rph": "1",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "1"
          },
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "JXD"
                },
                "arrivalAirport": {
                  "locationCode": "MKX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0081"
                },
                "equipment": [],
                "departureDateTime": "2025-11-15T10:21:00.000+03:00",
                "arrivalDateTime": "2025-11-15T10:55:00.000+03:00",
                "rph": "2",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0081",
                "fareBasisCode": "EELMOWX",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "2"
          }
        ]
      }
    },
    "priceInfo": {
      "itinTotalFare": [
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 270
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 40.5
              }
            ],
            "amount": 40.5
          },
          "fees": {
            "fee": [
              {
                "feeCode": "VAT_VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 310.5
          },
          "fareBaggageAllowance": [],
          "remark": []
        }
      ],
      "fareInfos": {
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "confirmationTimeLimit": "2025-11-07T23:22:02Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "MKX"
            },
            "arrivalAirport": {
              "locationCode": "JXD"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "1"
          },
          {
            "fareReference": [
              {
                "value": "EELMOWX",
                "resBookDesigCode": "Y",
                "accountCode": "EELMOWX"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "confirmationTimeLimit": "2025-11-07T23:22:02Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "JXD"
            },
            "arrivalAirport": {
              "locationCode": "MKX"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "2"
          }
        ]
      },
      "ptcfareBreakdowns": {
        "ptcfareBreakdown": [
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EELMOWX",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 80
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 12
                    }
                  ],
                  "amount": 12
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 92
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EELMOWX",
                    "resBookDesigCode": "Y",
                    "accountCode": "EELMOWX"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EELMOWX",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 40
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 6
                    }
                  ],
                  "amount": 6
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 46
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EELMOWX",
                    "resBookDesigCode": "Y",
                    "accountCode": "EELMOWX"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EELMOWX",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EELMOWX",
                    "resBookDesigCode": "Y",
                    "accountCode": "EELMOWX"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
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
            "namePrefix": [],
            "givenName": [
              "CHRISTINE JLO"
            ],
            "middleName": [],
            "surname": "SMITH",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [
            {
              "value": "kmuangsamai@go7.io",
              "defaultInd": true
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [],
          "socialMediaInfo": [],
          "passengerTypeCode": "CTC",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "LELEM56682972",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-03-30",
              "expireDate": "2027-03-28"
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
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "MARY"
            ],
            "middleName": [],
            "surname": "THOMSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "UAKOK30394541",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "1988-03-31",
              "expireDate": "2027-03-29"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "ROBERTSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "UFLQV92202652",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-01",
              "expireDate": "2027-03-30"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PATRICIA"
            ],
            "middleName": [],
            "surname": "ANDERSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "EWLUS71386471",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-02",
              "expireDate": "2027-03-31"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Male",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "LINDA"
            ],
            "middleName": [],
            "surname": "SCOTT",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "LSDHZ40228259",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-03",
              "expireDate": "2027-04-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "BARBARA BROWN"
            ],
            "middleName": [],
            "surname": "TAYLOR",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "EL00294174",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-04",
              "expireDate": "2027-04-02"
            }
          ],
          "travelerRefNumber": {
            "rph": "6"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "2",
              "name": "attendantRph"
            }
          ]
        }
      ],
      "specialReqDetails": []
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketTimeLimit": "2025-11-08T02:22:02.000+03:00",
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [],
        "miscTicketingCode": []
      },
      {
        "ticketAdvisory": [],
        "ticketTimeLimit": "2025-11-08T02:22:02.000+03:00",
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "2"
        ],
        "travelerRefNumber": [],
        "miscTicketingCode": []
      }
    ],
    "bookingReferenceID": [
      {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "FWABD8",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "E043C368C",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "4B921A032",
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
          "id": "2157732",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "SAR",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PENDING",
              "totalAmount": "310.50"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-07T22:52:04.022Z",
    "emdinfo": []
  },
  "airBookModifyRQ": {
    "modificationType": "2",
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [],
            "givenName": [
              "CHRISTINE JLO"
            ],
            "middleName": [],
            "surname": "SMITH",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [
            {
              "value": "kmuangsamai@go7.io",
              "defaultInd": true
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [],
          "socialMediaInfo": [],
          "passengerTypeCode": "CTC",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JEVTO37671982",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-03-30",
              "expireDate": "2027-03-28"
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
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "MARY"
            ],
            "middleName": [],
            "surname": "THOMSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZJGBN88395473",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "1988-03-31",
              "expireDate": "2027-03-29"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "ROBERTSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "HOLYV75024990",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-01",
              "expireDate": "2027-03-30"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PATRICIA"
            ],
            "middleName": [],
            "surname": "ANDERSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "MZBDN22890087",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-02",
              "expireDate": "2027-03-31"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Male",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "LINDA"
            ],
            "middleName": [],
            "surname": "SCOTT",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZPUPH74350708",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-03",
              "expireDate": "2027-04-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "BARBARA BROWN"
            ],
            "middleName": [],
            "surname": "TAYLOR",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JMNZW52049763",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-04",
              "expireDate": "2027-04-02"
            }
          ],
          "travelerRefNumber": {
            "rph": "6"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "2",
              "name": "attendantRph"
            }
          ]
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
  "success": {},
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "MKX"
                },
                "arrivalAirport": {
                  "locationCode": "JXD"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-14T15:00:00.000+03:00",
                "arrivalDateTime": "2025-11-14T15:30:00.000+03:00",
                "rph": "1",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "1"
          },
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "JXD"
                },
                "arrivalAirport": {
                  "locationCode": "MKX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0081"
                },
                "equipment": [],
                "departureDateTime": "2025-11-15T10:21:00.000+03:00",
                "arrivalDateTime": "2025-11-15T10:55:00.000+03:00",
                "rph": "2",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0081",
                "fareBasisCode": "EELMOWX",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "16"
              }
            ],
            "rph": "2"
          }
        ]
      }
    },
    "priceInfo": {
      "itinTotalFare": [
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 270
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 40.5
              }
            ],
            "amount": 40.5
          },
          "fees": {
            "fee": [
              {
                "feeCode": "VAT_VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 310.5
          },
          "fareBaggageAllowance": [],
          "remark": []
        },
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 0
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "fees": {
            "fee": [
              {
                "feeCode": "REFUND_PENALTY",
                "feeTransactionType": "charge",
                "currencyCode": "SAR",
                "amount": 80
              },
              {
                "feeCode": "REFUND_PENALTY_VAT",
                "feeTransactionType": "charge",
                "currencyCode": "SAR",
                "amount": 12
              }
            ],
            "currencyCode": "SAR",
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 0
          },
          "fareBaggageAllowance": [],
          "remark": [],
          "usage": "refund"
        }
      ],
      "fareInfos": {
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:22:02Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "MKX"
            },
            "arrivalAirport": {
              "locationCode": "JXD"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "1"
          },
          {
            "fareReference": [
              {
                "value": "EELMOWX",
                "resBookDesigCode": "Y",
                "accountCode": "EELMOWX"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:22:02Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "JXD"
            },
            "arrivalAirport": {
              "locationCode": "MKX"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "2"
          }
        ]
      },
      "ptcfareBreakdowns": {
        "ptcfareBreakdown": [
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
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
            "namePrefix": [],
            "givenName": [
              "CHRISTINE JLO"
            ],
            "middleName": [],
            "surname": "SMITH",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [
            {
              "value": "kmuangsamai@go7.io",
              "defaultInd": true
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [],
          "socialMediaInfo": [],
          "passengerTypeCode": "CTC",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "LELEM56682972",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-03-30",
              "expireDate": "2027-03-28"
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
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZLGBN88395473",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2021-05-15",
              "expireDate": "2029-05-13"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "KATE JESSICA"
            ],
            "middleName": [],
            "surname": "SMITH",
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
              "docID": "XMHCN77284362",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2019-01-10",
              "expireDate": "2028-01-08"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MASTER"
            ],
            "givenName": [
              "JOHN DAVID"
            ],
            "middleName": [],
            "surname": "STEWART",
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
              "docID": "PNMKO99173251",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2020-07-22",
              "expireDate": "2029-07-20"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Male",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [],
            "givenName": [
              "BABY SARAH"
            ],
            "middleName": [],
            "surname": "SMITH",
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
              "docID": "JKDSO88273919",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2024-03-15",
              "expireDate": "2034-03-13"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [],
            "givenName": [
              "BABY RICHARD"
            ],
            "middleName": [],
            "surname": "STEWART",
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
              "docID": "MWHDK77162808",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2024-11-01",
              "expireDate": "2034-10-30"
            }
          ],
          "travelerRefNumber": {
            "rph": "6"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "comment": []
        }
      ],
      "purchased": []
    }
  }
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
    "airItinerary": "{airItinerary}",
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
        "isocurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "umrahme",
          "name": "umrahme"
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
                  "locationCode": "MKX"
                },
                "arrivalAirport": {
                  "locationCode": "JXD"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-14T15:00:00.000+03:00",
                "arrivalDateTime": "2025-11-14T15:30:00.000+03:00",
                "rph": "1",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "1"
          },
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "JXD"
                },
                "arrivalAirport": {
                  "locationCode": "MKX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "1121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-15T14:15:00.000+03:00",
                "arrivalDateTime": "2025-11-15T14:50:00.000+03:00",
                "rph": "2",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "1121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "2"
          }
        ]
      }
    },
    "priceInfo": {
      "itinTotalFare": [
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 300
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 45
              }
            ],
            "amount": 45
          },
          "fees": {
            "fee": [
              {
                "feeCode": "VAT_VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 345
          },
          "fareBaggageAllowance": [],
          "remark": []
        }
      ],
      "fareInfos": {
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:23:36Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "MKX"
            },
            "arrivalAirport": {
              "locationCode": "JXD"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "1"
          },
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:23:36Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "JXD"
            },
            "arrivalAirport": {
              "locationCode": "MKX"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "2"
          }
        ]
      },
      "ptcfareBreakdowns": {
        "ptcfareBreakdown": [
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
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
            "namePrefix": [],
            "givenName": [
              "CHRISTINE JLO"
            ],
            "middleName": [],
            "surname": "SMITH",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [
            {
              "value": "kmuangsamai@go7.io",
              "defaultInd": true
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [],
          "socialMediaInfo": [],
          "passengerTypeCode": "CTC",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JEVTO37671982",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-03-30",
              "expireDate": "2027-03-28"
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
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "MARY"
            ],
            "middleName": [],
            "surname": "THOMSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZJGBN88395473",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "1988-03-31",
              "expireDate": "2027-03-29"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "ROBERTSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "HOLYV75024990",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-01",
              "expireDate": "2027-03-30"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PATRICIA"
            ],
            "middleName": [],
            "surname": "ANDERSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "MZBDN22890087",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-02",
              "expireDate": "2027-03-31"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Male",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "LINDA"
            ],
            "middleName": [],
            "surname": "SCOTT",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZPUPH74350708",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-03",
              "expireDate": "2027-04-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "BARBARA BROWN"
            ],
            "middleName": [],
            "surname": "TAYLOR",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JMNZW52049763",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-04",
              "expireDate": "2027-04-02"
            }
          ],
          "travelerRefNumber": {
            "rph": "6"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "2",
              "name": "attendantRph"
            }
          ]
        }
      ],
      "specialReqDetails": []
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "1"
        ],
        "ticketDocumentNbr": "3333330399829",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "0153363529066212",
              "seat": "340"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153364229066209",
              "seat": "114"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "1"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "1"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=2"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "2"
        ],
        "ticketDocumentNbr": "3333330399830",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336E9C9066214",
              "seat": "341"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153366039066210",
              "seat": "115"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "2"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "2"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=2"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "3"
        ],
        "ticketDocumentNbr": "3333330399831",
        "passengerTypeCode": "CHD",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "012",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336BBB9066217",
              "seat": "342"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "015336BCB9066211",
              "seat": "116"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "3"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "3"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=2"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "4"
        ],
        "ticketDocumentNbr": "3333330399832",
        "passengerTypeCode": "CHD",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "012",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336EE29066218",
              "seat": "343"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153369809066213",
              "seat": "117"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "4"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "4"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=2"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "5"
        ],
        "ticketDocumentNbr": "3333330399833",
        "passengerTypeCode": "INF",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "0153363529066219",
              "seat": "340"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153364229066215",
              "seat": "114"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "5"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "5"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=2"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "6"
        ],
        "ticketDocumentNbr": "3333330399834",
        "passengerTypeCode": "INF",
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
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336E9C9066220",
              "seat": "341"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153366039066216",
              "seat": "115"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "6"
            },
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=2",
              "rel": "downloadTicket",
              "segmentRPH": "2",
              "travelerRPH": "6"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=2"
        }
      }
    ],
    "bookingReferenceID": [
      {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "HLY2GI",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "72CCAC455",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "F392C20FF",
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
          "id": "2157738",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "SAR",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PAID",
              "totalAmount": "345.00"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-07T22:53:37.832Z",
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
                  "locationCode": "JXD"
                },
                "arrivalAirport": {
                  "locationCode": "MKX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "1121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-15T14:15:00.000+03:00",
                "arrivalDateTime": "2025-11-15T14:50:00.000+03:00",
                "rph": "2",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "1121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "2"
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
  "success": {},
  "airReservation": {
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "MKX"
                },
                "arrivalAirport": {
                  "locationCode": "JXD"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-14T15:00:00.000+03:00",
                "arrivalDateTime": "2025-11-14T15:30:00.000+03:00",
                "rph": "1",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "1"
          },
          {
            "flightSegment": [
              {
                "departureAirport": {
                  "locationCode": "JXD"
                },
                "arrivalAirport": {
                  "locationCode": "MKX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "1121"
                },
                "equipment": [],
                "departureDateTime": "2025-11-15T14:15:00.000+03:00",
                "arrivalDateTime": "2025-11-15T14:50:00.000+03:00",
                "rph": "2",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "1121",
                "fareBasisCode": "EWTOWM2",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "16"
              }
            ],
            "rph": "2"
          }
        ]
      }
    },
    "priceInfo": {
      "itinTotalFare": [
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 300
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 45
              }
            ],
            "amount": 45
          },
          "fees": {
            "fee": [
              {
                "feeCode": "VAT_VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 345
          },
          "fareBaggageAllowance": [],
          "remark": []
        },
        {
          "baseFare": {
            "currencyCode": "SAR",
            "amount": 0
          },
          "equivFare": [],
          "taxes": {
            "tax": [
              {
                "taxCode": "VAT",
                "currencyCode": "SAR",
                "amount": 0
              }
            ],
            "amount": 0
          },
          "fees": {
            "fee": [
              {
                "feeCode": "REFUND_PENALTY",
                "feeTransactionType": "charge",
                "currencyCode": "SAR",
                "amount": 150
              },
              {
                "feeCode": "REFUND_PENALTY_VAT",
                "feeTransactionType": "charge",
                "currencyCode": "SAR",
                "amount": 22.5
              }
            ],
            "currencyCode": "SAR",
            "amount": 0
          },
          "totalFare": {
            "currencyCode": "SAR",
            "amount": 0
          },
          "fareBaggageAllowance": [],
          "remark": [],
          "usage": "refund"
        }
      ],
      "fareInfos": {
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:23:36Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "MKX"
            },
            "arrivalAirport": {
              "locationCode": "JXD"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "1"
          },
          {
            "fareReference": [
              {
                "value": "EWTOWM2",
                "resBookDesigCode": "Y",
                "accountCode": "EWTOWM2"
              }
            ],
            "ruleInfo": {
              "tpaextensions": {
                "cancellationTimeLimit": "2025-11-12T12:00:00Z",
                "confirmationTimeLimit": "2025-11-07T23:23:36Z",
                "updateTravellersTimeLimit": "2025-11-11T12:00:00Z"
              }
            },
            "filingAirline": {
              "value": "HHR"
            },
            "marketingAirline": [],
            "departureAirport": {
              "locationCode": "JXD"
            },
            "arrivalAirport": {
              "locationCode": "MKX"
            },
            "date": [],
            "fareInfo": [],
            "city": [],
            "airport": [],
            "rph": "2"
          }
        ]
      },
      "ptcfareBreakdowns": {
        "ptcfareBreakdown": [
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "ADT",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 100
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "amount": 15
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 115
                },
                "fareBaggageAllowance": [],
                "remark": []
              },
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "REFUND_PENALTY",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 100
                    },
                    {
                      "feeCode": "REFUND_PENALTY_VAT",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 15
                    }
                  ],
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": [],
                "usage": "refund"
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "1"
              },
              {
                "rph": "2"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "1"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "CHD",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 50
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "amount": 7.5
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "VAT_VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 57.5
                },
                "fareBaggageAllowance": [],
                "remark": []
              },
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "REFUND_PENALTY",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 50
                    },
                    {
                      "feeCode": "REFUND_PENALTY_VAT",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 7.5
                    }
                  ],
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": [],
                "usage": "refund"
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "3"
              },
              {
                "rph": "4"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "2"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              },
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [
                    {
                      "feeCode": "REFUND_PENALTY",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 0
                    },
                    {
                      "feeCode": "REFUND_PENALTY_VAT",
                      "feeTransactionType": "charge",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": [],
                "usage": "refund"
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "2"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
            "pricingUnit": [],
            "flightRefNumberRPHList": [
              "2"
            ]
          },
          {
            "passengerTypeQuantity": {
              "code": "INF",
              "quantity": 2
            },
            "fareBasisCodes": {
              "fareBasisCode": [
                {
                  "value": "EWTOWM2",
                  "flightSegmentRPH": "1"
                }
              ]
            },
            "passengerFare": [
              {
                "baseFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "equivFare": [],
                "taxes": {
                  "tax": [
                    {
                      "taxCode": "VAT",
                      "taxName": "VAT",
                      "currencyCode": "SAR",
                      "amount": 0
                    }
                  ],
                  "amount": 0
                },
                "fees": {
                  "fee": [],
                  "amount": 0
                },
                "totalFare": {
                  "currencyCode": "SAR",
                  "amount": 0
                },
                "fareBaggageAllowance": [],
                "remark": []
              }
            ],
            "travelerRefNumber": [
              {
                "rph": "5"
              },
              {
                "rph": "6"
              }
            ],
            "ticketDesignators": {
              "ticketDesignator": [
                {
                  "flightRefRPH": "1"
                }
              ]
            },
            "fareInfo": [
              {
                "fareReference": [
                  {
                    "value": "EWTOWM2",
                    "resBookDesigCode": "Y",
                    "accountCode": "EWTOWM2"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": []
              }
            ],
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
            "namePrefix": [],
            "givenName": [
              "CHRISTINE JLO"
            ],
            "middleName": [],
            "surname": "SMITH",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [],
          "email": [
            {
              "value": "kmuangsamai@go7.io",
              "defaultInd": true
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [],
          "socialMediaInfo": [],
          "passengerTypeCode": "CTC",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JEVTO37671982",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-03-30",
              "expireDate": "2027-03-28"
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
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "MARY"
            ],
            "middleName": [],
            "surname": "THOMSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZJGBN88395473",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "1988-03-31",
              "expireDate": "2027-03-29"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "ADT",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "ROBERTSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "HOLYV75024990",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-01",
              "expireDate": "2027-03-30"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Female",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PATRICIA"
            ],
            "middleName": [],
            "surname": "ANDERSON",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "MZBDN22890087",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2017-04-02",
              "expireDate": "2027-03-31"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "CHD",
          "gender": "Male",
          "comment": []
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "LINDA"
            ],
            "middleName": [],
            "surname": "SCOTT",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "ZPUPH74350708",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-03",
              "expireDate": "2027-04-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "BARBARA BROWN"
            ],
            "middleName": [],
            "surname": "TAYLOR",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "741852369"
            }
          ],
          "email": [
            {
              "value": "kmuangsamai@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "JMNZW52049763",
              "docType": "5",
              "docHolderNationality": "SA",
              "birthDate": "2023-04-04",
              "expireDate": "2027-04-02"
            }
          ],
          "travelerRefNumber": {
            "rph": "6"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1",
              "2"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "2",
              "name": "attendantRph"
            }
          ]
        }
      ],
      "specialReqDetails": []
    },
    "ticketing": [
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "1"
        ],
        "ticketDocumentNbr": "3333330399829",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "0153363529066212",
              "seat": "340"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153364229066209",
              "seat": "114"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "1"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399829&couponNumber=1"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "2"
        ],
        "ticketDocumentNbr": "3333330399830",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336E9C9066214",
              "seat": "341"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153366039066210",
              "seat": "115"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "2"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399830&couponNumber=1"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "3"
        ],
        "ticketDocumentNbr": "3333330399831",
        "passengerTypeCode": "CHD",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "012",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336BBB9066217",
              "seat": "342"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "015336BCB9066211",
              "seat": "116"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "3"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399831&couponNumber=1"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "4"
        ],
        "ticketDocumentNbr": "3333330399832",
        "passengerTypeCode": "CHD",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "012",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336EE29066218",
              "seat": "343"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153369809066213",
              "seat": "117"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "4"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399832&couponNumber=1"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "5"
        ],
        "ticketDocumentNbr": "3333330399833",
        "passengerTypeCode": "INF",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "0153363529066219",
              "seat": "340"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153364229066215",
              "seat": "114"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "5"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399833&couponNumber=1"
        }
      },
      {
        "ticketAdvisory": [],
        "ticketType": "E_TICKET",
        "flightSegmentRefNumber": [
          "1"
        ],
        "travelerRefNumber": [
          "6"
        ],
        "ticketDocumentNbr": "3333330399834",
        "passengerTypeCode": "INF",
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
              "status": "R"
            }
          ],
          "couponProviderDetails": [
            {
              "coach": "011",
              "flightRefRPH": "1",
              "providerTicketNumber": "015336E9C9066220",
              "seat": "341"
            },
            {
              "coach": "006",
              "flightRefRPH": "2",
              "providerTicketNumber": "0153366039066216",
              "seat": "115"
            }
          ],
          "links": [
            {
              "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=1",
              "rel": "downloadTicket",
              "segmentRPH": "1",
              "travelerRPH": "6"
            }
          ],
          "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/HLY2GI/download/passenger-segment?ticketNumber=3333330399834&couponNumber=1"
        }
      }
    ],
    "bookingReferenceID": [
      {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "HLY2GI",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "72CCAC455",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "F392C20FF",
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
          "id": "2157738",
          "tpaextensions": {
            "orderInfo": {
              "action": "CREATE_BOOKING",
              "currencyCode": "SAR",
              "direction": "PAYMENT",
              "orderType": "BOOKING",
              "status": "PAID",
              "totalAmount": "345.00"
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
          "id": "2157739",
          "tpaextensions": {
            "orderInfo": {
              "action": "OTHER",
              "currencyCode": "SAR",
              "direction": "REFUND",
              "orderType": "BOOKING",
              "status": "PAID",
              "totalAmount": "0.00"
            }
          }
        }
      ],
      "purchased": []
    },
    "createDateTime": "2025-11-07T22:53:37.832Z",
    "emdinfo": []
  },
  "version": 2.001
}
```

</div>
</details>

