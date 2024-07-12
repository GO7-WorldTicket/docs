## Modify booking

Supported modification types:

| Operation             | Type | Description                                                                                                                                                                  |
|-----------------------|------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Cancel passenger      | 2    | Cancels individual passenger. See also [Cancel booking](#cancel-booking)                                                                                                     |
| Change passenger name | 4    | Changes passenger name. This operation is essential for group bookings when passenger names are unknown at booking creation time and could be updated later after ticketing. |
| Change passenger info | 40   | Changes other passenger information than name.                                                                                                                               |
| Split booking         | 7    | Moves passenger or segment into a new booking.                                                                                                                               | 
| Change contact        | 9    | Changes contact information such as email or pone number.                                                                                                                    |
| Cancel segment        | 10   | Cancels individual segment. See also [Cancel booking](#cancel-booking)                                                                                                       |
| Rebook segment        | 20   | This covers change of the flight or train, and upgrade of the booking class.                                                                                                 |


### Request Parameters

| Parameter  | Type    | Description        | Example                  |
| ---------- | ------- | ------------------ | ------------------------ |
| x-api-key  | Header  | Access Token       | [Access token](#api-key) |
| local-name | Header  | Custom HTTP header | OTA_AirBookModifyRQ      |
| agentId    | Payload | Custom HTTP header | ota                      |
| agencyId   | Payload | Custom HTTP header | ota                      |


#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

### Change passenger name
`Changes to the passenger name may not permitted after the booking is paid and tickets are issued.`


#### Change Passenger in One Way Booking

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
              "location": "CPH"
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
      "airBookModifyRQ": {
        "modificationType": "3",
        "travelerInfo": {
          "airTraveler": [
            {
              "personName": {
                "namePrefix": [],
                "givenName": [
                  "KITTY"
                ],
                "middleName": [],
                "surname": "TESTER",
                "nameSuffix": [],
                "nameTitle": []
              },
              "telephone": [
                {
                  "countryAccessCode": "380",
                  "phoneNumber": "123456"
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
                    "code": "SA"
                  }
                }
              ],
              "custLoyalty": [],
              "document": [],
              "socialMediaInfo": [],
              "birthDate": "1979-01-01",
              "passengerTypeCode": "CTC",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MISS"
                ],
                "givenName": [
                  "PETER"
                ],
                "middleName": [
                  "PAXXXX"
                ],
                "surname": "TEST"
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
                "middleName": [
                  "RPAXXXX"
                ],
                "givenName": [
                  "ROSE"
                ],
                "surname": "TEST"
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
                  "MISS"
                ],
                "givenName": [
                  "SANDRA"
                ],
                "surname": "TEST"
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
                  "birthDate": "1999-01-01"
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
                "surname": "TEST"
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
                  "birthDate": "1999-01-01"
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
              "gender": "Male",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MISS"
                ],
                "givenName": [
                  "NADIA"
                ],
                "surname": "TEST"
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
                  "birthDate": "1999-01-15"
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
              "gender": "Female",
              "comment": []
            }
          ]
        }
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
        "travelerInfo": {
          "airTraveler": [
            {
              "personName": {
                "namePrefix": [],
                "givenName": [
                  "KITTY"
                ],
                "middleName": [],
                "surname": "TESTER",
                "nameSuffix": [],
                "nameTitle": []
              },
              "telephone": [
                {
                  "countryAccessCode": "380",
                  "phoneNumber": "123456"
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
                    "code": "SA"
                  }
                }
              ],
              "custLoyalty": [],
              "document": [],
              "socialMediaInfo": [],
              "birthDate": "1979-01-01",
              "passengerTypeCode": "CTC",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MISS"
                ],
                "givenName": [
                  "PETER PAXXXX"
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
                  "ROSE RPAXXXX"
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
                  "MISS"
                ],
                "givenName": [
                  "SANDRA"
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
                  "birthDate": "1999-01-01",
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
              "gender": "Female",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MR"
                ],
                "givenName": [
                  "OKAN"
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
                  "birthDate": "1999-01-01",
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
                  "MISS"
                ],
                "givenName": [
                  "NADIA"
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
                  "birthDate": "1999-01-15",
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
              "gender": "Female",
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
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "2"
            ],
            "ticketDocumentNbr": "3333330007693",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "3"
            ],
            "ticketDocumentNbr": "3333330007694",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "4"
            ],
            "ticketDocumentNbr": "3333330007695",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "5"
            ],
            "ticketDocumentNbr": "3333330007696",
            "miscTicketingCode": []
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
        "createDateTime": "2024-03-15T10:13:21.740Z",
        "emdinfo": []
      },
      "version": 2.001
    }
  </pre>
