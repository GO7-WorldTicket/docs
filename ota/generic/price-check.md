---
layout: default
title: Price Check
---

# Price Check (AirPriceRQ)

The Air-Price Request message requests pricing information for specific flights on certain dates for a specific number and type of passengers. The purpose is to verify the price prior to making a reservation and get an additional fare breakdown that might not be included in LowFareSearchRS.

## Table of Contents

- [Price Check (AirPriceRQ)](#price-check-airpricerq)
  - [Table of Contents](#table-of-contents)
  - [Base URLs](#base-urls)
  - [Endpoints](#endpoints)
  - [Basic Request Format](#basic-request-format)
    - [With JWT Authentication](#with-jwt-authentication)
    - [With API Key Authentication](#with-api-key-authentication)
  - [HTTP Headers](#http-headers)
  - [JSON Request](#json-request)
  - [JSON Response](#json-response)
  - [Error Responses](#error-responses)
    - [Price Not Available](#price-not-available)
    - [Invalid Flight Segment](#invalid-flight-segment)
    - [Fare Expired](#fare-expired)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoints
- Method: `POST`
- Path: `/ota/v2015b/OTA_AirPriceRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_AirPriceRQ` (choose base URL per environment above)

## Basic Request Format

### With JWT Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirPriceRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @AirPriceRQ.json
```

### With API Key Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirPriceRQ' \
  -H 'X-API-Key: {api_key}' \
  -H 'Content-Type: application/json' \
  -d @AirPriceRQ.json
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

## JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "bookingChannel": {
          "type": "{booking_channel_type}"
        },
        "isocurrency": "{currency_code}",
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
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
                "locationCode": "{origin_code}"
              },
              "arrivalAirport": {
                "locationCode": "{destination_code}"
              },
              "operatingAirline": {
                "code": "{airline_code}",
                "flightNumber": "{flight_number}"
              },
              "equipment": [],
              "departureDateTime": "{departure_datetime}",
              "arrivalDateTime": "{arrival_datetime}",
              "rph": "{segment_rph}",
              "marketingAirline": {
                "code": "{airline_code}"
              },
              "flightNumber": "{flight_number}",
              "resBookDesigCode": "{booking_class}",
              "fareBasisCode": "{fare_basis_code}",
              "status": "{segment_status}"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "pricingPref": [
      {
        "qualifier": "{pricing_qualifier}"
      }
    ],
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": "{adult_count}"
          },
          {
            "code": "CHD",
            "quantity": "{child_count}"
          },
          {
            "code": "INF",
            "quantity": "{infant_count}"
          }
        ]
      },
      {
        "airTraveler": {
          "passengerTypeCode": "CTC",
          "personName": {
            "givenName": ["{given_name}"],
            "surname": "{surname}"
          },
          "email": [
            {
              "value": "{email_address}"
            }
          ],
          "telephone": [
            {
              "countryAccessCode": "{country_code}",
              "phoneNumber": "{phone_number}"
            }
          ],
          "document": [
            {
              "docHolderNationality": "{nationality_code}",
              "birthDate": "{birth_date}"
            }
          ],
          "address": [
            {
              "cityName": "{city_name}",
              "countryName": {
                "code": "{country_code}"
              }
            }
          ]
        }
      }
    ]
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
        "isocurrency": "USD",
        "requestorID": {
          "type": "5",
          "id": "AGENT123",
          "name": "AGENCY1"
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
                "locationCode": "JED"
              },
              "arrivalAirport": {
                "locationCode": "XMK"
              },
              "operatingAirline": {
                "code": "DX",
                "flightNumber": "FL123"
              },
              "equipment": [],
              "departureDateTime": "2024-12-25T08:00:00",
              "arrivalDateTime": "2024-12-25T11:30:00",
              "rph": "1",
              "marketingAirline": {
                "code": "DX"
              },
              "flightNumber": "FL123",
              "resBookDesigCode": "Y",
              "fareBasisCode": "ECON",
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
            "quantity": 2
          },
          {
            "code": "CHD",
            "quantity": 1
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
            "givenName": ["John"],
            "surname": "Doe"
          },
          "email": [
            {
              "value": "john.doe@example.com"
            }
          ],
          "telephone": [
            {
              "countryAccessCode": "1",
              "phoneNumber": "2025551234"
            }
          ],
          "document": [
            {
              "docHolderNationality": "US",
              "birthDate": "1980-05-15"
            }
          ],
          "address": [
            {
              "cityName": "New York",
              "countryName": {
                "code": "US"
              }
            }
          ]
        }
      }
    ]
  }
}
```

</div>

</details>

## JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "success": {},
  "pricingOverview": {
    "fareInfo": {
      "equivFare": [],
      "fareBaggageAllowance": [],
      "remark": [],
      "tpaextensions": {
        "taxInfo": []
      }
    },
    "notes": [],
    "account": [],
    "pricingIndicator": []
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
                      "locationCode": "JED"
                    },
                    "arrivalAirport": {
                      "locationCode": "XMK"
                    },
                    "equipment": [],
                    "departureDateTime": "2024-12-25T08:00:00",
                    "arrivalDateTime": "2024-12-25T11:30:00",
                    "marketingAirline": {
                      "code": "DX"
                    },
                    "flightNumber": "FL123",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [],
                    "comment": [],
                    "stopLocation": [],
                    "tpaextensions": {
                      "fareBasis": "ECON",
                      "priceGroup": "Economy",
                      "fareRule": {
                        "code": "ECON_RULE_001",
                        "name": "Economy Fare Rules",
                        "value": "Standard economy class fare rules and conditions apply."
                      }
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
                "amount": 250.00
              },
              "equivFare": [],
              "taxes": {
                "tax": [
                  {
                    "taxCode": "YQ",
                    "currencyCode": "USD",
                    "decimalPlaces": 2,
                    "amount": 50.00
                  }
                ]
              },
              "fees": {
                "fee": []
              },
              "totalFare": {
                "currencyCode": "USD",
                "amount": 300.00
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
                      "value": "ECON"
                    }
                  ]
                },
                "passengerFare": [
                  {
                    "baseFare": {
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 250.00
                    },
                    "equivFare": [],
                    "taxes": {
                      "tax": [
                        {
                          "taxCode": "YQ",
                          "currencyCode": "USD",
                          "decimalPlaces": 2,
                          "amount": 50.00
                        }
                      ]
                    },
                    "fees": {
                      "fee": []
                    },
                    "totalFare": {
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 300.00
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
              }
            ]
          }
        },
        "notes": [],
        "sequenceNumber": 1
      }
    ]
  },
  "timeStamp": "2024-12-25T08:30:00.000Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>

</details>