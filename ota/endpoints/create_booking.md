## Create a booking

The purpose is to create the booking in SMS by providing a specific flight and fare in the request.

There are two types of bookings:

- Regular booking
- Group booking

### Create a regular booking (AirBookRQ)

### Request Parameters in the header (all required)

| Parameter  | Type    | Description        | Example                  |
| ---------- | ------- | ------------------ | ------------------------ |
| x-api-key  | Header  | Access Token       | [Access token](#api-key) |
| local-name | Header  | Custom HTTP header | OTA_AirBookRQ            |
| agentId    | Payload | Custom HTTP header | ota                      |
| agencyId   | Payload | Custom HTTP header | ota                      |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

#### AirBookRQ for Oneway Trip

<details>
  <summary>Request Payload</summary>
  <pre>
    {
      "version": "2.001",
      "pos": {
        "source": [
          {
            "isoCurrency": "SAR",
            "requestorID": {
              "type": "5",
              "id": "<ins>agentId</ins>",
              "name": "<ins>agencyId</ins>"
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
                  "departureDateTime": "2024-03-22T10:00:00.000+03:00",
                  "arrivalDateTime": "2024-03-22T12:25:00.000+03:00",
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
                "value": "tester@example.com"
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
                "value": "tester@example.com"
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
                "value": "tester@example.com"
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
                "value": "tester@example.com"
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
          },
          {
            "personName": {
              "namePrefix": [
                "MR"
              ],
              "givenName": [
                "PAXFORE"
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
                "value": "tester@example.com"
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
              "rph": "4"
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
                "PAXFIVE"
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
                "value": "tester@example.com"
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
              "rph": "5"
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
  </pre>
</details>

<details>
  <summary>Response Payload</summary>
  <pre>
    {
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
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [
                      {
                        "bookingClassAvail": [
                          {
                            "resBookDesigCode": "Y",
                            "resBookDesigQuantity": "99",
                            "resBookDesigStatusCode": "A"
                          }
                        ]
                      }
                    ],
                    "comment": [],
                    "stopLocation": []
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
                    "amount": 1.5
                  }
                ],
                "amount": 1.5
              },
              "fees": {
                "fee": [
                  {
                    "feeCode": "FE1",
                    "amount": 75
                  },
                  {
                    "feeCode": "VAT",
                    "amount": 11.25
                  }
                ],
                "currencyCode": "SAR",
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
                "airport": []
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
                          "amount": 1.5
                        }
                      ],
                      "amount": 1.5
                    },
                    "fees": {
                      "fee": [
                        {
                          "feeCode": "FE1",
                          "amount": 75
                        },
                        {
                          "feeCode": "VAT",
                          "amount": 11.25
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
                  "value": "tester@example.com",
                  "defaultInd": true
                }
              ],
              "address": [
                {
                  "bldgRoom": [],
                  "addressLine": [],
                  "cityName": "Makkha",
                  "countryName": {
                    "value": "",
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
                "surname": "PARKER",
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
                  "value": "tester@example.com"
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
                  "birthDate": "1979-01-01",
                  "expireDate": "2027-12-12"
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
                "surname": "PARKER",
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
                  "value": "tester@example.com"
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
                  "birthDate": "1979-01-01",
                  "expireDate": "2027-12-12"
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
                  "MR"
                ],
                "givenName": [
                  "PAXTHREE"
                ],
                "middleName": [],
                "surname": "PARKER",
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
                  "value": "tester@example.com"
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
                  "birthDate": "1979-01-01",
                  "expireDate": "2027-12-12"
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
              "passengerTypeCode": "ADT",
              "gender": "Male",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MR"
                ],
                "givenName": [
                  "PAXFORE"
                ],
                "middleName": [],
                "surname": "PARKER",
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
                  "value": "tester@example.com"
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
                  "birthDate": "1979-01-01",
                  "expireDate": "2027-12-12"
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
              "passengerTypeCode": "ADT",
              "gender": "Male",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MR"
                ],
                "givenName": [
                  "PAXFIVE"
                ],
                "middleName": [],
                "surname": "PARKER",
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
                  "value": "tester@example.com"
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
                  "birthDate": "1979-01-01",
                  "expireDate": "2027-12-12"
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
            "ticketTimeLimit": "2024-03-15T14:03:09.000+03:00",
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [
              "1"
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
            "id": "8FQQ4A",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "CB0255134",
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
              "id": "1385531",
              "tpaExtensions": {
                "orderInfo": {
                  "action": "CREATE_BOOKING",
                  "currencyCode": "SAR",
                  "direction": "PAYMENT",
                  "orderType": "BOOKING",
                  "status": "PENDING",
                  "totalAmount": "97.75"
                }
              }
            }
          ],
          "purchased": []
        },
        "emdinfo": []
      }
    }
  </pre>
</details>

<br>

#### AirBookRQ for Round trip

<details>
  <summary>Request Payload</summary>
  <pre>
    {
        "version": "2.001",
        "pos": {
            "source": [
                {
                    "isoCurrency": "SAR",
                    "requestorID": {
                        "type": "5",
                        "id": "<ins>agentId</ins>",
                        "name": "<ins>agencyId</ins>"
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
                                    "flightNumber": "0141"
                                },
                                "equipment": [],
                                "departureDateTime": "2024-03-27T16:30:00.000+03:00",
                                "arrivalDateTime": "2024-03-27T18:55:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "0141",
                                "resBookDesigCode": "Y",
                                "fareBasisCode": "testEco",
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
                                    "flightNumber": "1120"
                                },
                                "equipment": [],
                                "departureDateTime": "2024-04-03T13:00:00.000+03:00",
                                "arrivalDateTime": "2024-04-03T15:20:00.000+03:00",
                                "rph": "2",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "1120",
                                "resBookDesigCode": "Y",
                                "fareBasisCode": "testEco",
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
                            "value": "btester@example.com"
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
                            "value": "btester@example.com"
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
                            "1","2"
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
                            "value": "btester@example.com"
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
                            "1","2"
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
                            "value": "btester@example.com"
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
                            "1","2"
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
                            "PAXFORE"
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
                            "value": "btester@example.com"
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
                        "rph": "4"
                    },
                    "flightSegmentRPHs": {
                        "flightSegmentRPH": [
                            "1","2"
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
                            "PAXFIVE"
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
                            "value": "btester@example.com"
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
                        "rph": "5"
                    },
                    "flightSegmentRPHs": {
                        "flightSegmentRPH": [
                            "1",
                            "2"
                        ]
                    },
                    "passengerTypeCode": "ADT",
                    "gender": "Male"
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
        "airReservation": {
            "airItinerary": {
                "originDestinationOptions": {
                    "originDestinationOption": [
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
                                    "departureDateTime": "2024-04-03T15:30:00.000+03:00",
                                    "arrivalDateTime": "2024-04-03T17:55:00.000+03:00",
                                    "rph": "2",
                                    "marketingAirline": {
                                        "code": "HHR"
                                    },
                                    "flightNumber": "0141",
                                    "resBookDesigCode": "Y",
                                    "bookingClassAvails": [
                                        {
                                            "bookingClassAvail": [
                                                {
                                                    "resBookDesigCode": "Y",
                                                    "resBookDesigQuantity": "152",
                                                    "resBookDesigStatusCode": "A"
                                                }
                                            ]
                                        }
                                    ],
                                    "comment": [],
                                    "stopLocation": []
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
                            "amount": 1000.0
                        },
                        "equivFare": [],
                        "taxes": {
                            "tax": [
                                {
                                    "taxCode": "VAT",
                                    "amount": 150.0
                                }
                            ],
                            "amount": 150.0
                        },
                        "fees": {
                            "fee": [
                                {
                                    "feeCode": "FE1",
                                    "amount": 75.0
                                },
                                {
                                    "feeCode": "VAT",
                                    "amount": 11.25
                                }
                            ],
                            "currencyCode": "SAR",
                            "amount": 86.25
                        },
                        "totalFare": {
                            "currencyCode": "SAR",
                            "amount": 1236.25
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
                                    "value": "testEco"
                                }
                            ],
                            "filingAirline": {
                                "value": "HHR"
                            },
                            "marketingAirline": [],
                            "departureAirport": {
                                "locationCode": "DMX"
                            },
                            "arrivalAirport": {
                                "locationCode": "MKX"
                            },
                            "date": [],
                            "fareInfo": [],
                            "city": [],
                            "airport": []
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
                                        "value": "testEco",
                                        "flightSegmentRPH": "2"
                                    }
                                ]
                            },
                            "passengerFare": [
                                {
                                    "baseFare": {
                                        "currencyCode": "SAR",
                                        "amount": 1000.0
                                    },
                                    "equivFare": [],
                                    "taxes": {
                                        "tax": [
                                            {
                                                "taxCode": "VAT",
                                                "amount": 150.0
                                            }
                                        ],
                                        "amount": 150.0
                                    },
                                    "fees": {
                                        "fee": [
                                            {
                                                "feeCode": "FE1",
                                                "amount": 75.0
                                            },
                                            {
                                                "feeCode": "VAT",
                                                "amount": 11.25
                                            }
                                        ],
                                        "amount": 86.25
                                    },
                                    "totalFare": {
                                        "currencyCode": "SAR",
                                        "amount": 1236.25
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
                            "fareInfo": [
                                {
                                    "fareReference": [
                                        {
                                            "value": "testEco",
                                            "resBookDesigCode": "Y",
                                            "accountCode": "testEco"
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
                                "value": "btester@example.com",
                                "defaultInd": true
                            }
                        ],
                        "address": [
                            {
                                "bldgRoom": [],
                                "addressLine": [],
                                "cityName": "Makkha",
                                "countryName": {
                                    "value": "",
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
                            "surname": "PARKER",
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
                                "value": "btester@example.com"
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
                                "birthDate": "1979-01-01",
                                "expireDate": "2027-12-12"
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
                            "surname": "PARKER",
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
                                "value": "btester@example.com"
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
                                "birthDate": "1979-01-01",
                                "expireDate": "2027-12-12"
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
                        "gender": "Male",
                        "comment": []
                    },
                    {
                        "personName": {
                            "namePrefix": [
                                "MR"
                            ],
                            "givenName": [
                                "PAXTHREE"
                            ],
                            "middleName": [],
                            "surname": "PARKER",
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
                                "value": "btester@example.com"
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
                                "birthDate": "1979-01-01",
                                "expireDate": "2027-12-12"
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
                        "passengerTypeCode": "ADT",
                        "gender": "Male",
                        "comment": []
                    },
                    {
                        "personName": {
                            "namePrefix": [
                                "MR"
                            ],
                            "givenName": [
                                "PAXFORE"
                            ],
                            "middleName": [],
                            "surname": "PARKER",
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
                                "value": "btester@example.com"
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
                                "birthDate": "1979-01-01",
                                "expireDate": "2027-12-12"
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
                        "passengerTypeCode": "ADT",
                        "gender": "Male",
                        "comment": []
                    },
                    {
                        "personName": {
                            "namePrefix": [
                                "MR"
                            ],
                            "givenName": [
                                "PAXFIVE"
                            ],
                            "middleName": [],
                            "surname": "PARKER",
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
                                "value": "btester@example.com"
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
                                "birthDate": "1979-01-01",
                                "expireDate": "2027-12-12"
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
                    "ticketTimeLimit": "2024-03-26T06:44:04.000+03:00",
                    "ticketType": "E_TICKET",
                    "flightSegmentRefNumber": [
                        "1"
                    ],
                    "travelerRefNumber": [],
                    "miscTicketingCode": []
                },
                {
                    "ticketAdvisory": [],
                    "ticketTimeLimit": "2024-03-26T06:44:04.000+03:00",
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
                    "id": "MYFYX3",
                    "flightRefNumberRPHList": []
                },
                {
                    "companyName": {
                        "code": "HHR"
                    },
                    "type": "14",
                    "id": "10916953A",
                    "flightRefNumberRPHList": []
                },
                {
                    "companyName": {
                        "code": "HHR"
                    },
                    "type": "14",
                    "id": "046CFEA30",
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
                        "id": "1397127",
                        "tpaExtensions": {
                            "orderInfo": {
                                "action": "CREATE_BOOKING",
                                "currencyCode": "SAR",
                                "direction": "PAYMENT",
                                "orderType": "BOOKING",
                                "status": "PENDING",
                                "totalAmount": "1236.25"
                            }
                        }
                    }
                ],
                "purchased": []
            },
            "emdinfo": []
        }
    }
  </pre>
</details>

<br>

### Create a group booking (AirPriceRQ)

`When making a group booking, passenger names are not known yet, hence In AirPriceRQ, a passenger type quantity (and not names as in AirBookRQ) should be specified and contact details along with a travel itinerary.`

### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_AirPriceRQ                       |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

#### AirPriceRQ for Oneway trip

<details>
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
                  "departureDateTime": "2024-03-22T10:00:00.000+03:00",
                  "arrivalDateTime": "2024-03-22T12:25:00.000+03:00",
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
      "travelerInfoSummary": {
        "pricingPref": [
          {
            "qualifier": "4"
          }
        ],
        "airTravelerAvail": [
          {
            "passengerTypeQuantity": [
              {
                "code": "ADT",
                "quantity": 5
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
                  "TEST"
                ],
                "middleName": [
                  "QA"
                ],
                "surname": "TESTER"
              },
              "email": [
                {
                  "value": "tester@example.com"
                }
              ]
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
      "pricedItineraries": {
        "pricedItinerary": [
          {
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
                        "resBookDesigCode": "Y",
                        "bookingClassAvails": [
                          {
                            "bookingClassAvail": [
                              {
                                "resBookDesigCode": "Y",
                                "resBookDesigQuantity": "143",
                                "resBookDesigStatusCode": "A"
                              }
                            ]
                          }
                        ],
                        "comment": [],
                        "stopLocation": []
                      }
                    ],
                    "rph": "1"
                  }
                ]
              }
            },
            "airItineraryPricingInfo": {
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
                        "amount": 1.5
                      }
                    ],
                    "amount": 1.5
                  },
                  "fees": {
                    "fee": [
                      {
                        "feeCode": "FE1",
                        "amount": 75
                      },
                      {
                        "feeCode": "VAT",
                        "amount": 11.25
                      }
                    ],
                    "currencyCode": "SAR",
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
                    "airport": []
                  }
                ]
              },
              "quoteID": "N6G2NW",
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
                              "amount": 1.5
                            }
                          ],
                          "amount": 1.5
                        },
                        "fees": {
                          "fee": [
                            {
                              "feeCode": "FE1",
                              "amount": 75
                            },
                            {
                              "feeCode": "VAT",
                              "amount": 11.25
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
            "notes": [],
            "ticketingInfo": {
              "ticketAdvisory": [],
              "ticketTimeLimit": "2024-03-15T13:43:14.000+03:00",
              "ticketType": "E_TICKET",
              "flightSegmentRefNumber": [
                "1"
              ],
              "travelerRefNumber": [],
              "miscTicketingCode": [],
              "deliveryInfo": [],
              "paymentType": []
            },
            "sequenceNumber": 1
          }
        ]
      },
      "bookingReferenceID": {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "N6G2NW"
      },
      "version": 2.001
    }
  </pre>
</details>

#### AirPriceRQ for Round trip

<details>
  <summary><b>Payload</b></summary>
  <h4>Request</h4>
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
                  "departureDateTime": "2024-04-17T09:00:00.000+03:00",
                  "arrivalDateTime": "2024-04-17T11:25:00.000+03:00",
                  "rph": "1",
                  "marketingAirline": {
                    "code": "HHR"
                  },
                  "flightNumber": "0080",
                  "resBookDesigCode": "Y",
                  "fareBasisCode": "testEco",
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
                    "flightNumber": "1151"
                  },
                  "equipment": [],
                  "departureDateTime": "2024-04-18T16:30:00.000+03:00",
                  "arrivalDateTime": "2024-04-18T18:50:00.000+03:00",
                  "rph": "2",
                  "marketingAirline": {
                    "code": "HHR"
                  },
                  "flightNumber": "1151",
                  "resBookDesigCode": "Y",
                  "fareBasisCode": "testEco",
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
            "qualifier": "4"
          }
        ],
        "airTravelerAvail": [
          {
            "passengerTypeQuantity": [
              {
                "code": "ADT",
                "quantity": 5
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
                "middleName": [
                  "Junior"
                ],
                "surname": "TESTER"
              },
              "email": [
                {
                  "value": "tester@example.com"
                }
              ],
              "telephone": [
                {
                  "countryAccessCode": "380",
                  "phoneNumber": "671234567"
                }
              ],
              "document": [
                {
                  "docHolderNationality": "UA",
                  "birthDate": "1979-01-01"
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
      "bookingReferenceID": {
        "companyName": {
          "code": "W1"
        },
        "type": "14",
        "id": "QLRCQG"
      },
      "pricedItineraries": {
        "pricedItinerary": [
          {
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
                        "departureDateTime": "2024-04-17T09:00:00.000+03:00",
                        "arrivalDateTime": "2024-04-17T11:25:00.000+03:00",
                        "rph": "1",
                        "marketingAirline": {
                          "code": "HHR"
                        },
                        "flightNumber": "0080",
                        "resBookDesigCode": "Y",
                        "bookingClassAvails": [
                          {
                            "bookingClassAvail": [
                              {
                                "resBookDesigCode": "Y",
                                "resBookDesigQuantity": "212",
                                "resBookDesigStatusCode": "A"
                              }
                            ]
                          }
                        ],
                        "comment": [],
                        "stopLocation": []
                      }
                    ],
                    "rph": "1"
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
                          "flightNumber": "1151"
                        },
                        "equipment": [],
                        "departureDateTime": "2024-04-18T16:30:00.000+03:00",
                        "arrivalDateTime": "2024-04-18T18:50:00.000+03:00",
                        "rph": "2",
                        "marketingAirline": {
                          "code": "HHR"
                        },
                        "flightNumber": "1151",
                        "resBookDesigCode": "Y",
                        "bookingClassAvails": [
                          {
                            "bookingClassAvail": [
                              {
                                "resBookDesigCode": "Y",
                                "resBookDesigQuantity": "77",
                                "resBookDesigStatusCode": "A"
                              }
                            ]
                          }
                        ],
                        "comment": [],
                        "stopLocation": []
                      }
                    ],
                    "rph": "2"
                  }
                ]
              }
            },
            "airItineraryPricingInfo": {
              "itinTotalFare": [
                {
                  "baseFare": {
                    "currencyCode": "SAR",
                    "amount": 2000
                  },
                  "equivFare": [],
                  "taxes": {
                    "tax": [
                      {
                        "taxCode": "VAT",
                        "amount": 300
                      }
                    ],
                    "amount": 300
                  },
                  "fees": {
                    "fee": [
                      {
                        "feeCode": "FE1",
                        "amount": 150
                      },
                      {
                        "feeCode": "VAT",
                        "amount": 22.5
                      }
                    ],
                    "currencyCode": "SAR",
                    "amount": 172.5
                  },
                  "totalFare": {
                    "currencyCode": "SAR",
                    "amount": 2472.5
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
                        "value": "testEco"
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
                    "airport": []
                  },
                  {
                    "fareReference": [
                      {
                        "value": "testEco"
                      }
                    ],
                    "filingAirline": {
                      "value": "HHR"
                    },
                    "marketingAirline": [],
                    "departureAirport": {
                      "locationCode": "DMX"
                    },
                    "arrivalAirport": {
                      "locationCode": "MKX"
                    },
                    "date": [],
                    "fareInfo": [],
                    "city": [],
                    "airport": []
                  }
                ]
              },
              "quoteID": "QLRCQG",
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
                          "value": "testEco",
                          "flightSegmentRPH": "1"
                        }
                      ]
                    },
                    "passengerFare": [
                      {
                        "baseFare": {
                          "currencyCode": "SAR",
                          "amount": 1000
                        },
                        "equivFare": [],
                        "taxes": {
                          "tax": [
                            {
                              "taxCode": "VAT",
                              "amount": 150
                            }
                          ],
                          "amount": 150
                        },
                        "fees": {
                          "fee": [
                            {
                              "feeCode": "FE1",
                              "amount": 75
                            },
                            {
                              "feeCode": "VAT",
                              "amount": 11.25
                            }
                          ],
                          "amount": 86.25
                        },
                        "totalFare": {
                          "currencyCode": "SAR",
                          "amount": 1236.25
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
                    "fareInfo": [
                      {
                        "fareReference": [
                          {
                            "value": "testEco",
                            "resBookDesigCode": "Y",
                            "accountCode": "testEco"
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
                      "quantity": 5
                    },
                    "fareBasisCodes": {
                      "fareBasisCode": [
                        {
                          "value": "testEco",
                          "flightSegmentRPH": "2"
                        }
                      ]
                    },
                    "passengerFare": [
                      {
                        "baseFare": {
                          "currencyCode": "SAR",
                          "amount": 1000
                        },
                        "equivFare": [],
                        "taxes": {
                          "tax": [
                            {
                              "taxCode": "VAT",
                              "amount": 150
                            }
                          ],
                          "amount": 150
                        },
                        "fees": {
                          "fee": [
                            {
                              "feeCode": "FE1",
                              "amount": 75
                            },
                            {
                              "feeCode": "VAT",
                              "amount": 11.25
                            }
                          ],
                          "amount": 86.25
                        },
                        "totalFare": {
                          "currencyCode": "SAR",
                          "amount": 1236.25
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
                    "fareInfo": [
                      {
                        "fareReference": [
                          {
                            "value": "testEco",
                            "resBookDesigCode": "Y",
                            "accountCode": "testEco"
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
                  }
                ]
              }
            },
            "notes": [],
            "ticketingInfo": {
              "ticketAdvisory": [],
              "ticketTimeLimit": "2024-03-26T01:31:28.000+03:00",
              "ticketType": "E_TICKET",
              "flightSegmentRefNumber": [
                "1"
              ],
              "travelerRefNumber": [],
              "miscTicketingCode": [],
              "deliveryInfo": [],
              "paymentType": []
            },
            "sequenceNumber": 1
          }
        ]
      },
      "version": 2.001
    }
  </pre>
</details>
---

### ✅ Required Fields Summary

This section lists the required fields for each booking type to help ensure proper request formatting.

#### 🧍 Regular Booking (AirBookRQ)

| Field                            | Location      | Description                                                       |
|----------------------------------|---------------|-------------------------------------------------------------------|
| `version`                        | Root          | API version (e.g., "2.001")                                       |
| `pos.source[].requestorID.id`    | Payload       | Agent ID                                                          |
| `pos.source[].requestorID.name`  | Payload       | Agency ID                                                         |
| `pos.source[].bookingChannel`    | Payload       | Must include `type: "OTA"`                                        |
| `airItinerary.originDestinationOptions` | Payload | Flight segment details                                            |
| `travelerInfo.airTraveler`       | Payload       | List of passengers with full details                              |
| `airTraveler.passengerTypeCode`        | Payload       | Must include a "CTC" contact passenger                            |
| `personName.givenName`, `surname`      | CTC traveler  | Contact person name                                               |
| `email`, `telephone` (optional)        | CTC traveler  | Contact details                                                   |
| `passengerTypeCode`              | Each traveler | Passenger type code: “ADT” (Adult), “CHD” (Child), “INF” (Infant) |
| `personName.givenName`, `surname`| Each traveler | Passenger name                                                    |
| `document[]`                     | Each traveler | Document information                                              |
| `email`, `telephone` (optional)              | Each traveler | Contact details                                                   |

#### 👥 Group Booking (AirPriceRQ)

| Field                                                                  | Location      | Description                            |
|------------------------------------------------------------------------|---------------|----------------------------------------|
| `version`                                                              | Root          | API version (e.g., "2.001")            |
| `pos.source[].requestorID.id`                                          | Payload       | Agent ID                               |
| `pos.source[].requestorID.name`                                        | Payload       | Agency ID                              |
| `pos.source[].bookingChannel`                                          | Payload       | Must include `type: "OTA"`           |
| `airItinerary.originDestinationOptions`                                | Payload       | Flight segment details                 |
| `travelerInfoSummary.airTravelerAvail[].passengerTypeQuantity`         | Payload | Required passenger quantities including `code` and `quantity` |
| `passengerTypeQuantity.code`                                           | Payload  | Passenger type code: "ADT" (Adult), "CHD" (Child), "INF" (Infant) |
| `passengerTypeQuantity.quantity`                                       | Payload  | Number of passengers for the given type                        |
| `travelerInfoSummary.airTravelerAvail[].airTraveler`                               | Payload       | List of passengers with full details |
| `airTraveler.passengerTypeCode`        | Payload       | Must include a "CTC" contact passenger |
| `personName.givenName`, `surname`                                      | CTC traveler  | Contact person name                    |
| `email`, `telephone` (optional)                                        | CTC traveler  | Contact details                        |
| `airTraveler.passengerTypeCode`                                        | Each traveler | Passenger type code: “ADT” (Adult), “CHD” (Child), “INF” (Infant)                   |
| `personName.givenName`, `surname`                                      | Each traveler | Passenger name                       |
| `document[]`                                                           | Each traveler | Document information  |
| `email`, `telephone` (optional)                                        | Each traveler | Contact details                      |

> 💡 *Note: The contact (CTC) passenger is required in both booking types for reference purposes.*

### 📄 Required Fields in `document[]`

For each traveler (excluding the contact traveler, i.e., `CTC`), the following fields in the `document[]` array are required:

| Field                   | Required | Description                                                                             |
|-------------------------|----------|-----------------------------------------------------------------------------------------|
| `docID`                 | ✅       | Passport or national ID number                                                          |
| `docType`               | ✅       | Type of document (e.g., "2" for passport) [Document Type](../OTA_API_SAR#document-type) |
| `docHolderNationality`  | ✅       | ISO country code (e.g., "SA" for Saudi Arabia)                                          |
| `birthDate`             | ✅       | Traveler's birth date in `YYYY-MM-DD` format                                            |
| `expireDate`            | ✅       | Document expiration date in `YYYY-MM-DD` format                                         |

> 💡 *All fields must be present for each traveler except the contact (`CTC`) passenger.*

#### Example

```json
"document": [
  {
    "docID": "0123456789",
    "docType": "5",
    "docHolderNationality": "SA",
    "birthDate": "1979-01-01",
    "expireDate": "2027-12-12"
  }
]
```

#### Group Booking Completion Policy
> **Note:** Group bookings can be created and confirmed on HHR, but ticket issuance requires passenger information. Customers must complete the booking within 72 hours.