</details>

#### Change Passenger in Round Trip Booking

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
              "location": "CPH"
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
                    "departureDateTime": "2024-04-12T09:00:00.000+03:00",
                    "arrivalDateTime": "2024-04-12T11:25:00.000+03:00",
                    "rph": "1",
                    "marketingAirline": {
                      "code": "HHR"
                    },
                    "flightNumber": "0080",
                    "fareBasisCode": "testEco",
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
                    "departureDateTime": "2024-04-12T15:30:00.000+03:00",
                    "arrivalDateTime": "2024-04-12T17:55:00.000+03:00",
                    "rph": "2",
                    "marketingAirline": {
                      "code": "HHR"
                    },
                    "flightNumber": "0141",
                    "fareBasisCode": "testEco",
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
                "amount": 2000
              },
              "equivFare": [],
              "taxes": {
                "tax": [
                  {
                    "taxCode": "VAT",
                    "currencyCode": "SAR",
                    "amount": 300
                  }
                ],
                "amount": 300
              },
              "fees": {
                "fee": [
                  {
                    "feeCode": "FE1",
                    "currencyCode": "SAR",
                    "amount": 150
                  },
                  {
                    "feeCode": "VAT",
                    "currencyCode": "SAR",
                    "amount": 22.5
                  },
                  {
                    "feeCode": "VAT_VAT",
                    "currencyCode": "SAR",
                    "amount": 0
                  }
                ],
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
                "airport": [],
                "rph": "1"
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
                "airport": [],
                "rph": "2"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
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
                    "value": "testEco"
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
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "5"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "6"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "7"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "8"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "9"
              },
              {
                "fareReference": [
                  {
                    "value": "testEco"
                  }
                ],
                "marketingAirline": [],
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "rph": "10"
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
                          "taxName": "VAT",
                          "currencyCode": "SAR",
                          "amount": 150
                        }
                      ],
                      "amount": 150
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
                          "taxName": "VAT",
                          "currencyCode": "SAR",
                          "amount": 150
                        }
                      ],
                      "amount": 150
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
                  "John Junior"
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
              "birthDate": "1979-01-01",
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
                  "1",
                  "2"
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
                  "1",
                  "2"
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
                  "1",
                  "2"
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
                  "1",
                  "2"
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
                  "1",
                  "2"
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
            "ticketDocumentNbr": "3333330011359",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "2"
            ],
            "ticketDocumentNbr": "3333330011360",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "3"
            ],
            "ticketDocumentNbr": "3333330011361",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "4"
            ],
            "ticketDocumentNbr": "3333330011362",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "5"
            ],
            "ticketDocumentNbr": "3333330011363",
            "passengerTypeCode": "ADT",
            "miscTicketingCode": [],
            "tpaExtensions": {
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
              "code": "W1"
            },
            "type": "14",
            "id": "9LB26F",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "4EA2FB6AF",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "10F629AE8",
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
              "id": "1393341",
              "tpaExtensions": {
                "orderInfo": {
                  "action": "CREATE_BOOKING",
                  "currencyCode": "SAR",
                  "direction": "PAYMENT",
                  "orderType": "BOOKING",
                  "status": "PAID",
                  "totalAmount": "2472.50"
                }
              }
            }
          ],
          "purchased": []
        },
        "createDateTime": "2024-03-22T08:48:07.022Z",
        "emdinfo": []
      },
      "airBookModifyRQ": {
        "modificationType": "3",
        "travelerInfo": {
          "airTraveler": [
            {
              "personName": {
                "namePrefix": [],
                "givenName": [
                  "KITTY"
                ],
                "middleName": [],
                "surname": "TESTER",
                "nameSuffix": [],
                "nameTitle": []
              },
              "telephone": [
                {
                  "countryAccessCode": "380",
                  "phoneNumber": "123456"
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
                    "code": "SA"
                  }
                }
              ],
              "custLoyalty": [],
              "document": [],
              "socialMediaInfo": [],
              "birthDate": "1979-01-01",
              "passengerTypeCode": "CTC",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MISS"
                ],
                "givenName": [
                  "PETER"
                ],
                "surname": "TEST"
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
                  "docID": "D0123456789",
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
                  "1",
                  "2"
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
                "surname": "TEST"
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
                  "docID": "A0123456789",
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
                  "1",
                  "2"
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
                "surname": "TEST"
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
                  "docID": "B0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "expireDate": "2027-12-12",
                  "birthDate": "1999-01-01"
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
              "passengerTypeCode": "ADT",
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
                "surname": "TEST"
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
                  "docID": "C0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "expireDate": "2027-12-12",
                  "birthDate": "1999-01-01"
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
                  "NADIA"
                ],
                "surname": "TEST"
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
                  "docID": "E0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "expireDate": "2027-12-12",
                  "birthDate": "1999-01-15"
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
              "gender": "Female",
              "comment": []
            }
          ]
        }
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
                    "departureDateTime": "2024-04-12T09:00:00.000+03:00",
                    "arrivalDateTime": "2024-04-12T11:25:00.000+03:00",
                    "rph": "1",
                    "marketingAirline": {
                      "code": "HHR"
                    },
                    "flightNumber": "0080",
                    "fareBasisCode": "testEco",
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
                    "departureDateTime": "2024-04-12T15:30:00.000+03:00",
                    "arrivalDateTime": "2024-04-12T17:55:00.000+03:00",
                    "rph": "2",
                    "marketingAirline": {
                      "code": "HHR"
                    },
                    "flightNumber": "0141",
                    "fareBasisCode": "testEco",
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
        "travelerInfo": {
          "airTraveler": [
            {
              "personName": {
                "namePrefix": [],
                "givenName": [
                  "KITTY"
                ],
                "middleName": [],
                "surname": "TESTER",
                "nameSuffix": [],
                "nameTitle": []
              },
              "telephone": [
                {
                  "countryAccessCode": "380",
                  "phoneNumber": "123456"
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
                    "code": "SA"
                  }
                }
              ],
              "custLoyalty": [],
              "document": [],
              "socialMediaInfo": [],
              "birthDate": "1979-01-01",
              "passengerTypeCode": "CTC",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MISS"
                ],
                "givenName": [
                  "PETER"
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
                  "value": "tester@example.com"
                }
              ],
              "address": [],
              "custLoyalty": [],
              "document": [
                {
                  "docLimitations": [],
                  "docID": "D0123456789",
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
                  "ROSE"
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
                  "value": "tester@example.com"
                }
              ],
              "address": [],
              "custLoyalty": [],
              "document": [
                {
                  "docLimitations": [],
                  "docID": "A0123456789",
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
                  "MISS"
                ],
                "givenName": [
                  "SANDRA"
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
                  "value": "tester@example.com"
                }
              ],
              "address": [],
              "custLoyalty": [],
              "document": [
                {
                  "docLimitations": [],
                  "docID": "B0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "birthDate": "1999-01-01",
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
              "gender": "Female",
              "comment": []
            },
            {
              "personName": {
                "namePrefix": [
                  "MR"
                ],
                "givenName": [
                  "OKAN"
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
                  "value": "tester@example.com"
                }
              ],
              "address": [],
              "custLoyalty": [],
              "document": [
                {
                  "docLimitations": [],
                  "docID": "C0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "birthDate": "1999-01-01",
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
                  "MISS"
                ],
                "givenName": [
                  "NADIA"
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
                  "value": "tester@example.com"
                }
              ],
              "address": [],
              "custLoyalty": [],
              "document": [
                {
                  "docLimitations": [],
                  "docID": "E0123456789",
                  "docType": "5",
                  "docHolderNationality": "SA",
                  "birthDate": "1999-01-15",
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
              "gender": "Female",
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
            "ticketDocumentNbr": "3333330011359",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "2"
            ],
            "ticketDocumentNbr": "3333330011360",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "3"
            ],
            "ticketDocumentNbr": "3333330011361",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "4"
            ],
            "ticketDocumentNbr": "3333330011362",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "5"
            ],
            "ticketDocumentNbr": "3333330011363",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "1"
            ],
            "ticketDocumentNbr": "3333330011359",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "2"
            ],
            "ticketDocumentNbr": "3333330011360",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "3"
            ],
            "ticketDocumentNbr": "3333330011361",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "4"
            ],
            "ticketDocumentNbr": "3333330011362",
            "miscTicketingCode": []
          },
          {
            "ticketAdvisory": [],
            "ticketType": "E_TICKET",
            "flightSegmentRefNumber": [],
            "travelerRefNumber": [
              "5"
            ],
            "ticketDocumentNbr": "3333330011363",
            "miscTicketingCode": []
          }
        ],
        "bookingReferenceID": [
          {
            "companyName": {
              "code": "W1"
            },
            "type": "14",
            "id": "9LB26F",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "4EA2FB6AF",
            "flightRefNumberRPHList": []
          },
          {
            "companyName": {
              "code": "HHR"
            },
            "type": "14",
            "id": "10F629AE8",
            "flightRefNumberRPHList": []
          }
        ],
        "createDateTime": "2024-03-22T08:48:08.942Z",
        "emdinfo": []
      },
      "version": 2.001
    }
  </pre>
</details>