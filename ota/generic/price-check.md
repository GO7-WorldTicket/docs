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

## Pricing Qualifier Code

Put pricing qualifier code in OTA requests inside node named "pricingPref".

| Type          | Description   | Value |
|---------------|---------------|------|
| COPY          | Copy          | 1    |
| MANUAL        | Manual        | 2    |
| REMOVE        | Remove        | 3    |
| QUOTE         | Quote         | 4    |
| PRICE         | Price         | 5    |
| REBOOK        | Rebook        | 6    |
| DIRECT_ACCESS | Direct access | 7    |
| SEAMLESS      | Seamless      | 8    |
| CORE          | Core          | 9    |

Note: Use same value for "type" and "qualifier".

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
        "isocurrency": "{currency_code}"
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
              "resBookDesigCode": "{booking_class}"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "pricingPref": [
      {
        "type":"{pricing_type}",
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
        "isocurrency": "USD"
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
                "locationCode": "KRP"
              },
              "arrivalAirport": {
                "locationCode": "CPH"
              },
              "operatingAirline": {
                "code": "DX",
                "flightNumber": "9901"
              },
              "equipment": [],
              "departureDateTime": "2025-12-19T18:10:00",
              "arrivalDateTime": "2025-12-19T19:00:00",
              "rph": "1",
              "marketingAirline": {
                "code": "DX"
              },
              "flightNumber": "9901",
              "resBookDesigCode": "Y"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "pricingPref": [
      {
        "type":"5",
        "qualifier": "5"
      }
    ],
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": "1"
          },
          {
            "code": "CHD",
            "quantity": "0"
          },
          {
            "code": "INF",
            "quantity": "0"
          }
        ]
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
  "pricingOverview": {
    "fareInfo": {
      "equivFare": [],
      "fareBaggageAllowance": [],
      "remark": [],
      "tpaextensions": {
        "taxInfo": [
          {
            "taxCode": "EU",
            "taxName": "EU ETS CO2 emission tax",
            "taxType": "Airport tax"
          },
          {
            "taxCode": "DC",
            "taxName": "DCAA Safety Contribution",
            "taxType": "Airport tax"
          }
        ]
      }
    },
    "notes": [],
    "account": [],
    "pricingIndicator": []
  },
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
                      "locationCode": "KRP"
                    },
                    "arrivalAirport": {
                      "locationCode": "CPH"
                    },
                    "operatingAirline": {
                      "value": "",
                      "code": "DX",
                      "flightNumber": "9901"
                    },
                    "equipment": [],
                    "departureDateTime": "2025-12-19T18:10:00",
                    "arrivalDateTime": "2025-12-19T19:00:00",
                    "rph": "1",
                    "marketingAirline": {
                      "value": "",
                      "code": "DX"
                    },
                    "flightNumber": "9901",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [],
                    "comment": [],
                    "stopLocation": [],
                    "tpaextensions": {
                      "fareBasis": "YDXBED",
                      "priceGroup": "Bedre",
                      "fareRule": {
                        "code": "ECOBOW",
                        "name": "BEDRE",
                        "value": "Time/date can be changed prior to departure for a fee of DKK 200 per segment + fare difference. Cannot be rebooked to a less expensive fare. Name change for a fee of DKK 200 per segment. Refund not allowed. 1 piece (23 kg) checked-in luggage included. 8 kg of hand luggage included. 24 hour cancellation grace period after booking if departure is not within 24 hours. Children (2-15 years) pay 75% of the net fare (ex. taxes). Infants not requiring a separate seat can be added for free. An administration fee of DKK 95 per flight is charged for processing a refund. General terms and conditions also apply."
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
                "amount": 31.76
              },
              "equivFare": [],
              "taxes": {
                "tax": [
                  {
                    "value": "",
                    "taxCode": "DC",
                    "currencyCode": "USD",
                    "decimalPlaces": 2,
                    "amount": 2.04
                  },
                  {
                    "value": "",
                    "taxCode": "EU",
                    "currencyCode": "USD",
                    "decimalPlaces": 2,
                    "amount": 4.07
                  }
                ]
              },
              "fees": {
                "fee": [
                  {
                    "value": "",
                    "feeCode": "VAT_TOTAL",
                    "currencyCode": "USD",
                    "decimalPlaces": 2,
                    "amount": 2.78
                  }
                ]
              },
              "totalFare": {
                "currencyCode": "USD",
                "amount": 39.73
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
                      "value": "YDXBED"
                    }
                  ]
                },
                "passengerFare": [
                  {
                    "baseFare": {
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 31.76
                    },
                    "equivFare": [],
                    "taxes": {
                      "tax": [
                        {
                          "value": "",
                          "taxCode": "DC",
                          "currencyCode": "USD",
                          "decimalPlaces": 2,
                          "amount": 2.04
                        },
                        {
                          "value": "",
                          "taxCode": "EU",
                          "currencyCode": "USD",
                          "decimalPlaces": 2,
                          "amount": 4.07
                        }
                      ]
                    },
                    "fees": {
                      "fee": [
                        {
                          "value": "",
                          "feeCode": "VAT_TOTAL",
                          "currencyCode": "USD",
                          "decimalPlaces": 2,
                          "amount": 2.86
                        }
                      ]
                    },
                    "totalFare": {
                      "currencyCode": "USD",
                      "decimalPlaces": 2,
                      "amount": 40.73
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
        "notes": [],
        "sequenceNumber": 1
      }
    ]
  },
  "timeStamp": "2025-11-20T06:35:30.716Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>

</details>