### Seat Map

This method returns the seat map for some given flights. Seat maps can be requested for a booking once it has been paid.

#### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token](#api-key) |
| local-name   | Header  | Custom HTTP header | OTA_AirSeatMapRQ             |
| agentId      | Payload |                    | ota                      |
| agencyId     | Payload |                    | ota                      |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

<details open>
  <summary><b>One Way Request Payload</b></summary>
  <pre>
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
                    "id": "<ins>agentId</ins>",
                    "name": "<ins>agentId</ins>"
                }
            }
        ]
    },
    "seatMapRequests": {
        "seatMapRequest": [
            {
                "flightSegmentInfo": {
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
                    "departureDateTime": "2026-09-14T10:21:00.000+03:00",
                    "arrivalDateTime": "2026-09-14T10:55:00.000+03:00",
                    "rph": "1",
                    "marketingAirline": {
                        "code": "HHR"
                    },
                    "flightNumber": "0081",
                    "fareBasisCode": "NOTCANCEL",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [],
                    "comment": [],
                    "stopLocation": [],
                    "status": "30",
                    "tpaextensions": {
                        "seatDetails": [
                            {
                                "coach": "006",
                                "seat": "116",
                                "seatType": "aisle"
                            }
                        ]
                    }
                },
                "travelerRefNumberRPHs": [
                    "1"
                ]
            }
        ]
    },
    "airTravelers": {
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
                        "BESSIE"
                    ],
                    "middleName": [],
                    "surname": "MACK",
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
                        "birthDate": "1979-01-01"
                    },
                    {
                        "docLimitations": [],
                        "docID": "11234567896",
                        "docType": "5",
                        "docHolderNationality": "SA",
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
                "gender": "Female",
                "comment": []
            }
        ]
    },
    "bookingReferenceID": [
        {
            "companyName": {
                "code": "W1"
            },
            "type": "14",
            "id": "48A22J"
        }
    ]
}  </pre>
</details>

In the above request:
* `pos` point of sale information for the booking.
* `seatMapRequests` is an object compromising of:
  *  `seatMapRequest` which is a list of request for each segment to get seat map for. Each request must include:
  * `flightSegmentInfo`, the details of the flight.
  * `travelerRefNumberRPHs`, a list of at least one traveller to get seat map for. This links to the `airTravelers` section in the request.
* `airTravelers` is the list of travellers in the booking.
* `bookingReferenceID` is the booking reference of the booking.

Both `flightSegmentInfo` and `travelerRefNumberRPHs` can be acquired from the `OTA_Read` response of the booking.

<details open>
<summary><b>Round Trip Request Payload</b></summary>
<pre>
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
          "id": "<ins>agentId</ins>",
          "name": "<ins>agentId</ins>"
        }
      }
    ]
  },
  "seatMapRequests": {
    "seatMapRequest": [
      {
        "flightSegmentInfo": {
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
          "departureDateTime": "2026-09-14T10:21:00.000+03:00",
          "arrivalDateTime": "2026-09-14T10:55:00.000+03:00",
          "rph": "1",
          "marketingAirline": {
            "code": "HHR"
          },
          "flightNumber": "0081",
          "fareBasisCode": "NOTCANCEL",
          "resBookDesigCode": "Y",
          "bookingClassAvails": [],
          "comment": [],
          "stopLocation": [],
          "status": "30",
          "tpaextensions": {
            "seatDetails": [
              {
                "coach": "006",
                "seat": "116",
                "seatType": "aisle"
              }
            ]
          }
        },
        "travelerRefNumberRPHs": [
          "1"
        ]
      },
      {
        "flightSegmentInfo": {
          "departureAirport": {
            "locationCode": "MKX"
          },
          "arrivalAirport": {
            "locationCode": "JDX"
          },
          "operatingAirline": {
            "code": "HHR",
            "flightNumber": "0080"
          },
          "equipment": [],
          "departureDateTime": "2026-09-15T10:21:00.000+03:00",
          "arrivalDateTime": "2026-09-15T10:55:00.000+03:00",
          "rph": "2",
          "marketingAirline": {
            "code": "HHR"
          },
          "flightNumber": "0080",
          "fareBasisCode": "NOTCANCEL",
          "resBookDesigCode": "Y",
          "bookingClassAvails": [],
          "comment": [],
          "stopLocation": [],
          "status": "30",
          "tpaextensions": {
            "seatDetails": [
              {
                "coach": "006",
                "seat": "118",
                "seatType": "aisle"
              }
            ]
          }
        },
        "travelerRefNumberRPHs": [
          "1"
        ]
      }
    ]
  },
  "airTravelers": {
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
            "BESSIE"
          ],
          "middleName": [],
          "surname": "MACK",
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
            "birthDate": "1979-01-01"
          },
          {
            "docLimitations": [],
            "docID": "11234567896",
            "docType": "5",
            "docHolderNationality": "SA",
            "expireDate": "2027-12-12"
          }
        ],
        "travelerRefNumber": {
          "rph": "1"
        },
        "flightSegmentRPHs": {
          "flightSegmentRPH": [
            "1", "2"
          ]
        },
        "socialMediaInfo": [],
        "passengerTypeCode": "ADT",
        "gender": "Female",
        "comment": []
      }
    ]
  },
  "bookingReferenceID": [
    {
      "companyName": {
        "code": "W1"
      },
      "type": "14",
      "id": "48A22J"
    }
  ]
}</pre>
</details>


