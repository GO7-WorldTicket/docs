## Cancel Booking by Segments with Automatic Refund.

This method cancels specific segment(s) within a booking together with refunding.

#### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key  | Header  | Access Token       | [Access token](#api-key) |
| local-name | Header  | Custom HTTP header | OTA_AirBookModifyRQ      |
| agentId    | Payload | Custom HTTP header | ota                      |
| agencyId   | Payload | Custom HTTP header | ota                      |

The request payload is composed of these following fields:
* **pos**: PoS information
* **airReservation**: the whole airReservation gotten from ([OTA_ReadRQ](read_booking))
* **airBookModifyRQ**: contains "modificationType":"10" together with "airItinerary" from ([OTA_ReadRQ](read_booking)) containing the flight segment(s) to be cancelled.

<details open>
  <summary><b>Request Payload</b></summary>
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
                    "name": "<ins>agencyId</ins>",
                    "location": "CPH"
                }
            }
        ]
    },
    "airReservation": "{<ins>airReservation from OTA_ReadRQ response</ins>}",
    "airBookModifyRQ": {
        "modificationType": "10",
        "airItinerary": "{<ins>airItinerary from OTA_ReadRQ response with only the specific `flightSegment`s to be cancelled</ins>}"
    }
}
</pre>
</details>

<details>
  <summary><b>Example of Request Payload(Outbound Segment)</b></summary>
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
                    "id": "{{agentId}}",
                    "name": "{{agencyId}}",
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
                                    "locationCode": "DMX"
                                },
                                "arrivalAirport": {
                                    "locationCode": "JED"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8081"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-29T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-29T09:48:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8081",
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
                                    "locationCode": "JED"
                                },
                                "arrivalAirport": {
                                    "locationCode": "DMX"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8080"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-30T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-30T09:48:00.000+03:00",
                                "rph": "2",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8080",
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
                        "amount": 1500.00
                    },
                    "equivFare": [],
                    "taxes": {
                        "tax": [
                            {
                                "taxCode": "VAT",
                                "currencyCode": "SAR",
                                "amount": 225.00
                            }
                        ],
                        "amount": 225.00
                    },
                    "fees": {
                        "fee": [
                            {
                                "feeCode": "VAT_VAT",
                                "currencyCode": "SAR",
                                "amount": 0.00
                            }
                        ],
                        "amount": 0.00
                    },
                    "totalFare": {
                        "currencyCode": "SAR",
                        "amount": 1725.00
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
                                "cancellationTimeLimit": "2026-07-31T06:25:05Z",
                                "confirmationTimeLimit": "2025-07-31T06:54:48Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "DMX"
                        },
                        "arrivalAirport": {
                            "locationCode": "JED"
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
                                "cancellationTimeLimit": "2026-07-31T06:25:05Z",
                                "confirmationTimeLimit": "2025-07-31T06:54:48Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "JED"
                        },
                        "arrivalAirport": {
                            "locationCode": "DMX"
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
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
                            "value": "jjiamtaweeboon@go7.io",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "XMMUQ56302341",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "VPLEI22020697",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "JESAR47407936",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "PBWXC85171457",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "FZDKA38013984",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                "ticketType": "E_TICKET",
                "flightSegmentRefNumber": [
                    "1"
                ],
                "travelerRefNumber": [
                    "1"
                ],
                "ticketDocumentNbr": "3333330322287",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448F3E8985058",
                            "seat": "118"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "09244843A8985061",
                            "seat": "114"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "1"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "1"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322288",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448DDF8985059",
                            "seat": "119"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924481A58985064",
                            "seat": "115"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "2"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "2"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322289",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448CD48985060",
                            "seat": "120"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924480C68985065",
                            "seat": "116"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "3"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "3"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322290",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448AC88985062",
                            "seat": "121"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924483B28985066",
                            "seat": "117"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "4"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "4"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322291",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "0924482CC8985063",
                            "seat": "122"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924483988985067",
                            "seat": "118"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "5"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "5"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=2"
                }
            }
        ],
        "bookingReferenceID": [
            {
                "companyName": {
                    "code": "W1"
                },
                "type": "14",
                "id": "V8LXBO",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "CC1A7683A",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "6C6E69DE1",
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
                    "id": "2090026",
                    "tpaextensions": {
                        "orderInfo": {
                            "action": "CREATE_BOOKING",
                            "currencyCode": "SAR",
                            "direction": "PAYMENT",
                            "orderType": "BOOKING",
                            "status": "PAID",
                            "totalAmount": "1725.00"
                        }
                    }
                }
            ],
            "purchased": []
        },
        "createDateTime": "2025-07-31T06:24:50.463Z",
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
                                    "locationCode": "DMX"
                                },
                                "arrivalAirport": {
                                    "locationCode": "JED"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8081"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-29T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-29T09:48:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8081",
                                "fareBasisCode": "EWTOWM2",
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
        }
    }
}
</pre>
</details>

