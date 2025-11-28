---
layout: default
title: Booking Modification
---

# Modify Booking (AirBookModifyRQ)

The purpose is to modify existing bookings. Supported modifications include name changes, date changes, adding SSR, and cancelling segments or passengers.

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://api.worldticket.net/ota/v2015b/OTA |
| Test | https://test-api.worldticket.net/ota/v2015b/OTA |

## HTTP Headers (All Required)

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| Content-Type | Request content type | application/xml |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

## Booking Modification Workflow

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

    Note over Customer, OTA: Booking Modification Process
    Customer->>+Application: Request booking modification
    Note right of Customer: Modification types:<br/>- Change name<br/>- Add SSR<br/>- Change date<br/>- Cancel segment/passenger

    alt Price check required (date/segment change)
        Application->>+OTA: OTA_AirBookModifyRQ<br/>(RepriceRequired="true")
        Note right of OTA: Calculate modification fees<br/>and price differences
        OTA-->>-Application: OTA_AirBookModifyRS<br/>(with price difference)
        Note right of Application: Service fee/charge<br/>for booking modification
        Application-->>Customer: Show modification costs
        
        Customer->>Application: Confirm or cancel modification
        alt Customer confirms
            Application->>+OTA: OTA_AirBookModifyRQ<br/>(RepriceRequired="false")
            Note right of OTA: Apply booking<br/>modifications
            OTA-->>-Application: OTA_AirBookModifyRS
            Note right of Application: Updated booking<br/>with modifications
            Application-->>-Customer: Show updated booking
        else Customer cancels
            Application-->>-Customer: Modification cancelled
        end
    else Simple modification (name/SSR)
        Application->>+OTA: OTA_AirBookModifyRQ
        Note right of OTA: Apply simple<br/>modifications directly
        OTA-->>-Application: OTA_AirBookModifyRS
        Note right of Application: Updated booking<br/>with modifications
        Application-->>-Customer: Show updated booking
    end
```

## Basic Request Format

### With JWT Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_AirBookModifyRQ \
    -H 'Authorization: Bearer {access_token}' \
    -H 'Content-Type: application/json' \
    -d @AirBookModifyRQ.json
```

### With API Key Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA_AirBookModifyRQ \
    -H 'X-API-Key: {api_key}' \
    -H 'Content-Type: application/json' \
    -d @AirBookModifyRQ.json
```

## Add SSR

Add Special Service Requests to an existing booking.

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
    "modificationType": "3",
    "travelerInfo": {
      "airTraveler": [
        "{airTraveler}"
      ]
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
                "text": "PP 859361445",
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
    "bookingReferenceID": [
      {
        "companyName": {
          "value": "",
          "code": "DX"
        },
        "type": "14",
        "id": "KEVHTZ",
        "flightRefNumberRPHList": []
      }
    ]
  },
  "airBookModifyRQ": {
    "modificationType": "5",
    "travelerInfo": {
      "specialReqDetails": [
        {
          "specialServiceRequests": {
            "specialServiceRequest": [
              {
                "ssrCode": "SEAT",
                "serviceQuantity": "1",
                "status": "11",
                "text": "Window seat preference",
                "flightRefNumberRPHList": [
                  "1"
                ],
                "travelerRefNumberRPHList": [
                  "1"
                ]
              }
            ]
          }
        }
      ]
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
        "ticketTimeLimit": "2025-11-27T07:34:29.000Z",
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
        "id": "KEVHTZ",
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
          "id": "2169489",
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
    "createDateTime": "2025-11-27T07:04:29.000Z",
    "emdinfo": []
  },
  "success": {},
  "timeStamp": "2025-11-27T07:34:10.171Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>
</details>

## Change Name

Modify passenger name in existing booking.

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
    "modificationType": "3",
    "travelerInfo": {
      "airTraveler": [
        "{airTraveler}"
      ]
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
        "ticketTimeLimit": "2025-11-27T08:30:16.077Z",
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
        "id": "N6RHD3",
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
          "id": "2169493",
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
    "createDateTime": "2025-11-27T08:00:16.000Z",
    "emdinfo": []
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
              "phoneNumber": "859361445"
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
              "docID": "859361445",
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
      ]
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
              "phoneNumber": "859361445"
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
              "docID": "859361445",
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
                "text": "PP 859361445",
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
        "ticketTimeLimit": "2025-11-27T08:30:16.000Z",
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
        "id": "N6RHD3",
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
          "id": "2169493",
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
    "createDateTime": "2025-11-27T08:00:16.000Z",
    "emdinfo": []
  },
  "success": {},
  "timeStamp": "2025-11-27T08:02:42.838Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>
</details>

[//]: # ()
[//]: # (## Change Date)

[//]: # ()
[//]: # (### Request to Display Price Difference)

[//]: # ()
[//]: # (First, get the price difference between old and new segments:)

[//]: # ()
[//]: # (### JSON Request)

[//]: # ()
[//]: # (<details>)

[//]: # (<summary><strong>📋 JSON Request Template</strong></summary>)

[//]: # (<div markdown="1">)

[//]: # ()
[//]: # (```json)

