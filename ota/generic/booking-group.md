---
layout: default
title: Group Booking (AirPriceRQ)
---

# Create a Group Booking (AirPriceRQ)

When making a group booking, passenger names are not known yet. In AirPriceRQ, passenger type quantities (not individual names as in AirBookRQ) should be specified along with contact details and travel itinerary.

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
| Local-Name | OTA operation identifier | OTA_AirPriceRQ |
| Content-Type | Request content type | application/xml |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

## Request Parameters

| Parameter | Location | Required | Description | Example |
|-----------|----------|----------|-------------|---------|
| base_url | Endpoint | Yes | Base URL for the request | https://test-api.worldticket.net/ota/v2015b/OTA |

## Request Format

### With JWT Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA \
    -H 'Authorization: Bearer {access_token}' \
    -H 'Local-Name: OTA_AirPriceRQ' \
    -H 'Content-Type: application/xml' \
    -d @AirPriceRQ.xml
```

### With API Key Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA \
    -H 'X-API-Key: {api_key}' \
    -H 'Local-Name: OTA_AirPriceRQ' \
    -H 'Content-Type: application/xml' \
    -d @AirPriceRQ.xml
```

## AirPriceRQ for One-way Trip
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
          "type": "OTA"
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
                "flightNumber": "{flight_no}"
              },
              "equipment": [],
              "departureDateTime": "{departure_datetime}",
              "rph": "1",
              "marketingAirline": {
                "code": "{airline_code}"
              },
              "flightNumber": "{flight_no}",
              "resBookDesigCode": "Y",
              "fareBasisCode": "{fare_basis_code}",
              "status": "30"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "{ADT|CHD|INF}",
            "quantity": 1
          }
        ],
        "airTraveler": {
          "personName": {
            "givenName": [
              "{passenger_name}"
            ],
            "surname": "{passenger_surname}"
          },
          "travelerRefNumber": {
            "rph": "1"
          },
          "passengerTypeCode": "{ADT|CHD|INF}",
          "gender": "{gender}"
        }
      }
    ]
  },
  "priceRequestInformation": {
    "tpa_Extensions": {
      "groupBooking": {
        "groupName": "{group_name}",
        "contactInfo": {
          "personName": {
            "givenName": "{contact_first_name}",
            "surname": "{contact_last_name}"
          },
          "telephone": {
            "phoneNumber": "{contact_phone}"
          },
          "email": "{contact_email}"
        }
      }
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
        "requestorID": { "type": "5", "id": "AGENT123", "name": "AGENCY1" },
        "bookingChannel": { "type": "OTA" }
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
                "locationCode": "CPH"
              },
              "arrivalAirport": {
                "locationCode": "RNN"
              },
              "departureDateTime": "2019-06-14T07:00:00",
              "arrivalDateTime": "2019-06-14T07:30:00",
              "rph": "1",
              "marketingAirline": {
                "code": "DX"
              },
              "flightNumber": "100",
              "resBookDesigCode": "M",
              "status": "30",
              "tpaextensions": {
                "fareBasis": "MDXGOD"
              }
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 1
          }
        ],
        "airTraveler": {
          "personName": {
            "givenName": [
              "Passenger1"
            ],
            "surname": "Traveler"
          },
          "travelerRefNumber": {
            "rph": "1"
          },
          "passengerTypeCode": "ADT",
          "gender": "Unknown"
        }
      }
    ]
  }
}
```
</div>
</details>


## AirPriceRQ for Round Trip

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
          "type": "OTA"
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
                "flightNumber": "{flight_no}"
              },
              "equipment": [],
              "departureDateTime": "{departure_datetime}",
              "rph": "1",
              "marketingAirline": {
                "code": "{airline_code}"
              },
              "flightNumber": "{flight_no}",
              "resBookDesigCode": "Y",
              "fareBasisCode": "{fare_basis_code}",
              "status": "30"
            }
          ]
        },
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
                "flightNumber": "{flight_no}"
              },
              "equipment": [],
              "departureDateTime": "{departure_datetime}",
              "rph": "1",
              "marketingAirline": {
                "code": "{airline_code}"
              },
              "flightNumber": "{flight_no}",
              "resBookDesigCode": "Y",
              "fareBasisCode": "{fare_basis_code}",
              "status": "30"
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "{ADT|CHD|INF}",
            "quantity": 1
          }
        ],
        "airTraveler": {
          "personName": {
            "givenName": [
              "{passenger_name}"
            ],
            "surname": "{passenger_surname}"
          },
          "travelerRefNumber": {
            "rph": "1"
          },
          "passengerTypeCode": "{ADT|CHD|INF}",
          "gender": "{gender}"
        }
      }
    ]
  },
  "priceRequestInformation": {
    "tpa_Extensions": {
      "groupBooking": {
        "groupName": "{group_name}",
        "contactInfo": {
          "personName": {
            "givenName": "{contact_first_name}",
            "surname": "{contact_last_name}"
          },
          "telephone": {
            "phoneNumber": "{contact_phone}"
          },
          "email": "{contact_email}"
        }
      }
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
        "requestorID": { "type": "5", "id": "AGENT123", "name": "AGENCY1" },
        "bookingChannel": { "type": "OTA" }
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
                "locationCode": "CPH"
              },
              "arrivalAirport": {
                "locationCode": "RNN"
              },
              "departureDateTime": "2019-06-14T07:00:00",
              "arrivalDateTime": "2019-06-14T07:30:00",
              "rph": "1",
              "marketingAirline": {
                "code": "DX"
              },
              "flightNumber": "100",
              "resBookDesigCode": "M",
              "status": "30",
              "tpaextensions": {
                "fareBasis": "MDXGOD"
              }
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": 1
          }
        ],
        "airTraveler": {
          "personName": {
            "givenName": [
              "Passenger1"
            ],
            "surname": "Traveler"
          },
          "travelerRefNumber": {
            "rph": "1"
          },
          "passengerTypeCode": "ADT",
          "gender": "Unknown"
        }
      }
    ]
  }
}
```
</div>
</details>

