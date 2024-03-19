# OTA API Request and Response for SAR integration

## Table of Contents

- [Introduction](#introduction)
- [Business Flow](#business-flow)
- [Authentication](#authentication)
- [Available Routes and Flights](#available-routes-and-flights)
  - [Routes](#routes)
  - [Calendar Availability](#calendar-availability)
- [OTA for Reservation workflow](#ota-for-reservation-workflow)
  - [Low Fare Search](#low-fare-search)
  - [Create a booking](#create-a-booking)
  - [Payment and Ticketing](#payment-and-ticketing)
  - [Read booking](#read-booking)
  - [Modify booking](#modify-booking)

<br><br>

## Change Log

| Change Description               | Changed By          | Change Date |
| -------------------------------- | ------------------- | ----------- |
| Initial creation of the document | Arnon Ruangthanawes | 2024-03-19  |

<br><br>

# Introduction

This document outlines the integration of the Booking API with HHR systems, leveraging it over the OTA API.

<br><br>

## Endpoints

|                   | Production                                 | Test                                            |
| ----------------- | ------------------------------------------ | ----------------------------------------------- |
| Identity Provider | https://auth.worldticket.net/auth/         | https://test-auth.worldticket.net/auth          |
| OTA API           | https://api.worldticket.net/ota/v2015b/OTA | https://test-api.worldticket.net/ota/v2015b/OTA |
| REST API          | https://api.worldticket.net/{service-name} | https://test-api.worldticket.net/{service-name} |
| Routes & Flights  | https://sms.worldticket.net                | https://test.worldticket.net                    |

<br><br>

# Business Flow

This diagram illustrates the API call sequence for searching available trains, creating a reservation, and the intermediate steps required to issue tickets.

![Alt text](../images/business_flow.svg "Business flow")

<br><br>

# Authentication

This section provides the procedures necessary for authorized access. Refer to this section for credentials information and endpoints for the authentication.

|                   | Production                         | Test                                   |
| ----------------- | ---------------------------------- | -------------------------------------- |
| Identity Provider | https://auth.worldticket.net/auth/ | https://test-auth.worldticket.net/auth |

Before calling any OTA method it's mandatory to get access and refresh tokens from the Identity Provider.

Replace all variables in curly braces with the actual values.

| Variable      | Description                         | Example                                |
| ------------- | ----------------------------------- | -------------------------------------- |
| base_url      | Identity provider URL               | https://test-auth.worldticket.net/auth |
| tenant        | Short airline name stands for realm | world-ticket                           |
| client_id     | Application ID                      | sms4                                   |
| client_secret | Application secret                  | 33357c21-3233-4eb3-a420-**\*\*\*\***   |
| username      | User login                          | username                               |
| password      | User password                       | **\*\*\*\***                           |

### Authentication Request and Response

#### Request

```
curl -X POST \
{base_url}/realms/{tenant}/protocol/openid-connect/token \
-H 'Content-Type: application/x-www-form-urlencoded' \
-d 'grant_type=password&client_id=sms4&client_secret={client_secret}&username={username}&password={password}'
```

#### Response

```
{
  "access_token": "eyJhbGciOiJSU...",
  "expires_in": 7200,
  "refresh_expires_in": 14400,
  "refresh_token": "eyJhbGciOiJ...",
  "token_type": "bearer",
  "id_token": "eyJhbGciOiJ...",
  "not-before-policy": 1565113348,
  "session_state": "89fde8f3-39ff-436e-9dce-99387c591fda"
}
```

<br><br>

# Available Routes and Flights

|                  | Production                  | Test                         |
| ---------------- | --------------------------- | ---------------------------- |
| Routes & Flights | https://sms.worldticket.net | https://test.worldticket.net |

## Routes

### Lists all possible city pairs selling by the airline.

#### Request

```
GET /sms-gateway/schedule/routes?sales_channel=OTA
Base URL: https://test-api.worldticket.net
Authorization: ***
```

#### Response

```
[
    {
        "origin": {
            "code": "IEV",
            "name": "KYIV (Zhuliany)",
            "cityName": "KYIV",
            "cityCode": "IEV",
            "country": "UA"
        },
        "destinations": [
            {
                "code": "BUS",
                "name": "BATUMI",
                "cityName": "BATUMI",
                "cityCode": "BUS",
                "country": "GE"
            },
            {
                "code": "TBS",
                "name": "TBILISI (Shota Rustaveli)",
                "cityName": "TBILISI",
                "cityCode": "TBS",
                "country": "GE"
            }
        ]
    },
    {
        "origin": {
            "code": "KRK",
            "name": "Krakow-Balice (John Paul II)",
            "cityName": "Krakow",
            "cityCode": "KRK",
            "country": "PL"
        },
        "destinations": [
            {
                "code": "ODS",
                "name": "ODESA",
                "cityName": "ODESA",
                "cityCode": "ODS",
                "country": "UA"
            }
        ]
    }
]
```

## Calendar Availability

### Lists available dates per route. Usually used in the calendar picker.

#### Request

```
GET /sms-gateway/schedule/calendar/availability?start_date=2023-12-03T00:00:00&end_date=2023-12-28T00:00:00&departure_airport=XMD&arrival_airport=JED&direct=true
Base URL: https://test-api.worldticket.net
Authorization: ***
```

#### Response

```
{
    "departureAirport": "XMK",
    "arrivalAirport": "XMD",
    "startDate": "2024-04-01",
    "endDate": "2024-04-15",
    "dates": [
        "2024-04-01",
        "2024-04-02",
        "2024-04-03",
        "2024-04-04",
        "2024-04-05",
        "2024-04-06",
        "2024-04-07",
        "2024-04-08",
        "2024-04-09",
        "2024-04-10",
        "2024-04-11",
        "2024-04-12",
        "2024-04-13",
        "2024-04-14",
        "2024-04-15"
    ]
}
```

<br><br>

# OTA for Reservation workflow

|         | Production                                 | Test                                            |
| ------- | ------------------------------------------ | ----------------------------------------------- |
| OTA API | https://api.worldticket.net/ota/v2015b/OTA | https://test-api.worldticket.net/ota/v2015b/OTA |

<br>

## Low Fare Search

AirLowFareSearch is used to get flight availability with the lowest fare options for the whole journey, or separately per direction (outbound or inbound).

### List all the fares (AirLowFareSearchRQ)

#### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_AirLowFareSearchRQ               |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
{
  "version": "2.001",
  "pos": {
    "source": [
            {
                "isoCurrency": "SAR",
                "requestorID": {
                    "type": "5",
                    "id": {{agentId}},
                    "name": {{agencyId}}
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
        "locationCode": "JED"
      },
      "destinationLocation": {
        "locationCode": "XMK"
      },
      "departureDateTime": {
        "value": "2023-04-02",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    },
    {
      "originLocation": {
        "locationCode": "XMK"
      },
      "destinationLocation": {
        "locationCode": "XMD"
      },
      "departureDateTime": {
        "value": "2023-04-03",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    },
    {
      "originLocation": {
        "locationCode": "XMD"
      },
      "destinationLocation": {
        "locationCode": "JED"
      },
      "departureDateTime": {
        "value": "2023-04-04",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    },
    {
      "originLocation": {
        "locationCode": "JED"
      },
      "destinationLocation": {
        "locationCode": "XMK"
      },
      "departureDateTime": {
        "value": "2023-04-05",
        "windowBefore": "P0D",
        "windowAfter": "P0D"
      }
    }
  ],
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 2
          }
        ]
      }
    ]
  }
}
```

#### Response

```
{
  "success": {},
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
                      "locationCode": "JED"
                    },
                    "arrivalAirport": {
                      "locationCode": "XMK"
                    },
                    "operatingAirline": {
                      "value": "",
                      "code": "HHR",
                      "flightNumber": "5011"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-04-02T01:35:00.000+03:00",
                    "arrivalDateTime": "2023-04-02T02:29:00.000+03:00",
                    "stopQuantity": 0,
                    "marketingAirline": {
                      "value": "",
                      "code": "HHR"
                    },
                    "flightNumber": "5011",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [
                      {
                        "bookingClassAvail": [
                          {
                            "resBookDesigCode": "Y",
                            "resBookDesigQuantity": "304"
                          }
                        ],
                        "cabinType": "ECONOMY"
                      }
                    ],
                    "comment": [],
                    "stopLocation": [],
                    "status": "34",
                    "tpaextensions": {
                      "airEquipType": "TRN"
                    }
                  }
                ]
              },
              {
                "flightSegment": [
                  {
                    "departureAirport": {
                      "locationCode": "XMK"
                    },
                    "arrivalAirport": {
                      "locationCode": "XMD"
                    },
                    "operatingAirline": {
                      "value": "",
                      "code": "HHR",
                      "flightNumber": "1010"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-04-03T01:00:00.000+03:00",
                    "arrivalDateTime": "2023-04-03T03:20:00.000+03:00",
                    "stopQuantity": 0,
                    "marketingAirline": {
                      "value": "",
                      "code": "HHR"
                    },
                    "flightNumber": "1010",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [
                      {
                        "bookingClassAvail": [
                          {
                            "resBookDesigCode": "Y",
                            "resBookDesigQuantity": "304"
                          }
                        ],
                        "cabinType": "ECONOMY"
                      }
                    ],
                    "comment": [],
                    "stopLocation": [],
                    "status": "34",
                    "tpaextensions": {
                      "airEquipType": "TRN"
                    }
                  }
                ]
              },
              {
                "flightSegment": [
                  {
                    "departureAirport": {
                      "locationCode": "XMD"
                    },
                    "arrivalAirport": {
                      "locationCode": "JED"
                    },
                    "operatingAirline": {
                      "value": "",
                      "code": "HHR",
                      "flightNumber": "7211"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-04-04T21:00:00.000+03:00",
                    "arrivalDateTime": "2023-04-04T22:54:00.000+03:00",
                    "stopQuantity": 0,
                    "marketingAirline": {
                      "value": "",
                      "code": "HHR"
                    },
                    "flightNumber": "7211",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [
                      {
                        "bookingClassAvail": [
                          {
                            "resBookDesigCode": "Y",
                            "resBookDesigQuantity": "304"
                          }
                        ],
                        "cabinType": "ECONOMY"
                      }
                    ],
                    "comment": [],
                    "stopLocation": [],
                    "status": "34",
                    "tpaextensions": {
                      "airEquipType": "TRN"
                    }
                  }
                ]
              },
              {
                "flightSegment": [
                  {
                    "departureAirport": {
                      "locationCode": "JED"
                    },
                    "arrivalAirport": {
                      "locationCode": "XMK"
                    },
                    "operatingAirline": {
                      "value": "",
                      "code": "HHR",
                      "flightNumber": "5011"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-04-05T01:35:00.000+03:00",
                    "arrivalDateTime": "2023-04-05T02:29:00.000+03:00",
                    "stopQuantity": 0,
                    "marketingAirline": {
                      "value": "",
                      "code": "HHR"
                    },
                    "flightNumber": "5011",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [
                      {
                        "bookingClassAvail": [
                          {
                            "resBookDesigCode": "Y",
                            "resBookDesigQuantity": "304"
                          }
                        ],
                        "cabinType": "ECONOMY"
                      }
                    ],
                    "comment": [],
                    "stopLocation": [],
                    "status": "34",
                    "tpaextensions": {
                      "airEquipType": "TRN"
                    }
                  }
                ]
              }
            ]
          }
        },
        "airItineraryPricingInfo": {
          "itinTotalFare": [
            {
              "baseFare": {
                "currencyCode": "USD",
                "amount": 3711.30
              },
              "equivFare": [],
              "fees": {
                "fee": [
                  {
                    "value": "",
                    "feeCode": "VAT_TOTAL",
                    "currencyCode": "USD",
                    "amount": 371.12
                  }
                ]
              },
              "totalFare": {
                "currencyCode": "USD",
                "amount": 4162.42
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
                    "value": "YECOSTD"
                  }
                ],
                "filingAirline": {
                  "value": "HHR"
                },
                "marketingAirline": [],
                "departureAirport": {
                  "value": "",
                  "locationCode": "JED"
                },
                "arrivalAirport": {
                  "value": "",
                  "locationCode": "XMK"
                },
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "tpaextensions": {
                  "priceGroup": "Eco"
                }
              },
              {
                "fareReference": [
                  {
                    "value": "YECOSTD"
                  }
                ],
                "filingAirline": {
                  "value": "HHR"
                },
                "marketingAirline": [],
                "departureAirport": {
                  "value": "",
                  "locationCode": "XMK"
                },
                "arrivalAirport": {
                  "value": "",
                  "locationCode": "XMD"
                },
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "tpaextensions": {
                  "priceGroup": "Eco"
                }
              },
              {
                "fareReference": [
                  {
                    "value": "YECOSTD"
                  }
                ],
                "filingAirline": {
                  "value": "HHR"
                },
                "marketingAirline": [],
                "departureAirport": {
                  "value": "",
                  "locationCode": "XMD"
                },
                "arrivalAirport": {
                  "value": "",
                  "locationCode": "JED"
                },
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "tpaextensions": {
                  "priceGroup": "Eco"
                }
              },
              {
                "fareReference": [
                  {
                    "value": "YECOSTD"
                  }
                ],
                "filingAirline": {
                  "value": "HHR"
                },
                "marketingAirline": [],
                "departureAirport": {
                  "value": "",
                  "locationCode": "JED"
                },
                "arrivalAirport": {
                  "value": "",
                  "locationCode": "XMK"
                },
                "date": [],
                "fareInfo": [],
                "city": [],
                "airport": [],
                "tpaextensions": {
                  "priceGroup": "Eco"
                }
              }
            ]
          }
        },
        "notes": [],
        "sequenceNumber": 1
      }
    ]
  },
  "timeStamp": "2023-02-24T17:25:28.091Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

<br><br>

## Create a booking

The purpose is to create the booking in SMS by providing a specific flight and fare in the request.

There are two types of bookings:

- regular booking
- group booking

### Create a regular booking (AirBookRQ)

### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_AirBookRQ                        |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "{{agentId}}",
          "name": "{{agencyId}}"
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
```

#### Response

```
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
          "tpaextensions": {
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
```

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
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
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
          "name": "{{agencyId}}"
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
```

#### Response

```
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
```

<br><br>

## Payment and Ticketing

The purpose is to make a payment of existing booking in SMS.

Supported payment types:

| Payment Type         | OTA Code |
| -------------------- | -------- |
| External payment     | 32       |
| Credit card          | 5        |
| Cash                 | 1        |
| Debit credit account | 4        |
| Invoice              | 40       |

### Make payment for issuing a ticket (AirDemandTicketRQ)

### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_AirDemandTicketRQ                |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "bookingChannel": {
          "type": "OTA"
        },
        "requestorID": {
          "type": "5",
          "id": "{{agentId}}",
          "name": "{{agencyId}}"
          "location": "CPH"
        },
        "isocountry": "US",
        "isocurrency": "SAR"
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
      "id": "N6G2NW",
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
            "cardHolderName": "TEST TESTER"
          }
        ]
      }
    ]
  }
}
```

#### Response

```
{
  "success": {},
  "bookingReferenceID": {
    "companyName": {
      "companyShortName": "test-skywork-dev",
      "code": "test-skywork-dev"
    },
    "type": "14",
    "id": "N6G2NW"
  },
  "ticketItemInfo": [
    {
      "passengerName": {
        "namePrefix": [
          null
        ],
        "givenName": [
          ""
        ],
        "middleName": [],
        "surname": "",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330007692",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 19.55,
      "paymentType": "4",
      "netAmount": 2
    },
    {
      "passengerName": {
        "namePrefix": [
          null
        ],
        "givenName": [
          ""
        ],
        "middleName": [],
        "surname": "",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330007693",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 19.55,
      "paymentType": "4",
      "netAmount": 2
    },
    {
      "passengerName": {
        "namePrefix": [
          null
        ],
        "givenName": [
          ""
        ],
        "middleName": [],
        "surname": "",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330007694",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 19.55,
      "paymentType": "4",
      "netAmount": 2
    },
    {
      "passengerName": {
        "namePrefix": [
          null
        ],
        "givenName": [
          ""
        ],
        "middleName": [],
        "surname": "",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330007695",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 19.55,
      "paymentType": "4",
      "netAmount": 2
    },
    {
      "passengerName": {
        "namePrefix": [
          null
        ],
        "givenName": [
          ""
        ],
        "middleName": [],
        "surname": "",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330007696",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 19.55,
      "paymentType": "4",
      "netAmount": 2
    }
  ],
  "timeStamp": "2024-03-15T10:13:19.653Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

<br><br>

## Read booking

### Read the existing booking in SMS to display the booking information (ReadRQ)

### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_ReadRQ                           |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
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
          "name": "{{agencyId}}"
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
```

#### Response

```
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
        "tpaextensions": {
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
        "tpaextensions": {
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
        "tpaextensions": {
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
        "tpaextensions": {
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
          "tpaextensions": {
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
```

<br><br>

## Modify booking

`Changes to the passenger name are not permitted after the booking is paid and tickets are issued.`

### Modify the existing booking in SMS. Such as name change (OTA_AirBookModifyRQ)

### Request Parameters in the header (all required)

| Parameter    | Type    | Description        | Example                              |
| ------------ | ------- | ------------------ | ------------------------------------ |
| access_token | Header  | Access Token       | [Access token from](#authentication) |
| local-name   | Header  | Custom HTTP header | OTA_AirBookModifyRQ                  |
| agentId      | Payload | Custom HTTP header | ota                                  |
| agencyId     | Payload | Custom HTTP header | ota                                  |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
```

#### Payload

```
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
          "name": "{{agencyId}}"
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
        "tpaextensions": {
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
        "tpaextensions": {
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
        "tpaextensions": {
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
        "tpaextensions": {
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
          "tpaextensions": {
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
```

#### Response

```
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
```