[//]: # ({)

[//]: # (  "version": "2.001",)

[//]: # (  "pos": "{pos}",)

[//]: # (  "airReservation": "{airReservation}",)

[//]: # (  "airBookModifyRQ": {)

[//]: # (    "modificationType": "3",)

[//]: # (    "travelerInfo": {)

[//]: # (      "airTraveler": [)

[//]: # (        "{airTraveler}")

[//]: # (      ])

[//]: # (    })

[//]: # (  })

[//]: # (})

[//]: # (```)

[//]: # ()
[//]: # (</div>)

[//]: # (</details>)

[//]: # ()
[//]: # (<details>)

[//]: # (<summary><strong>✅ Example</strong></summary>)

[//]: # (<div markdown="1">)

[//]: # ()
[//]: # (```json)

[//]: # ()
[//]: # (```)

[//]: # ()
[//]: # (</div>)

[//]: # (</details>)

[//]: # ()
[//]: # (### JSON Response)

[//]: # ()
[//]: # (<details>)

[//]: # (<summary><strong>✅ Example</strong></summary>)

[//]: # (<div markdown="1">)

[//]: # ()
[//]: # (```json)

[//]: # ()
[//]: # (```)

[//]: # ()
[//]: # (</div>)

[//]: # (</details>)

[//]: # ()
[//]: # ()
[//]: # (```xml)

[//]: # ()
[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # ()
[//]: # (<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001" RepriceRequired="true">)

[//]: # ()
[//]: # (    <POS>)

[//]: # ()
[//]: # (        <Source>)

[//]: # ()
[//]: # (            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>)

[//]: # ()
[//]: # (        </Source>)

[//]: # ()
[//]: # (    </POS>)

[//]: # ()
[//]: # (    <AirReservation>)

[//]: # ()
[//]: # (        <BookingReferenceID ID="{record_locator}" Type="14">)

[//]: # ()
[//]: # (            <CompanyName Code="{airline_code}"/>)

[//]: # ()
[//]: # (        </BookingReferenceID>)

[//]: # ()
[//]: # (        <AirItinerary>)

[//]: # ()
[//]: # (            <OriginDestinationOptions>)

[//]: # ()
[//]: # (                <OriginDestinationOption>)

[//]: # ()
[//]: # (                    <FlightSegment DepartureDateTime="{new_departure_datetime}" )

[//]: # ()
[//]: # (                                  ArrivalDateTime="{new_arrival_datetime}")

[//]: # ()
[//]: # (                                  FlightNumber="{new_flight_number}")

[//]: # ()
[//]: # (                                  ResBookDesigCode="{booking_class}">)

[//]: # ()
[//]: # (                        <DepartureAirport LocationCode="{origin_code}"/>)

[//]: # ()
[//]: # (                        <ArrivalAirport LocationCode="{destination_code}"/>)

[//]: # ()
[//]: # (                        <MarketingAirline Code="{airline_code}"/>)

[//]: # ()
[//]: # (                    </FlightSegment>)

[//]: # ()
[//]: # (                </OriginDestinationOption>)

[//]: # ()
[//]: # (            </OriginDestinationOptions>)

[//]: # ()
[//]: # (        </AirItinerary>)

[//]: # ()
[//]: # (    </AirReservation>)

[//]: # ()
[//]: # (</OTA_AirBookModifyRQ>)

[//]: # ()
[//]: # (```)

[//]: # ()
[//]: # ()
[//]: # (### Response with Price Difference)

[//]: # ()
[//]: # ()
[//]: # (```xml)

[//]: # ()
[//]: # (<OTA_AirBookModifyRS>)

[//]: # ()
[//]: # (    <Success/>)

[//]: # ()
[//]: # (    <AirReservation>)

[//]: # ()
[//]: # (        <PriceInfo>)

[//]: # ()
[//]: # (            <ItinTotalFare>)

[//]: # ()
[//]: # (                <TotalFare Amount="{new_total_fare}" CurrencyCode="{currency_code}"/>)

[//]: # ()
[//]: # (            </ItinTotalFare>)

[//]: # ()
[//]: # (            <PriceDifference>)

[//]: # ()
[//]: # (                <Amount Amount="{price_difference}" CurrencyCode="{currency_code}"/>)

[//]: # ()
[//]: # (                <Description>Additional charge for date change</Description>)

[//]: # ()
[//]: # (            </PriceDifference>)

[//]: # ()
[//]: # (        </PriceInfo>)

[//]: # ()
[//]: # (    </AirReservation>)

[//]: # ()
[//]: # (</OTA_AirBookModifyRS>)

[//]: # ()
[//]: # (```)

[//]: # ()
[//]: # ()
[//]: # (### Confirm Date Change)

[//]: # ()
[//]: # ()
[//]: # (After reviewing price difference, confirm the change:)

[//]: # ()
[//]: # ()
[//]: # (```xml)

[//]: # ()
[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # ()
[//]: # (<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001" RepriceRequired="false">)

[//]: # ()
[//]: # (    <POS>)

[//]: # ()
[//]: # (        <Source>)

[//]: # ()
[//]: # (            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>)

[//]: # ()
[//]: # (        </Source>)

[//]: # ()
[//]: # (    </POS>)

[//]: # ()
[//]: # (    <AirReservation>)

[//]: # ()
[//]: # (        <BookingReferenceID ID="{record_locator}" Type="14">)

[//]: # ()
[//]: # (            <CompanyName Code="{airline_code}"/>)

[//]: # ()
[//]: # (        </BookingReferenceID>)

[//]: # ()
[//]: # (        <AirItinerary>)

[//]: # ()
[//]: # (            <OriginDestinationOptions>)

[//]: # ()
[//]: # (                <OriginDestinationOption>)

[//]: # ()
[//]: # (                    <FlightSegment DepartureDateTime="{new_departure_datetime}" )

[//]: # ()
[//]: # (                                  ArrivalDateTime="{new_arrival_datetime}")

[//]: # ()
[//]: # (                                  FlightNumber="{new_flight_number}")

[//]: # ()
[//]: # (                                  ResBookDesigCode="{booking_class}">)

[//]: # ()
[//]: # (                        <DepartureAirport LocationCode="{origin_code}"/>)

[//]: # ()
[//]: # (                        <ArrivalAirport LocationCode="{destination_code}"/>)

[//]: # ()
[//]: # (                        <MarketingAirline Code="{airline_code}"/>)

[//]: # ()
[//]: # (                    </FlightSegment>)

[//]: # ()
[//]: # (                </OriginDestinationOption>)

[//]: # ()
[//]: # (            </OriginDestinationOptions>)

[//]: # ()
[//]: # (        </AirItinerary>)

[//]: # ()
[//]: # (        <PaymentInfo PaymentType="5">)

[//]: # ()
[//]: # (            <PaymentCard CardType="VI" CardNumber="{card_number}" ExpireDate="{expiry_date}">)

[//]: # ()
[//]: # (                <CardHolderName>{cardholder_name}</CardHolderName>)

[//]: # ()
[//]: # (            </PaymentCard>)

[//]: # ()
[//]: # (        </PaymentInfo>)

[//]: # ()
[//]: # (    </AirReservation>)

[//]: # ()
[//]: # (</OTA_AirBookModifyRQ>)

[//]: # ()
[//]: # (```)

[//]: # (## Cancel Specific Segment)

[//]: # ()
[//]: # (Cancel individual flight segments from a multi-segment booking.)

[//]: # ()
[//]: # (### XML Request)

[//]: # ()
[//]: # (```xml)

[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # (<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">)

[//]: # (    <POS>)

[//]: # (        <Source>)

[//]: # (            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>)

[//]: # (        </Source>)

[//]: # (    </POS>)

[//]: # (    <AirReservation>)

[//]: # (        <BookingReferenceID ID="{record_locator}" Type="14">)

[//]: # (            <CompanyName Code="{airline_code}"/>)

[//]: # (        </BookingReferenceID>)

[//]: # (        <AirItinerary>)

[//]: # (            <OriginDestinationOptions>)

[//]: # (                <OriginDestinationOption>)

[//]: # (                    <FlightSegment DepartureDateTime="{departure_datetime}" )

[//]: # (                                  FlightNumber="{flight_number}")

[//]: # (                                  Status="Cancel">)

[//]: # (                        <DepartureAirport LocationCode="{origin_code}"/>)

[//]: # (                        <ArrivalAirport LocationCode="{destination_code}"/>)

[//]: # (                        <MarketingAirline Code="{airline_code}"/>)

[//]: # (                    </FlightSegment>)

[//]: # (                </OriginDestinationOption>)

[//]: # (            </OriginDestinationOptions>)

[//]: # (        </AirItinerary>)

[//]: # (        <CancellationInfo>)

[//]: # (            <CancellationReason>Passenger request</CancellationReason>)

[//]: # (        </CancellationInfo>)

[//]: # (    </AirReservation>)

[//]: # (</OTA_AirBookModifyRQ>)

[//]: # (```)

[//]: # ()
[//]: # (## Cancel Specific Passenger)

[//]: # ()
[//]: # (Remove individual passengers from booking.)

[//]: # ()
[//]: # (### XML Request)

[//]: # ()
[//]: # (```xml)

[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # (<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">)

[//]: # (    <POS>)

[//]: # (        <Source>)

[//]: # (            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>)

[//]: # (        </Source>)

[//]: # (    </POS>)

[//]: # (    <AirReservation>)

[//]: # (        <BookingReferenceID ID="{record_locator}" Type="14">)

[//]: # (            <CompanyName Code="{airline_code}"/>)

[//]: # (        </BookingReferenceID>)

[//]: # (        <TravelerInfo>)

[//]: # (            <AirTraveler Status="Cancel">)

[//]: # (                <PersonName>)

[//]: # (                    <GivenName>{first_name}</GivenName>)

[//]: # (                    <Surname>{last_name}</Surname>)

[//]: # (                </PersonName>)

[//]: # (                <TravelerRefNumber RPH="2"/>)

[//]: # (            </AirTraveler>)

[//]: # (        </TravelerInfo>)

[//]: # (        <CancellationInfo>)

[//]: # (            <CancellationReason>Passenger unable to travel</CancellationReason>)

[//]: # (        </CancellationInfo>)

[//]: # (    </AirReservation>)

[//]: # (</OTA_AirBookModifyRQ>)

[//]: # (```)

[//]: # ()
[//]: # (## Modification Response)

[//]: # ()
[//]: # (### Successful Modification)

[//]: # ()
[//]: # (```xml)

[//]: # (<?xml version="1.0" encoding="UTF-8"?>)

[//]: # (<OTA_AirBookModifyRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">)

[//]: # (    <Success/>)

[//]: # (    <AirReservation>)

[//]: # (        <BookingReferenceID ID="{record_locator}" Type="14">)

[//]: # (            <CompanyName Code="{airline_code}"/>)

[//]: # (        </BookingReferenceID>)

[//]: # (        <ModificationSummary>)

[//]: # (            <ModifiedItems>)

[//]: # (                <ModifiedItem Type="SSR" Status="Added">)

[//]: # (                    <Description>Special meal request added</Description>)

[//]: # (                </ModifiedItem>)

[//]: # (                <ModifiedItem Type="Name" Status="Changed">)

[//]: # (                    <Description>Passenger name updated</Description>)

[//]: # (                </ModifiedItem>)

[//]: # (            </ModifiedItems>)

[//]: # (        </ModificationSummary>)

[//]: # (        <PriceInfo>)

[//]: # (            <ItinTotalFare>)

[//]: # (                <TotalFare Amount="{updated_total_fare}" CurrencyCode="{currency_code}"/>)

[//]: # (            </ItinTotalFare>)

[//]: # (            <ServiceFees>)

[//]: # (                <ServiceFee Type="NameChange" Amount="{name_change_fee}" CurrencyCode="{currency_code}"/>)

[//]: # (                <ServiceFee Type="DateChange" Amount="{date_change_fee}" CurrencyCode="{currency_code}"/>)

[//]: # (            </ServiceFees>)

[//]: # (        </PriceInfo>)

[//]: # (        <TicketingInfo TicketTimeLimit="{updated_time_limit}"/>)

[//]: # (    </AirReservation>)

[//]: # (</OTA_AirBookModifyRS>)

[//]: # (```)

[//]: # ()
[//]: # (### JSON Response)

[//]: # ()
[//]: # (```json)

[//]: # ({)

[//]: # (  "version": "2.001",)

[//]: # (  "success": {},)

[//]: # (  "airReservation": {)

[//]: # (    "bookingReferenceID": {)

[//]: # (      "id": "{record_locator}",)

[//]: # (      "type": "14",)

[//]: # (      "companyName": {)

[//]: # (        "code": "{airline_code}")

[//]: # (      })

[//]: # (    },)

[//]: # (    "modificationSummary": {)

[//]: # (      "modifiedItems": [)

[//]: # (        {)

[//]: # (          "type": "SSR",)

[//]: # (          "status": "Added",)

[//]: # (          "description": "Special meal request added")

[//]: # (        },)

[//]: # (        {)

[//]: # (          "type": "Name",)

[//]: # (          "status": "Changed",)

[//]: # (          "description": "Passenger name updated")

[//]: # (        })

[//]: # (      ])

[//]: # (    },)

[//]: # (    "priceInfo": {)

[//]: # (      "itinTotalFare": {)

[//]: # (        "totalFare": {)

[//]: # (          "amount": "{updated_total_fare}",)

[//]: # (          "currencyCode": "{currency_code}")

[//]: # (        })

[//]: # (      },)

[//]: # (      "serviceFees": [)

[//]: # (        {)

[//]: # (          "type": "NameChange",)

[//]: # (          "amount": "{name_change_fee}",)

[//]: # (          "currencyCode": "{currency_code}")

[//]: # (        })

[//]: # (      ])

[//]: # (    },)

[//]: # (    "ticketingInfo": {)

[//]: # (      "ticketTimeLimit": "{updated_time_limit}")

[//]: # (    })

[//]: # (  })

[//]: # (})

[//]: # (```)

## Modification Policies

### Name Change Policy
- Minor spelling corrections usually allowed
- Complete name changes may require documentation
- Fees may apply based on fare rules

[//]: # (### Date Change Policy  )

[//]: # (- Subject to seat availability on new flight)

[//]: # (- Price difference may apply)

[//]: # (- Change fees based on fare conditions)

[//]: # (- Some fares may not allow changes)

### SSR Policy
- Most SSRs can be added post-booking
- Some services may have availability limitations
- Additional fees may apply for premium services