<details open>
  <summary><b>Response Payload</b></summary>
  <pre>
{
  "seatMapResponses": {
    "seatMapResponse": [
      {
        "flightSegmentInfo": {
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
          "departureDateTime": "2026-09-14T10:21:00.000+03:00",
          "arrivalDateTime": "2026-09-14T10:55:00.000+03:00",
          "rph": "1",
          "marketingAirline": {
            "code": "HHR"
          },
          "flightNumber": "0081",
          "fareBasisCode": "NOTCANCEL",
          "resBookDesigCode": "Y"
        },
        "seatMapDetails": [
          {
            "cabinClass": [
              {
                "availabilityList": [
                  {
                    "seatNumber": "138",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "139",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "140",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "141",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "142",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "143",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "144",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "145",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "146",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "147",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "148",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "149",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "150",
                    "availableInd": false,
                    "occupiedInd": true
                  },
                  {
                    "seatNumber": "151",
                    "availableInd": false,
                    "occupiedInd": true
                  }
                ],
                "rowInfo": [
                  {
                    "characteristics": [],
                    "description": [],
                    "seatInfo": [
                      {
                        "summary": {
                          "seatNumber": "142",
                          "rowNumber": 2,
                          "seatSequenceNumber": 142,
                          "availableInd": false,
                          "occupiedInd": true
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_OCCUPIED"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "BOOKED"
                          }
                        ],
                        "columnNumber": 4
                      },
                      {
                        "summary": {
                          "seatNumber": "143",
                          "rowNumber": 2,
                          "seatSequenceNumber": 143,
                          "availableInd": false,
                          "occupiedInd": true
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_OCCUPIED"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "BOOKED"
                          }
                        ],
                        "columnNumber": 3
                      },
                      {
                        "summary": {
                          "seatNumber": "144",
                          "rowNumber": 2,
                          "seatSequenceNumber": 144,
                          "availableInd": false,
                          "occupiedInd": true
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_RESERVED"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "ACTIVE"
                          }
                        ],
                        "columnNumber": 1
                      },
                      {
                        "summary": {
                          "seatNumber": "145",
                          "rowNumber": 2,
                          "seatSequenceNumber": 145,
                          "availableInd": false,
                          "occupiedInd": true
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_OCCUPIED"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "BOOKED"
                          }
                        ],
                        "columnNumber": 0
                      }
                    ],
                    "gridNumber": 2,
                    "cabinType": "T",
                    "rowNumber": 2
                  },
                  {
                    "characteristics": [],
                    "description": [],
                    "seatInfo": [
                      {
                        "summary": {
                          "seatNumber": "138",
                          "rowNumber": 3,
                          "seatSequenceNumber": 138,
                          "availableInd": false,
                          "occupiedInd": true
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_OCCUPIED"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "BOOKED"
                          }
                        ],
                        "columnNumber": 4
                      },
                      {
                        "summary": {
                          "seatNumber": "139",
                          "rowNumber": 3,
                          "seatSequenceNumber": 139,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 3
                      },
                      {
                        "summary": {
                          "seatNumber": "140",
                          "rowNumber": 3,
                          "seatSequenceNumber": 140,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 1
                      },
                      {
                        "summary": {
                          "seatNumber": "141",
                          "rowNumber": 3,
                          "seatSequenceNumber": 141,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 0
                      }
                    ],
                    "gridNumber": 3,
                    "cabinType": "T",
                    "rowNumber": 3
                  }
                ],
                "zone": [
                  {
                    "id": "52730000060000",
                    "code": "006",
                    "name": "006",
                    "description": "6",
                    "totalSeatQty": 38,
                    "type": "T"
                  }
                ],
                "columnSpan": 5,
                "startingRow": "0",
                "endingRow": "10"
              },
              {
                "availabilityList": [
                  {
                    "seatNumber": "184",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "185",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "186",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "187",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "188",
                    "availableInd": true,
                    "occupiedInd": false
                  },
                  {
                    "seatNumber": "189",
                    "availableInd": true,
                    "occupiedInd": false
                  }
                ],
                "rowInfo": [
                  {
                    "characteristics": [],
                    "description": [],
                    "seatInfo": [
                      {
                        "summary": {
                          "seatNumber": "188",
                          "rowNumber": 0,
                          "seatSequenceNumber": 188,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 4
                      },
                      {
                        "summary": {
                          "seatNumber": "189",
                          "rowNumber": 0,
                          "seatSequenceNumber": 189,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 3
                      }
                    ],
                    "gridNumber": 0,
                    "cabinType": "T",
                    "rowNumber": 0
                  },
                  {
                    "characteristics": [],
                    "description": [],
                    "seatInfo": [
                      {
                        "summary": {
                          "seatNumber": "184",
                          "rowNumber": 1,
                          "seatSequenceNumber": 184,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 4
                      },
                      {
                        "summary": {
                          "seatNumber": "185",
                          "rowNumber": 1,
                          "seatSequenceNumber": 185,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 3
                      },
                      {
                        "summary": {
                          "seatNumber": "186",
                          "rowNumber": 1,
                          "seatSequenceNumber": 186,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "AISLE"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 1
                      },
                      {
                        "summary": {
                          "seatNumber": "187",
                          "rowNumber": 1,
                          "seatSequenceNumber": 187,
                          "availableInd": true,
                          "occupiedInd": false
                        },
                        "amenity": [],
                        "availability": {
                          "value": "SEAT_AVAILABLE"
                        },
                        "description": [],
                        "features": [
                          {
                            "value": "WINDOW"
                          },
                          {
                            "value": "OTHER",
                            "extension": "ForwardFacing"
                          }
                        ],
                        "service": [],
                        "status": [
                          {
                            "value": "AVAILABLE"
                          }
                        ],
                        "columnNumber": 0
                      }
                    ],
                    "gridNumber": 1,
                    "cabinType": "T",
                    "rowNumber": 1
                  }
                ],
                "zone": [
                  {
                    "id": "52730000070000",
                    "code": "007",
                    "name": "007",
                    "description": "7",
                    "totalSeatQty": 38,
                    "type": "T"
                  }
                ],
                "columnSpan": 5,
                "startingRow": "0",
                "endingRow": "10"
              }
            ],
            "travelerRefNumberRPHs": [
              "1"
            ]
          }
        ],
        "bookingReferenceID": [
          {
            "companyName": {
              "code": "W1"
            },
            "type": "14",
            "id": "48A22J"
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "632411C25"
          }
        ]
      }
    ]
  }
}  </pre>
</details>

In the above response:
* `seatMapResponse` is a list of seat map for each requested segment. Each response consists of:
  * `flightSegmentInfo`, the details of the flight the seat map is for.
  * `seatMapDetails`, a list of seat map of the flight, where each one includes:
    * `cabinClass`, a list of details for each cabin/coach of the segment. Each cabin/coach includes:
      * `availabilityList`, a list of seat availabilities within the cabin.
      * `rowInfo`, list of information for each row within the cabin. Each row includes:
        * `seatInfo`, a list of seat information in the row. Each seat includes:
          * `summary`, information about the seat.
          * `availability`, the availability of the seat. The possible values are: `SEAT_AVAILABLE`, `SEAT_OCCUPIED` (seat booked by other passengers), `SEAT_RESERVED` (seat currently booked by the requested passenger).
          * `features`, a list the seat's features. Currently supported features are: `WINDOW`, `AISLE`, `OTHER` (ForwardFacing or BackwardFacing).
          * `status`, the seat's status. The possible values are: `AVAILABLE`, `BOOKED`, `ACTIVE` (seat currently booked by the requested passenger).
          * `columnNumber`, the column number of the seat.
        * `gridNumber`, the grid number of the seat map.
        * `cabinType`, the cabin type of the seat map. The possible values are: `P` (business), and `T` (economy).
        * `rowNumber`, the row number of the seat map.
      * `zone`, the zone information of the cabin. Consists of:
        * `id`, the zone ID.
        * `code`, the zone code.
        * `name`, the zone name.
        * `description`, the zone description.
        * `totalSeatQty`, the total number of seats in the cabin.
        * `type`, the cabin class. The possible values are: `P` (business), and `T` (economy).
      * `columnSpan`, the number of columns in the seat map.
      * `startingRow`, the starting row of the seat map.
      * `endingRow`, the ending row of the seat map.`
  * `bookingReferenceID`, the booking reference of the booking.

For how to update the seat of a passenger, see the [Modify booking for seat change](modify-booking.md#seat-change) section.