## Read booking

### Read the existing booking in SMS to display the booking information (ReadRQ)

### Request Parameters in the header (all required)

| Parameter  | Type    | Description        | Example                  |
| ---------- | ------- | ------------------ | ------------------------ |
| x-api-key  | Header  | Access Token       | [Access token](#api-key) |
| local-name | Header  | Custom HTTP header | OTA_ReadRQ               |
| agentId    | Payload | Custom HTTP header | ota                      |
| agencyId   | Payload | Custom HTTP header | ota                      |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

<details open>
  <summary>Request Payload</summary>
  <pre>
    {
      "version": "2.001",
      "pos": {
        "source": [
          {
            "bookingChannel": {
              "type": "OTA"
            },
            "isoCurrency": "SAR",
            "requestorID": {
              "type": "5",
              "id": "<ins>agentId</ins>",
              "name": "<ins>agencyId</ins>"
              "location": "CPH"
            }
          }
        ]
      },
      "readRequests": {
        "readRequest": [
          {
            "uniqueID": {
              "id": "N6G2NW",
              "type": "14"
            }
          }
        ]
      }
    }
  </pre>
</details>
<details>
  <summary>Response Payload</summary>
  <pre>
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
                      "locationCode": "DMX"
                    },
                    "operatingAirline": {
                      "code": "HHR",
                      "flightNumber": "0080"
                    },
                    "equipment": [],
                    "departureDateTime": "2024-03-22T10:00:00.000+03:00",
                    "arrivalDateTime": "2024-03-22T12:25:00.000+03:00",
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
        "priceInfo": {
          "itinTotalFare": [
            {
              "baseFare": {
                "currencyCode": "SAR",
                "amount": 10
              },
              "equivFare": [],
              "taxes": {
                "tax": [
                  {
                    "taxCode": "VAT",
                    "currencyCode": "SAR",
                    "amount": 1.5
                  }
                ],
                "amount": 1.5
              },
              "fees": {
                "fee": [
                  {
                    "feeCode": "FE1",
                    "currencyCode": "SAR",
                    "amount": 75
                  },
                  {
                    "feeCode": "VAT",
                    "currencyCode": "SAR",
                    "amount": 11.25
                  },
                  {
                    "feeCode": "VAT_VAT",
                    "currencyCode": "SAR",
                    "amount": 0
                  }
                ],
                "amount": 86.25
              },
              "totalFare": {
                "currencyCode": "SAR",
                "amount": 97.75
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
                    "value": "ApplPayGreater"
                  }
                ],
                "filingAirline": {
                  "value": "HHR"
                },
                "marketingAirline": [],
                "departureAirport": {
                  "locationCode": "MKX"
                },
                "arrivalAirport": {
                  "locationCode": "DMX"
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
                    "value": "ApplPayGreater"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "2"
              },
              {
                "fareReference": [
                  {
                    "value": "ApplPayGreater"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "3"
              },
              {
                "fareReference": [
                  {
                    "value": "ApplPayGreater"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "4"
              },
              {
                "fareReference": [
                  {
                    "value": "ApplPayGreater"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "5"
              }
            ]
          },
          "ptcfareBreakdowns": {
            "ptcfareBreakdown": [
              {
                "passengerTypeQuantity": {
                  "code": "ADT",
                  "quantity": 5
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
                      "amount": 10
                    },
                    "equivFare": [],
                    "taxes": {
                      "tax": [
                        {
                          "taxCode": "VAT",
                          "taxName": "VAT",
                          "currencyCode": "SAR",
                          "amount": 1.5
                        }
                      ],
                      "amount": 1.5
                    },
                    "fees": {
                      "fee": [
                        {
                          "feeCode": "FE1",
                          "currencyCode": "SAR",
                          "amount": 75
                        },
                        {
                          "feeCode": "VAT",
                          "currencyCode": "SAR",
                          "amount": 11.25
                        },
                        {
                          "feeCode": "VAT_VAT",
                          "currencyCode": "SAR",
                          "amount": 0
                        }
                      ],
                      "amount": 86.25
                    },
                    "totalFare": {
                      "currencyCode": "SAR",
                      "amount": 97.75
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
                  },
                  {
                    "rph": "3"
                  },
                  {
                    "rph": "4"
                  },
                  {
                    "rph": "5"
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
        },
        "travelerInfo": {
          "airTraveler": [
            {
              "personName": {
                "namePrefix": [],
                "givenName": [
                  "TEST QA"
                ],
                "middleName": [],
                "surname": "TESTER",
                "nameSuffix": [],
                "nameTitle": []
              },
              "telephone": [],
              "email": [
                {
                  "value": "tester@example.com",
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
              "telephone": [],
              "email": [],
              "address": [],
              "custLoyalty": [],
              "document": [],
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
              "gender": "Unknown",
              "comment": []
            },
            {
              "telephone": [],
              "email": [],
              "address": [],
              "custLoyalty": [],
              "document": [],
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
              "gender": "Unknown",
              "comment": []
            },
            {
              "telephone": [],
              "email": [],
              "address": [],
              "custLoyalty": [],
              "document": [],
              "travelerRefNumber": {
                "rph": "3"
              },
              "flightSegmentRPHs": {
                "flightSegmentRPH": [
                  "1"
                ]
              },
              "socialMediaInfo": [],
              "passengerTypeCode": "ADT",
              "gender": "Unknown",
              "comment": []
            },
            {
              "telephone": [],
              "email": [],
              "address": [],
              "custLoyalty": [],
              "document": [],
              "travelerRefNumber": {
                "rph": "4"
              },
              "flightSegmentRPHs": {
                "flightSegmentRPH": [
                  "1"
                ]
              },
              "socialMediaInfo": [],
              "passengerTypeCode": "ADT",
              "gender": "Unknown",
              "comment": []
            },
            {
              "telephone": [],
              "email": [],
              "address": [],
              "custLoyalty": [],
              "document": [],
              "travelerRefNumber": {
                "rph": "5"
              },
              "flightSegmentRPHs": {
                "flightSegmentRPH": [
                  "1"
                ]
              },
              "socialMediaInfo": [],
              "passengerTypeCode": "ADT",
              "gender": "Unknown",
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
            "ticketDocumentNbr": "3333330007692",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
              "couponInfos": [
                {
                  "flightRefRPH": "1",
                  "number": "1",
                  "status": "O"
                }
              ]
            }
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "2"
            ],
            "ticketDocumentNbr": "3333330007693",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
              "couponInfos": [
                {
                  "flightRefRPH": "1",
                  "number": "1",
                  "status": "O"
                }
              ]
            }
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "3"
            ],
            "ticketDocumentNbr": "3333330007694",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
              "couponInfos": [
                {
                  "flightRefRPH": "1",
                  "number": "1",
                  "status": "O"
                }
              ]
            }
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "4"
            ],
            "ticketDocumentNbr": "3333330007695",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
              "couponInfos": [
                {
                  "flightRefRPH": "1",
                  "number": "1",
                  "status": "O"
                }
              ]
            }
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "5"
            ],
            "ticketDocumentNbr": "3333330007696",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
              "code": "W1"
            },
            "type": "14",
            "id": "N6G2NW",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "C83EEA626",
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
              "id": "1385505",
              "tpaExtensions": {
                "orderInfo": {
                  "action": "CREATE_BOOKING",
                  "currencyCode": "SAR",
                  "direction": "PAYMENT",
                  "orderType": "BOOKING",
                  "status": "PAID",
                  "totalAmount": "97.75"
                }
              }
            }
          ],
          "purchased": []
        },
        "createDateTime": "2024-03-15T10:13:19.700Z",
        "emdinfo": []
      },
      "version": 2.001
    }
  </pre>
</details>