<details>
  <summary><b>Example of Request Payload(Both Outbound and Inbound Segments)</b></summary>
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
                    "id": "{{agentId}}",
                    "name": "{{agencyId}}",
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
                                    "locationCode": "DMX"
                                },
                                "arrivalAirport": {
                                    "locationCode": "JED"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8081"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-29T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-29T09:48:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8081",
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
                                    "locationCode": "JED"
                                },
                                "arrivalAirport": {
                                    "locationCode": "DMX"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8080"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-30T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-30T09:48:00.000+03:00",
                                "rph": "2",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8080",
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
                        "amount": 1500.00
                    },
                    "equivFare": [],
                    "taxes": {
                        "tax": [
                            {
                                "taxCode": "VAT",
                                "currencyCode": "SAR",
                                "amount": 225.00
                            }
                        ],
                        "amount": 225.00
                    },
                    "fees": {
                        "fee": [
                            {
                                "feeCode": "VAT_VAT",
                                "currencyCode": "SAR",
                                "amount": 0.00
                            }
                        ],
                        "amount": 0.00
                    },
                    "totalFare": {
                        "currencyCode": "SAR",
                        "amount": 1725.00
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
                                "cancellationTimeLimit": "2026-07-31T06:25:05Z",
                                "confirmationTimeLimit": "2025-07-31T06:54:48Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "DMX"
                        },
                        "arrivalAirport": {
                            "locationCode": "JED"
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
                                "cancellationTimeLimit": "2026-07-31T06:25:05Z",
                                "confirmationTimeLimit": "2025-07-31T06:54:48Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "JED"
                        },
                        "arrivalAirport": {
                            "locationCode": "DMX"
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
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
                            "value": "jjiamtaweeboon@go7.io",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "XMMUQ56302341",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "VPLEI22020697",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "JESAR47407936",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "PBWXC85171457",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "FZDKA38013984",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                "ticketType": "E_TICKET",
                "flightSegmentRefNumber": [
                    "1"
                ],
                "travelerRefNumber": [
                    "1"
                ],
                "ticketDocumentNbr": "3333330322287",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448F3E8985058",
                            "seat": "118"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "09244843A8985061",
                            "seat": "114"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "1"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "1"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322287&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322288",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448DDF8985059",
                            "seat": "119"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924481A58985064",
                            "seat": "115"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "2"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "2"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322288&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322289",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448CD48985060",
                            "seat": "120"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924480C68985065",
                            "seat": "116"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "3"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "3"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322289&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322290",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "092448AC88985062",
                            "seat": "121"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924483B28985066",
                            "seat": "117"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "4"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "4"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322290&couponNumber=2"
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
                "ticketDocumentNbr": "3333330322291",
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
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "0924482CC8985063",
                            "seat": "122"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "0924483988985067",
                            "seat": "118"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=1",
                            "rel": "downloadTicket",
                            "segmentRPH": "1",
                            "travelerRPH": "5"
                        },
                        {
                            "href": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=2",
                            "rel": "downloadTicket",
                            "segmentRPH": "2",
                            "travelerRPH": "5"
                        }
                    ],
                    "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=1 https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/V8LXBO/download/passenger-segment?ticketNumber=3333330322291&couponNumber=2"
                }
            }
        ],
        "bookingReferenceID": [
            {
                "companyName": {
                    "code": "W1"
                },
                "type": "14",
                "id": "V8LXBO",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "CC1A7683A",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "6C6E69DE1",
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
                    "id": "2090026",
                    "tpaextensions": {
                        "orderInfo": {
                            "action": "CREATE_BOOKING",
                            "currencyCode": "SAR",
                            "direction": "PAYMENT",
                            "orderType": "BOOKING",
                            "status": "PAID",
                            "totalAmount": "1725.00"
                        }
                    }
                }
            ],
            "purchased": []
        },
        "createDateTime": "2025-07-31T06:24:50.463Z",
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
                                    "locationCode": "DMX"
                                },
                                "arrivalAirport": {
                                    "locationCode": "JED"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8081"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-29T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-29T09:48:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8081",
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
                                    "locationCode": "JED"
                                },
                                "arrivalAirport": {
                                    "locationCode": "DMX"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8080"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-30T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-30T09:48:00.000+03:00",
                                "rph": "2",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8080",
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
</pre>
</details>

#### Response

The response is simliar to `OTA_AirBookRS` response containing:
* **Itinerary**: segment information
* **Traveler**: traveler information
* **Ticketing**: ticket number, coupon status, ticket download URI etc

<details>
  <summary>Response Payload</summary>

  <pre><code>
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
                                    "locationCode": "DMX"
                                },
                                "arrivalAirport": {
                                    "locationCode": "JED"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8081"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-29T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-29T09:48:00.000+03:00",
                                "rph": "1",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8081",
                                "fareBasisCode": "EWTOWM2",
                                "resBookDesigCode": "Y",
                                "bookingClassAvails": [],
                                "comment": [],
                                "stopLocation": [],
                                "status": "16"
                            }
                        ],
                        "rph": "1"
                    },
                    {
                        "flightSegment": [
                            {
                                "departureAirport": {
                                    "locationCode": "JED"
                                },
                                "arrivalAirport": {
                                    "locationCode": "DMX"
                                },
                                "operatingAirline": {
                                    "code": "HHR",
                                    "flightNumber": "8080"
                                },
                                "equipment": [],
                                "departureDateTime": "2025-08-30T08:00:00.000+03:00",
                                "arrivalDateTime": "2025-08-30T09:48:00.000+03:00",
                                "rph": "2",
                                "marketingAirline": {
                                    "code": "HHR"
                                },
                                "flightNumber": "8080",
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
                        "amount": 1500.00
                    },
                    "equivFare": [],
                    "taxes": {
                        "tax": [
                            {
                                "taxCode": "VAT",
                                "currencyCode": "SAR",
                                "amount": 225.00
                            }
                        ],
                        "amount": 225.00
                    },
                    "fees": {
                        "fee": [
                            {
                                "feeCode": "VAT_VAT",
                                "currencyCode": "SAR",
                                "amount": 0.00
                            }
                        ],
                        "amount": 0.00
                    },
                    "totalFare": {
                        "currencyCode": "SAR",
                        "amount": 1725.00
                    },
                    "fareBaggageAllowance": [],
                    "remark": []
                },
                {
                    "baseFare": {
                        "currencyCode": "SAR",
                        "amount": 0.00
                    },
                    "equivFare": [],
                    "taxes": {
                        "tax": [
                            {
                                "taxCode": "VAT",
                                "currencyCode": "SAR",
                                "amount": 0.00
                            }
                        ],
                        "amount": 0.00
                    },
                    "fees": {
                        "fee": [
                            {
                                "feeCode": "REFUND_PENALTY",
                                "feeTransactionType": "charge",
                                "currencyCode": "SAR",
                                "amount": 1500.00
                            },
                            {
                                "feeCode": "REFUND_PENALTY_VAT",
                                "feeTransactionType": "charge",
                                "currencyCode": "SAR",
                                "amount": 225.00
                            }
                        ],
                        "currencyCode": "SAR",
                        "amount": 0
                    },
                    "totalFare": {
                        "currencyCode": "SAR",
                        "amount": 0.00
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
                                "cancellationTimeLimit": "2026-07-31T07:54:11Z",
                                "confirmationTimeLimit": "2025-07-31T08:23:57Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "DMX"
                        },
                        "arrivalAirport": {
                            "locationCode": "JED"
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
                                "cancellationTimeLimit": "2026-07-31T07:54:11Z",
                                "confirmationTimeLimit": "2025-07-31T08:23:57Z",
                                "updateTravellersTimeLimit": "2025-08-26T05:00:00Z"
                            }
                        },
                        "filingAirline": {
                            "value": "HHR"
                        },
                        "marketingAirline": [],
                        "departureAirport": {
                            "locationCode": "JED"
                        },
                        "arrivalAirport": {
                            "locationCode": "DMX"
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
                                },
                                "fareBaggageAllowance": [],
                                "remark": []
                            },
                            {
                                "baseFare": {
                                    "currencyCode": "SAR",
                                    "amount": 0.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "REFUND_PENALTY",
                                            "feeTransactionType": "charge",
                                            "currencyCode": "SAR",
                                            "amount": 750.00
                                        },
                                        {
                                            "feeCode": "REFUND_PENALTY_VAT",
                                            "feeTransactionType": "charge",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "currencyCode": "SAR",
                                    "amount": 0
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 0.00
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
                            "quantity": 5
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
                                    "amount": 750.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "taxName": "VAT",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "amount": 112.50
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "VAT_VAT",
                                            "currencyCode": "SAR",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 862.50
                                },
                                "fareBaggageAllowance": [],
                                "remark": []
                            },
                            {
                                "baseFare": {
                                    "currencyCode": "SAR",
                                    "amount": 0.00
                                },
                                "equivFare": [],
                                "taxes": {
                                    "tax": [
                                        {
                                            "taxCode": "VAT",
                                            "amount": 0.00
                                        }
                                    ],
                                    "amount": 0.00
                                },
                                "fees": {
                                    "fee": [
                                        {
                                            "feeCode": "REFUND_PENALTY",
                                            "feeTransactionType": "charge",
                                            "currencyCode": "SAR",
                                            "amount": 750.00
                                        },
                                        {
                                            "feeCode": "REFUND_PENALTY_VAT",
                                            "feeTransactionType": "charge",
                                            "currencyCode": "SAR",
                                            "amount": 112.50
                                        }
                                    ],
                                    "currencyCode": "SAR",
                                    "amount": 0
                                },
                                "totalFare": {
                                    "currencyCode": "SAR",
                                    "amount": 0.00
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
                            "value": "jjiamtaweeboon@go7.io",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "FNNBJ77490982",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "OPWPE68913003",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "TDEKR58224851",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "YVNCA95062206",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                            "value": "jjiamtaweeboon@go7.io"
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
                            "docID": "GCXJM08262109",
                            "docType": "5",
                            "docHolderNationality": "SA",
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
                "ticketType": "E_TICKET",
                "flightSegmentRefNumber": [
                    "1"
                ],
                "travelerRefNumber": [
                    "1"
                ],
                "ticketDocumentNbr": "3333330322294",
                "passengerTypeCode": "ADT",
                "miscTicketingCode": [],
                "tpaextensions": {
                    "couponInfos": [
                        {
                            "flightRefRPH": "1",
                            "number": "1",
                            "status": "R"
                        },
                        {
                            "flightRefRPH": "2",
                            "number": "2",
                            "status": "R"
                        }
                    ],
                    "couponProviderDetails": [
                        {
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "1053564CA8985078",
                            "seat": "123"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "105356DD68985077",
                            "seat": "119"
                        }
                    ]
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
                "ticketDocumentNbr": "3333330322295",
                "passengerTypeCode": "ADT",
                "miscTicketingCode": [],
                "tpaextensions": {
                    "couponInfos": [
                        {
                            "flightRefRPH": "1",
                            "number": "1",
                            "status": "R"
                        },
                        {
                            "flightRefRPH": "2",
                            "number": "2",
                            "status": "R"
                        }
                    ],
                    "couponProviderDetails": [
                        {
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "1053562028985079",
                            "seat": "124"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "1053569EE8985080",
                            "seat": "120"
                        }
                    ]
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
                "ticketDocumentNbr": "3333330322296",
                "passengerTypeCode": "ADT",
                "miscTicketingCode": [],
                "tpaextensions": {
                    "couponInfos": [
                        {
                            "flightRefRPH": "1",
                            "number": "1",
                            "status": "R"
                        },
                        {
                            "flightRefRPH": "2",
                            "number": "2",
                            "status": "R"
                        }
                    ],
                    "couponProviderDetails": [
                        {
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "105356BD68985083",
                            "seat": "125"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "105356C088985081",
                            "seat": "121"
                        }
                    ]
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
                "ticketDocumentNbr": "3333330322297",
                "passengerTypeCode": "ADT",
                "miscTicketingCode": [],
                "tpaextensions": {
                    "couponInfos": [
                        {
                            "flightRefRPH": "1",
                            "number": "1",
                            "status": "R"
                        },
                        {
                            "flightRefRPH": "2",
                            "number": "2",
                            "status": "R"
                        }
                    ],
                    "couponProviderDetails": [
                        {
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "10535665A8985085",
                            "seat": "126"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "105356A698985082",
                            "seat": "122"
                        }
                    ]
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
                "ticketDocumentNbr": "3333330322298",
                "passengerTypeCode": "ADT",
                "miscTicketingCode": [],
                "tpaextensions": {
                    "couponInfos": [
                        {
                            "flightRefRPH": "1",
                            "number": "1",
                            "status": "R"
                        },
                        {
                            "flightRefRPH": "2",
                            "number": "2",
                            "status": "R"
                        }
                    ],
                    "couponProviderDetails": [
                        {
                            "coach": "006",
                            "flightRefRPH": "1",
                            "providerTicketNumber": "1053561B78985086",
                            "seat": "127"
                        },
                        {
                            "coach": "006",
                            "flightRefRPH": "2",
                            "providerTicketNumber": "1053568298985084",
                            "seat": "123"
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
                "id": "V8LXBO",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "E04E95E56",
                "flightRefNumberRPHList": []
            },
            {
                "companyName": {
                    "code": "HHR"
                },
                "type": "14",
                "id": "7DD72E723",
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
                    "id": "2090040",
                    "tpaextensions": {
                        "orderInfo": {
                            "action": "CREATE_BOOKING",
                            "currencyCode": "SAR",
                            "direction": "PAYMENT",
                            "orderType": "BOOKING",
                            "status": "PAID",
                            "totalAmount": "1725.00"
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
                    "id": "2090041",
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
        "createDateTime": "2025-07-31T07:53:58.386Z",
        "emdinfo": []
    },
    "version": 2.001
}
  </code></pre>
</details>
