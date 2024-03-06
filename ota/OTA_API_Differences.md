
# OTA API Request and Response Differences

## Table of Contents

- [Introduction](#introduction)
- [OTA Requests](#ota-requests)
    - [Agent Identification](#agent-identification)
      - [Contact Validation](#contact-validation)
      - [Traveller Validation](#traveller-validation)
- [OTA Responses](#ota-responses)
    - [Multiple BookingReferenceIDs](#multiple-bookingreferenceids)
    - [Ticketing Time Limit](#ticketing-time-limit)
- [Differences Highlighted](#differences-highlighted)
    - [Request vs. Response](#request-vs-response)
    - [Common Pitfalls](#common-pitfalls)

- [OTA Message Samples](#ota-message-samples)
- - [OTA_AirLowFareSearchRQ](#ota_airlowfaresearchrq)
    - [Search for One-way Trip Options](#search-for-one-way-trip-options) 
    - [Search for Round Trip Options](#search-for-round-trip-options) 
  - [OTA_AirBookRQ](#ota_airbookrq)
    - [Make One-way Booking](#make-one-way-booking)
  - [OTA_AirPriceRQ](#ota_airpricerq)
    - [Make One-way Group Booking in Economy Class](#make-one-way-group-booking-in-economy-class)
    - [Make Round-trip Group Booking in Business Class](#make-round-trip-group-booking-in-business-class)
  - [OTA_AirDemandTicketRQ](#ota_airdemandticketrq)
    - [Pay with debit-credit account](#pay-with-debit-credit-account)
  - [OTA_AirBookModifyRQ](#ota_airbookmodifyrq)
    - [Update Passenger Names in a Group Booking with 2 adults, 1 child, and 1 infant](#update-passenger-names-in-a-group-booking-with-2-adults-1-child-and-1-infant) 
  - [OTA_ReadRQ](#ota_readrq)

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

#### Required Fields for traveller information:  

- `personName.givenName`: first name
- `personName.surname`: last name
- `email.value`: email
- `passengerTypeCode`
- `gender`

```json
{
  "personName": {
    "namePrefix": [ "MISS" ],
    "givenName": [ "ONE" ],
    "surname": "TEST"
  },
  "telephone": [],
  "email": [
    { "value": "test@go7.io" }
  ],
  "document": [
    {
      "birthDate": "1979-01-01",
      "docHolderNationality": "TH",
      "docID": "987654321",
      "expireDate": "2027-12-12",
      "docType": "2"
    }
  ],
  "passengerTypeCode": "ADT",
  "gender": "Male"
}
```

When issuing tickets through an HHR system, it's imperative to provide a passenger document, 
therefore they are required at a time booking is created, except a group booking case.  

- `birthDate`: date of birth
- `docHolderNationality`: nationality
- `docID`: document ID
- `expireDate`: document expire date

| OTA Request     | JSON Path                                           |
|-----------------|-----------------------------------------------------|
| AirBookRQ       | `/travelerInfo/airTraveler`                         |
| AirBookModifyRQ | `/airBookModifyRQ/travelerInfo/airTraveler`         |
| AirPriceRQ      | `/travelerInfoSummary/airTravelerAvail/airTraveler` |


```json
{
  "document": [
    {
      "birthDate": "1979-01-01",
      "docHolderNationality": "TH",
      "docID": "0123456789",
      "expireDate": "2027-12-12",
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

#### Required Fields for Contact Information: 
- `givenName`
- `surname`
- `email`

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
    ]
  }
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

### Fare Breakdown by Passenger Type

In `AirLowFareSearchRS`, the PTC Fare Breakdown is now grouped by passenger type and not have individual price breakdown anymore. 
This is how price breakdown is reported by HHR system. 

Please note, `quantity` field has changed to  2 that corresponds to a number of travellers requested. 
Before each passenger had an individual Fare Breakdown.

**Before:**
```json
{
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
              "value": "YECOSTD"
            }
          ]
        },
        "passengerFare": [
          {
            "baseFare": {
              "currencyCode": "SAR",
              "decimalPlaces": 2,
              "amount": 300.00
            },
            "equivFare": [],
            "totalFare": {
              "currencyCode": "SAR",
              "decimalPlaces": 2,
              "amount": 300.00
            },
            "unstructuredFareCalc": {
              "value": "JED HHR XMK 300.00SAR END"
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
        "fareInfo": [],
        "pricingUnit": [],
        "flightRefNumberRPHList": []
      },
      {
        "passengerTypeQuantity": {
          "code": "ADT",
          "quantity": 1
        },
        "fareBasisCodes": {
          "fareBasisCode": [
            {
              "value": "YECOSTD"
            }
          ]
        },
        "passengerFare": [
          {
            "baseFare": {
              "currencyCode": "SAR",
              "decimalPlaces": 2,
              "amount": 300.00
            },
            "equivFare": [],
            "totalFare": {
              "currencyCode": "SAR",
              "decimalPlaces": 2,
              "amount": 300.00
            },
            "unstructuredFareCalc": {
              "value": "JED HHR XMK 300.00SAR END"
            },
            "fareBaggageAllowance": [],
            "remark": []
          }
        ],
        "travelerRefNumber": [
          {
            "rph": "2"
          }
        ],
        "fareInfo": [],
        "pricingUnit": [],
        "flightRefNumberRPHList": []
      }
    ]
  }
}
```

**After:**

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
            }
          }
        ],
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "ApplPayGreater",
                "resBookDesigCode": "Y",
                "accountCode": "ApplPayGreater"
              }
            ]
          }
        ],
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
            }
          }
        ],
        "fareInfo": [
          {
            "fareReference": [
              {
                "value": "ApplPayGreater",
                "resBookDesigCode": "Y",
                "accountCode": "ApplPayGreater"
              }
            ]
          }
        ],
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

<a id="ota-message-samples"></a>
# OTA Message Samples

## OTA_AirLowFareSearchRQ

### Search for one-way trip options

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
            "quantity": 2
          },
          {
            "code": "CHD",
            "quantity": 1
          },
          {
            "code": "INF",
            "quantity": 1
          }
        ]
      }
    ]
  }
}
```

### Search for round trip options

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "<agentID>",
          "name": "<agencyID>"
        },
        "bookingChannel": {
          "type": "OTA"
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
        "value": "2024-03-25T08:00:00",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    },
    {
      "originLocation": {
        "locationCode": "DMX"
      },
      "destinationLocation": {
        "locationCode": "MKX"
      },
      "departureDateTime": {
        "value": "2024-03-28T08:00:00",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    }
  ],
  "specificFlightInfo": {
    "bookingClassPref": [
      {
        "resBookDesigCode": "C"
      }
    ]
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 2
          },
          {
            "code": "CHD",
            "quantity": 0
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

## OTA_AirBookRQ

This section is dedicated to the OTA_AirBook function, which handles booking operations within the OTA API. Here, you'll find the required fields and structure for making a regular booking request.
We require to provide the CTC and document information.

### Make one-way booking

The request below makes a round trip booking for two adults.

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
          "surname": "TESTER"
        },
        "email": [
          {
            "value": "test@go7.io"
          }
        ]
      },
      {
        "personName": {
          "namePrefix": [
            "MISS"
          ],
          "givenName": [
            "ONE"
          ],
          "surname": "PARKER"
        },
        "telephone": [
          {
            "countryAccessCode": "380",
            "phoneNumber": "671234567"
          }
        ],
        "document": [
          {
            "birthDate": "1979-01-01",
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12"
          }
        ],
        "travelerRefNumber": {
          "rph": "1"
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
            "TWO"
          ],
          "surname": "PARKER"
        },
        "document": [
          {
            "birthDate": "1979-01-01",
            "docID": "0123456789",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12"
          }
        ],
        "travelerRefNumber": {
          "rph": "2"
        },
        "passengerTypeCode": "ADT",
        "gender": "Male"
      }
    ]
  }
}
```

## OTA_AirPriceRQ

In the OTA_AirPrice section, we detail the necessary fields and structure for a group booking creation.
We require to provide a contact information.

### Make one-way group booking in Economy class

```json
{
  "correlationID": "4f4dad22-9432-4c5f-ab0c-994cdd0a992e",
  "target": "Production",
  "version": "2.001",
  "primaryLangID": "en",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "umrah",
          "name": "umrah"
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
              "departureDateTime": "2024-03-28T14:00:00.000+03:00",
              "arrivalDateTime": "2024-03-28T16:20:00.000+03:00",
              "flightNumber": "1120",
              "resBookDesigCode": "Y",
              "fareBasisCode": "ApplPayGreater",
              "status": "30",
              "departureAirport": {
                "locationCode": "MKX"
              },
              "arrivalAirport": {
                "locationCode": "DMX"
              },
              "marketingAirline": {
                "code": "HHR"
              }
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "pricingPref": [
      {
        "_": "Quote",
        "qualifier": "4"
      }
    ],
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 2
          },
          {
            "code": "CHD",
            "quantity": 0
          },
          {
            "code": "INF",
            "quantity": 0
          }
        ]
      },
      {
        "airTraveler": {
          "passengerTypeCode": "CTC",
          "personName": {
            "givenName": [
              "John"
            ],
            "surname": "Doe"
          },
          "email": [
            {
              "value": "my@agency.sa"
            }
          ]
        }
      }
    ]
  },
  "bookingReferenceID": {
    "type": "9",
    "id": "My Group 1"
  }
}
```


### Make round trip group booking in Business class

```json
{
  "target": "Production",
  "version": "2.001",
  "primaryLangID": "en",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "umrah",
          "name": "umrah"
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
              "departureDateTime": "2024-03-25T10:00:00.000+03:00",
              "arrivalDateTime": "2024-03-25T12:25:00.000+03:00",
              "rph": "1",
              "marketingAirline": {
                "code": "HHR"
              },
              "flightNumber": "0080",
              "resBookDesigCode": "C",
              "fareBasisCode": "002",
              "status": "30"
            }
          ]
        },
        {
          "flightSegment": [
            {
              "departureAirport": {
                "locationCode": "DMX"
              },
              "arrivalAirport": {
                "locationCode": "MKX"
              },
              "operatingAirline": {
                "code": "HHR",
                "flightNumber": "0141"
              },
              "equipment": [],
              "departureDateTime": "2024-03-28T16:30:00.000+03:00",
              "arrivalDateTime": "2024-03-28T18:55:00.000+03:00",
              "rph": "2",
              "marketingAirline": {
                "code": "HHR"
              },
              "flightNumber": "0141",
              "resBookDesigCode": "C",
              "fareBasisCode": "002",
              "status": "30"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "pricingPref": [
      {
        "_": "Quote",
        "qualifier": "4"
      }
    ],
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 2
          },
          {
            "code": "CHD",
            "quantity": 0
          },
          {
            "code": "INF",
            "quantity": 0
          }
        ]
      },
      {
        "airTraveler": {
          "passengerTypeCode": "CTC",
          "personName": {
            "givenName": [
              "John"
            ],
            "surname": "Doe"
          },
          "email": [
            {
              "value": "my@agency.sa"
            }
          ]
        }
      }
    ]
  }
}
```
## OTA_AirDemandTicketRQ

### Pay with debit-credit account

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
        "code": "W1"
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
## OTA_AirBookModifyRQ

### Update Passenger Names in a Group Booking with 2 adults, 1 child, and 1 infant
```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "umrah",
          "name": "umrah"
        },
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
                "departureDateTime": "2024-03-04T10:00:00.000+03:00",
                "arrivalDateTime": "2024-03-04T12:25:00.000+03:00",
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
          "travelerRefNumber": {
            "rph": "1"
          },
          
          "passengerTypeCode": "ADT",
          "gender": "Unknown"
        },
        {
          "travelerRefNumber": {
            "rph": "2"
          },
          "passengerTypeCode": "ADT",
          "gender": "Unknown"
        },
        {
          "travelerRefNumber": {
            "rph": "3"
          },
          "passengerTypeCode": "CHD",
          "gender": "Unknown"
        },
        {
          "travelerRefNumber": {
            "rph": "4"
          },
          "passengerTypeCode": "INF",
          "gender": "Unknown",
          "comment": [
            {
              "value": "1",
              "name": "attendantRph"
            }
          ]
        }
      ]
    },
    "bookingReferenceID": [
      {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "UZNHXQ",
        "flightRefNumberRPHList": []
      },
      {
        "companyName": {
          "code": "HHR"
        },
        "type": "14",
        "id": "52C21525F",
        "flightRefNumberRPHList": []
      }
    ],
    "createDateTime": "2024-02-29T18:04:24.500Z"
  },
  "airBookModifyRQ": {
    "modificationType": "3",
    "travelerInfo": {
      "airTraveler": [
        {
          "personName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PETER"
            ],
            "surname": "MAISON"
          },
          "document": [
            {
              "birthDate": "1979-01-01",
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12"
            }
          ],
          "travelerRefNumber": {
            "rph": "1"
          },
          "passengerTypeCode": "ADT",
          "accompaniedByInfantInd": true,
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
            "surname": "MAISON"
          },
          "document": [
            {
              "birthDate": "1979-01-01",
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12"
            }
          ],
          "travelerRefNumber": {
            "rph": "2"
          },
          "passengerTypeCode": "ADT",
          "accompaniedByInfantInd": false,
          "gender": "Female"
        },
        {
          "personName": {
            "givenName": [
              "SANDRA"
            ],
            "surname": "MAISON"
          },
          "document": [
            {
              "birthDate": "2023-01-01",
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12"
            }
          ],
          "travelerRefNumber": {
            "rph": "3"
          },
          "passengerTypeCode": "CHD",
          "gender": "Male"
        },
        {
          "personName": {
            "givenName": [
              "OKAN"
            ],
            "surname": "MAISON"
          },
          "document": [
            {
              "birthDate": "2024-01-01",
              "docID": "0123456789",
              "docType": "5",
              "docHolderNationality": "SA",
              "expireDate": "2027-12-12"
            }
          ],
          "travelerRefNumber": {
            "rph": "4"
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
## OTA_ReadRQ
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
