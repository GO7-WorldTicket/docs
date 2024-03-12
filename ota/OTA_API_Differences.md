
# OTA API Request and Response Differences

## Table of Contents

- [Change Log](#change-log)
- [Introduction](#introduction)
- [OTA Request](#ota-requests)
    - [Agent Identification](#agent-identification)
      - [Contact Validation](#contact-validation)
      - [Traveller Validation](#traveller-validation)
- [OTA Response](#ota-responses)
    - [Multiple BookingReferenceIDs](#multiple-bookingreferenceids)
    - [Ticketing Time Limit](#ticketing-time-limit)
- [Differences Highlighted](#differences-highlighted)
    - [Request vs. Response](#request-vs-response)
    - [Common Pitfalls](#common-pitfalls)

- [Request Examples](#request-examples)
    - [AirLowFareSearchRQ](#airlowfaresearchrq)
    - [AirBook](#airbookrq)
    - [AirPrice](#airpricerq)
    - [AirModify](#airmodifyrq)
    - [AirRead](#airreadrq)

- [OTA Message Samples](#ota-message-samples)

## Change Log
| Change Description               | Changed By          | Change Date |
|----------------------------------|---------------------|-------------|
| Initial creation of the document | Sergii Poltarak     | 2024-03-01  |
| Updated birthdate document       | Sittiwet Mahapratom | 2024-03-12  |


# Introduction

This document aims to clarify the differences between request and response formats within the OTA API, emphasizing key fields and structures to ensure effective communication with the API.

# OTA Requests

## Agent Identification

Every OTA request must include `agentID` and `agencyID` to identify the agent working with the OTA API. This information can be configured under the `pos/source/requestorID`(PointOfSale) in every OTA request.

```json
{
  "pos": {
    "source": [
      {
        "bookingChannel": {
          "type": "OTA"
        },
        "isocurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "<agentID>",
          "name": "<agencyID>"
        }
      }
    ]
  }
}
```

### Traveller Validation

#### Required Fields for traveller information: `givenName`, `surname`, `email`, `date of birth`, `nationality`, and unique `rph`.

```json
{
  "personName": {
    "namePrefix": [ "MISS" ],
    "givenName": [ "PAXONE" ],
    "surname": "TEST"
  },
  "telephone": [],
  "email": [
    { "value": "kmuangsamai@go7.io" }
  ],
  "document": [
    {
      "docHolderNationality": "TH",
      "docID": "987654321",
      "expireDate": "2027-12-12",
      "birthDate": "1979-01-01",
      "docType": "2"
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
  "passengerTypeCode": "ADT",
  "gender": "Male"
}
```

When issuing tickets through an HHR system, it's imperative to include detailed passenger information in the document such as `date of birth`, `nationality`, `expireDate`.

| OTA Request     | JSON Path                                           |
|-----------------|-----------------------------------------------------|
| AirBookRQ       | `/travelerInfo/airTraveler`                         |
| AirBookModifyRQ | `/airBookModifyRQ/travelerInfo/airTraveler`         |
| AirPriceRQ      | `/travelerInfoSummary/airTravelerAvail/airTraveler` |


```json
{
  "document": [
    {
      "docHolderNationality": "TH",
      "docID": "0123456789",
      "expireDate": "2027-12-12",
      "birthDate": "1979-01-01",
      "docType": "2"
    }
  ]
}
```

### Contact Validation

Applies to: 

* AirPriceRQ
* AirBookRQ
* AirBookModifyRQ (Optional) 

#### Required Fields for contact information: `givenName`, `surname`, `email`, `date of birth`, `nationality`.

```json
{
  "airTraveler": {
    "passengerTypeCode": "CTC",
    "personName": {
      "givenName": ["John"],
      "surname": "Doe"
    },
    "email": [
      { "value": "kmuangsamai@go7.io" }
    ],
    "telephone": [
      {
        "countryAccessCode": "380",
        "phoneNumber": "671234567"
      }
    ],
    "document": [
      {
        "docHolderNationality": "TH",
        "docID": "0123456789",
        "expireDate": "2027-12-12",
        "birthDate": "1979-01-01",
        "docType": "2"
      }
    ]
  }
}
```


### Ticketing Time Limit

The `ticketTimeLimit` field in responses retains its ISO date format but now includes a local time offset instead of being in strict UTC time. This change allows for a more precise representation of time zones.

**Before**
```json
{
  "ticketTimeLimit": "2024-02-29T07:25:24.045Z"
}
```

**After**
```json
{
  "ticketTimeLimit": "2024-02-29T10:36:58.000+03:00"
}
```

# OTA Responses

## Key Points

### Multiple BookingReferenceIDs

The response can include multiple `BookingReferenceIDs` both GO7 and HHR, reflecting the unique identifiers for each booking made or queried.

```json
{
  "bookingReferenceID": [
    {
      "companyName": {
        "code": "W1"
      },
      "type": "14",
      "id": "ADECSP"
    },
    {
      "companyName": {
        "code": "HHR"
      },
      "type": "14",
      "id": "1DFCDA373"
    }
  ]
}
```

### PTC FareBreakdown By passengerType

In `AirLowFareSearchRS`, the PTC Fare Breakdown is now grouped by passenger type and not have individual price breakdown anymore. 
This is how price breakdown is reported by HHR system. 

Please note, `quantity` field in the sample having value 2. It was always 1 before.

```json
{
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
              "value": "ApplPayGreater",
              "flightSegmentRPH": "1"
            }
          ]
        },
        "passengerFare": [
          {
            "baseFare": {
              "currencyCode": "SAR",
              "amount": 4.0
            },
            "equivFare": [],
            "fees": {
              "fee": [
                {
                  "feeCode": "FE1",
                  "amount": 30.0
                },
                {
                  "feeCode": "VAT_TOTAL",
                  "amount": 5.1
                }
              ],
              "currencyCode": "SAR",
              "amount": 35.1
            },
            "totalFare": {
              "currencyCode": "SAR",
              "amount": 39.1
            },
            "fareBaggageAllowance": [],
            "remark": []
          }
        ],
        "travelerRefNumber": [],
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "ApplPayGreater",
                "resBookDesigCode": "Y",
                "accountCode": "ApplPayGreater"
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
          "quantity": 1
        },
        "fareBasisCodes": {
          "fareBasisCode": [
            {
              "value": "ApplPayGreater",
              "flightSegmentRPH": "1"
            }
          ]
        },
        "passengerFare": [
          {
            "baseFare": {
              "currencyCode": "SAR",
              "amount": 1.0
            },
            "equivFare": [],
            "fees": {
              "fee": [
                {
                  "feeCode": "FE1",
                  "amount": 15.0
                },
                {
                  "feeCode": "VAT_TOTAL",
                  "amount": 2.40
                }
              ],
              "currencyCode": "SAR",
              "amount": 17.40
            },
            "totalFare": {
              "currencyCode": "SAR",
              "amount": 18.4
            },
            "fareBaggageAllowance": [],
            "remark": []
          }
        ],
        "travelerRefNumber": [],
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "ApplPayGreater",
                "resBookDesigCode": "Y",
                "accountCode": "ApplPayGreater"
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
}
```

# Differences Highlighted

## Request vs. Response

- Requests require specific authentication details (`agentID` and `agencyID`) and, in certain operations like ticket issuance, detailed passenger information.
- Responses uniquely feature multiple `BookingReferenceIDs` for operations involving more than one booking and include specific formatting for `ticketTimeLimit`.
- Responses in AirLowFareSearch (AirLowFareSearchRS), the PTC Fare Breakdown is now organized by passenger type instead of by passenger number.

## Common Pitfalls

- Omitting `agentID` and `agencyID` in requests can lead to input validation errors.
- Omitting required documents in requests can lead to input validation errors.
- Misinterpreting the `ticketTimeLimit` format in responses might result in incorrect handling of booking time limits.
- Failing to provide comprehensive passenger details when issuing tickets can cause transaction failures.
---

# OTA Message Samples

## AirLowFareSearch for one-way trip

### AirLowFareSearchRQ

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
          "id": "<agentID>",
          "name": "<agencyID>"
        }
      }
    ]
  },
  "processingInfo": {
    "displayOrder": "BY_PRICE_LOW_TO_HIGH",
    "availabilityIndicator": true
  },
  "originDestinationInformation": [
    {
      "originLocation": {
        "locationCode": "MKX"
      },
      "destinationLocation": {
        "locationCode": "DMX"
      },
      "departureDateTime": {
        "value": "2024-04-15",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    }
  ],
  "specificFlightInfo": {
    "bookingClassPref": [
      {
        "resBookDesigCode": "Y"
      }
    ]
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 5
          },
          {
            "code": "CHD",
            "quantity": 2
          },
          {
            "code": "INF",
            "quantity": 0
          }
        ]
      }
    ]
  }
}
```

## Make a one-way booking

### AirBookRQ

This section is dedicated to the OTA_AirBook function, which handles booking operations within the OTA API. Here, you'll find the required fields and structure for making a regular booking request.
We require to provide the CTC and document information.

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
          "id": "<agentID>",
          "name": "<agencyID>"
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
              "departureAirport": {
                "locationCode": "MKX"
              },
              "arrivalAirport": {
                "locationCode": "DMX"
              },
              "operatingAirline": {
                "code": "HHR",
                "flightNumber": "0080"
              },
              "equipment": [],
              "departureDateTime": "2024-04-19T09:00:00.000+03:00",
              "arrivalDateTime": "2024-04-19T11:25:00.000+03:00",
              "rph": "1",
              "marketingAirline": {
                "code": "HHR"
              },
              "flightNumber": "0080",
              "fareBasisCode": "ApplPayGreater",
              "resBookDesigCode": "Y",
              "status": "30"
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
            "QA"
          ],
          "middleName": [
            "TEST"
          ],
          "surname": "TESTER"
        },
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "address": [
          {
            "cityName": "Makkha",
            "countryName": {
              "value": "",
              "code": "SA"
            }
          }
        ]
      },
      {
        "personName": {
          "namePrefix": [
            "MISS"
          ],
          "givenName": [
            "PAXONE"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
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
        "passengerTypeCode": "ADT",
        "gender": "Male"
      },
      {
        "personName": {
          "namePrefix": [
            "MISS"
          ],
          "givenName": [
            "PAXTWO"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
          }
        ],
        "travelerRefNumber": {
          "rph": "2"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "1"
          ]
        },
        "passengerTypeCode": "ADT",
        "gender": "Male"
      },
      {
        "personName": {
          "namePrefix": [
            "MR"
          ],
          "givenName": [
            "PAXTHREE"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
          }
        ],
        "travelerRefNumber": {
          "rph": "3"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "1"
          ]
        },
        "passengerTypeCode": "ADT",
        "gender": "Male"
      }
    ]
  }
}
```

## Make a group booking

### AirPriceRQ

In the OTA_AirPrice section, we detail the necessary fields and structure for a group booking creation.
We require to provide the CTC and document information.

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
          "id": "<agentID>",
          "name": "<agencyID>"
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
              "departureAirport": {
                "locationCode": "MKX"
              },
              "arrivalAirport": {
                "locationCode": "DMX"
              },
              "operatingAirline": {
                "code": "HHR",
                "flightNumber": "0080"
              },
              "equipment": [],
              "departureDateTime": "2024-04-19T09:00:00.000+03:00",
              "arrivalDateTime": "2024-04-19T11:25:00.000+03:00",
              "rph": "1",
              "marketingAirline": {
                "code": "HHR"
              },
              "flightNumber": "0080",
              "fareBasisCode": "ApplPayGreater",
              "resBookDesigCode": "Y",
              "status": "30"
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
            "QA"
          ],
          "middleName": [
            "TEST"
          ],
          "surname": "TESTER"
        },
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "address": [
          {
            "cityName": "Makkha",
            "countryName": {
              "value": "",
              "code": "SA"
            }
          }
        ]
      },
      {
        "personName": {
          "namePrefix": [
            "MISS"
          ],
          "givenName": [
            "PAXONE"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
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
        "passengerTypeCode": "ADT",
        "gender": "Male"
      },
      {
        "personName": {
          "namePrefix": [
            "MISS"
          ],
          "givenName": [
            "PAXTWO"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
          }
        ],
        "travelerRefNumber": {
          "rph": "2"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "1"
          ]
        },
        "passengerTypeCode": "ADT",
        "gender": "Male"
      },
      {
        "personName": {
          "namePrefix": [
            "MR"
          ],
          "givenName": [
            "PAXTHREE"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "email": [
          {
            "value": "test@go7.io"
          }
        ],
        "document": [
          {
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12",
            "birthDate": "1979-01-01"
          }
        ],
        "travelerRefNumber": {
          "rph": "3"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "1"
          ]
        },
        "passengerTypeCode": "ADT",
        "gender": "Male"
      }
    ]
  }
}
```
## AirDemandRQ
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
          "id": "<agentID>",
          "name": "<agencyID>"
        }
      }
    ]
  },
  "demandTicketDetail": {
    "messageFunction": [
      {
        "function": "ET"
      }
    ],
    "bookingReferenceID": {
      "id": "ADECSP",
      "type": "14",
      "companyName": {
        "code": "test-skywork-dev",
        "companyShortName": "test-skywork-dev"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "4",
        "creditCardInfo": [
          {
            "cardHolderName": "admin-account"
          }
        ]
      }
    ]
  }
}
```
## AirModifyRQ
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
          "id": "<agentID>",
          "name": "<agencyID>"
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
                  "locationCode": "DMX"
                },
                "operatingAirline": {
                  "code": "HHR",
                  "flightNumber": "0080"
                },
                "equipment": [],
                "departureDateTime": "2024-04-11T09:00:00.000+03:00",
                "arrivalDateTime": "2024-04-11T11:25:00.000+03:00",
                "rph": "1",
                "marketingAirline": {
                  "code": "HHR"
                },
                "flightNumber": "0080",
                "fareBasisCode": "ApplPayGreater",
                "resBookDesigCode": "Y",
                "bookingClassAvails": [],
                "comment": [],
                "stopLocation": [],
                "status": "30"
              }
            ],
            "rph": "1"
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
              "QA TEST"
            ],
            "middleName": [],
            "surname": "TESTER",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io",
              "defaultInd": true
            }
          ],
          "address": [
            {
              "bldgRoom": [],
              "addressLine": [],
              "cityName": "Makkha",
              "countryName": {
                "code": "SA"
              }
            }
          ],
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
              "PAXONE"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "1979-01-01"
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
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "PAXTWO"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "1979-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
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
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "PAXTHREE"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2017-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
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
              "PAXFOUR"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2024-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "socialMediaInfo": [],
          "passengerTypeCode": "INF",
          "gender": "Male",
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
              "PAXFIVE"
            ],
            "middleName": [],
            "surname": "TEST",
            "nameSuffix": [],
            "nameTitle": []
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "address": [],
          "custLoyalty": [],
          "document": [
            {
              "docLimitations": [],
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2024-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
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
    "bookingReferenceID": [
      {
        "type": "14",
        "id": "SPTAOZ",
        "flightRefNumberRPHList": []
      }
    ],
    "createDateTime": "2024-02-22T00:00:00.0000",
    "emdinfo": []
  },
  "airBookModifyRQ": {
    "modificationType": "3",
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "PETER"
            ],
            "surname": "PARKER"
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "document": [
            {
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "1979-01-01"
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
          "passengerTypeCode": "ADT",
          "gender": "Male"
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ROSE"
            ],
            "surname": "PARKER"
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "document": [
            {
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "1979-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "passengerTypeCode": "ADT",
          "gender": "Male"
        },
        {
          "personName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "SANDRA"
            ],
            "surname": "PARKER"
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "document": [
            {
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2017-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "passengerTypeCode": "CHD",
          "gender": "Female"
        },
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "OKAN"
            ],
            "surname": "PARKER"
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "document": [
            {
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2024-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "passengerTypeCode": "INF",
          "gender": "Male",
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
              "NADIA"
            ],
            "surname": "PARKER"
          },
          "telephone": [
            {
              "countryAccessCode": "380",
              "phoneNumber": "671234567"
            }
          ],
          "email": [
            {
              "value": "test@go7.io"
            }
          ],
          "document": [
            {
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12",
              "birthDate": "2024-01-01"
            }
          ],
          "travelerRefNumber": {
            "rph": "5"
          },
          "flightSegmentRPHs": {
            "flightSegmentRPH": [
              "1"
            ]
          },
          "passengerTypeCode": "INF",
          "gender": "Female",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        }
      ]
    }
  }
}
```
## AirReadRQ
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
          "id": "<agentID>",
          "name": "<agencyID>"
        }
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "C2DRRC",
          "type": "14"
        }
      }
    ]
  }
}
```