## Response Structure

AirPriceRS response contains a record locator in "quoteID" field.

### JSON Response

```json
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
                      "locationCode": "JED"
                    },
                    "arrivalAirport": {
                      "locationCode": "XMD"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-03-29T06:30:00.000+03:00",
                    "arrivalDateTime": "2023-03-29T07:00:00.000+03:00",
                    "rph": "1",
                    "flightNumber": "HHR7212",
                    "fareBasisCode": "YECOSTD",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [],
                    "comment": [],
                    "stopLocation": [],
                    "numberInParty": 1,
                    "status": "30"
                  },
                  {
                    "departureAirport": {
                      "locationCode": "XMD"
                    },
                    "arrivalAirport": {
                      "locationCode": "JED"
                    },
                    "equipment": [],
                    "departureDateTime": "2023-04-10T18:00:00.000+03:00",
                    "arrivalDateTime": "2023-04-10T19:54:00.000+03:00",
                    "rph": "2",
                    "flightNumber": "HHR7211",
                    "fareBasisCode": "YECOSTD",
                    "resBookDesigCode": "Y",
                    "bookingClassAvails": [],
                    "comment": [],
                    "stopLocation": [],
                    "numberInParty": 1,
                    "status": "30"
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
                "currencyCode": "SAR",
                "amount": 895.98
              },
              "equivFare": [],
              "taxes": {
                "tax": [
                  {
                    "taxCode": "YQ",
                    "currencyCode": "SAR",
                    "amount": 14.42
                  },
                  {
                    "taxCode": "VAT",
                    "currencyCode": "SAR",
                    "amount": 89.60
                  }
                ]
              },
              "totalFare": {
                "currencyCode": "SAR",
                "amount": 1000.00
              },
              "fareBaggageAllowance": [],
              "remark": []
            }
          ],
          "quoteID": "AKMFS9"
        },
        "notes": []
      }
    ]
  },
  "correlationID": "4f4dad22-9432-4c5f-ab0c-994cdd0a992e",
  "target": "Production",
  "primaryLangID": "en",
  "version": 2.001
}
```

## Group Booking Completion Policy

Group bookings typically have specific policies for completion:

1. **Time Limits**: Group bookings must be completed within specified timeframes
2. **Passenger Lists**: Final passenger names must be provided before the deadline
3. **Payment Terms**: Special payment arrangements may apply for group bookings
4. **Cancellation Policies**: Different cancellation rules may apply compared to individual bookings

### Group Booking Workflow

1. **Initial Quote**: Create group booking with passenger quantities using AirPriceRQ
2. **Quote Response**: Receive quote ID and pricing information
3. **Name Collection**: Gather individual passenger names and details
4. **Final Booking**: Convert group quote to individual bookings with passenger names
5. **Payment**: Process payment according to group terms
6. **Ticketing**: Issue tickets within the specified time limit

## Error Responses

### Group Size Limitations

```xml
<OTA_AirPriceRS>
    <Errors>
        <Error Code="GROUP_SIZE_EXCEEDED" ShortText="Group size exceeded">
            The requested group size exceeds the maximum allowed for this flight.
        </Error>
    </Errors>
</OTA_AirPriceRS>
```

### Missing Contact Information

```json
{
  "errors": [
    {
      "code": "MISSING_CONTACT_INFO",
      "message": "Group booking requires contact information",
      "field": "contactInfo"
    }
  ]
}
```
