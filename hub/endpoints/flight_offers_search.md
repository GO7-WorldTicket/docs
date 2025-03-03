# Flight Offers Search

## Find flight offers by provided criteria

| Parameter                          | Type | Data Type | Description            | Example                                    |
|------------------------------------|------|-----------|------------------------|--------------------------------------------|
| journey.departure.location.code    | M    | String    | Departure airport code | BER                                        |
| journey.departure.location.context | M    | Enum      | Departure context      | [AIRPORT, CITY, COUNTRY]                   |
| journey.departure.date             | M    | LocalDate | Departure date         | 2025-03-27                                 |
| journey.arrival.location.code      | M    | String    | Arrival airport code   | BCN                                        |
| journey.departure.location.context | M    | String    | Arrival context        | BCN                                        |
| passengers.quantity                | M    | Integer   | Count of passengers    | 2                                          |
| passengers.type                    | M    | Enum      | Types of passengers    | [ADULT, CHILD, INFANT, UNACCOMPINED_MINOR] |

#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Lists available flight offers per route and flight date for One Way trip

<details open>
  <summary><b>Request body</b></summary>
  <pre>
        mutation {
            findOfferDeals(
                offerQuery: {journey: {departure: {location: {code: "BER", context: AIRPORT}, date: "2025-03-27"}, arrival: {location: {code: "BCN", context: AIRPORT}, date: ""}}, passengers: {quantity: 1, code: "", type: ADULT}, preferences: {cabinTypes: FIRST_CLASS, carriers: "", numberOfStops: 10, transportTypes: FLIGHT}, requestParameters: NO_CACHE, requesterInfo: {currency: "", locale: ""}}
            ) {
                bookingClasses {
                    code
                    marketingCode
                    rph
                    seats
                    segmentRph
                }
                fareBrands {
                    active
                    description
                    fareRuleDescription
                    localizedName
                    media {
                        description
                        type
                        uri
                        value
                    }
                    name
                    order
                    rph
                    services {
                        active
                        description
                        localizedName
                        media {
                            description
                            type
                            uri
                            value
                        }
                        name
                    }
                    tenant
                }
                offers {
                    expiresAt
                    journey
                    offerId
                    offerItems {
                        category
                        offerItemId
                        passengerRph
                        price {
                            base {
                                amount
                                currency
                            }
                            fees {
                                breakdown {
                                    feeCode
                                    name
                                    total {
                                        amount
                                        currency
                                    }
                                }
                                feeTotal {
                                    amount
                                    currency
                                }
                            }
                            taxes {
                                breakdown {
                                    name
                                    taxCode
                                    total {
                                        amount
                                        currency
                                    }
                                }
                                taxTotal {
                                    amount
                                    currency
                                }
                            }
                            total {
                                amount
                                currency
                            }
                            vat {
                                amount
                                currency
                            }
                        }
                        type
                        ... on FlightOfferItem {
                            airlineName
                            cabinType
                            carrierCode
                            category
                            fare {
                                bookingClasses
                                fareBasisCode
                                fareBrandRph
                            }
                            offerItemId
                            originDestinationRph
                            passengerRph
                            price {
                                base {
                                    amount
                                    currency
                                }
                                fees {
                                    breakdown {
                                        feeCode
                                        name
                                        total {
                                            amount
                                            currency
                                        }
                                    }
                                    feeTotal {
                                        amount
                                        currency
                                    }
                                }
                                taxes {
                                    breakdown {
                                        name
                                        taxCode
                                        total {
                                            amount
                                            currency
                                        }
                                    }
                                    taxTotal {
                                        amount
                                        currency
                                    }
                                }
                                total {
                                    amount
                                    currency
                                }
                                vat {
                                    amount
                                    currency
                                }
                            }
                            segments
                            services
                            type
                        }
                    }
                    offerPrice {
                        base {
                            amount
                            currency
                        }
                        fees {
                            breakdown {
                                feeCode
                                name
                                total {
                                    amount
                                    currency
                                }
                            }
                            feeTotal {
                                amount
                                currency
                            }
                        }
                        taxes {
                            breakdown {
                                name
                                taxCode
                                total {
                                    amount
                                    currency
                                }
                            }
                            taxTotal {
                                amount
                                currency
                            }
                        }
                        total {
                            amount
                            currency
                        }
                        vat {
                            amount
                            currency
                        }
                    }
                }
                originDestinations {
                    duration
                    rph
                    segments
                }
                passengers {
                    code
                    rph
                    type
                }
                segments {
                    numberOfStops
                    rph
                    type
                    departure {
                        date
                        location {
                            code
                            ... on AirportCode {
                                name
                                code
                            }
                            ... on CityCode {
                                name
                                code
                            }
                            ... on CountryCode {
                                __typename
                                code
                            }
                            ... on Location {
                                context
                                code
                            }
                        }
                        time
                    }
                    arrival {
                        date
                        location {
                            code
                            ... on AirportCode {
                                name
                                code
                            }
                            ... on CityCode {
                                name
                                code
                            }
                            ... on CountryCode {
                                __typename
                                code
                            }
                            ... on Location {
                                context
                                code
                            }
                        }
                        time
                    }
                }
                services {
                    description
                    media {
                        description
                        type
                        uri
                        value
                    }
                    rfic
                    rfics
                    rph
                    serviceCategory
                    serviceCode
                    serviceName
                }
            }
        }
  </pre>
</details>

<details open>
  <summary><b>Response body</b></summary>
  <pre>
    {
      "data": {
        "offerDeals": {
          "segments": [
            {
              "departure": {
                "location": {
                  "code": "BER"
                },
                "date": "2025-03-27",
                "time": "18:55:00"
              },
              "arrival": {
                "location": {
                  "code": "BCN"
                },
                "date": "2025-03-27",
                "time": "21:30:00"
              },
              "rph": "SEG1",
              "flightDesignator": "PL0011",
              "operatingFlightDesignator": "PL0011"
            }
          ],
          "originDestinations": [
            {
              "rph": "OD1",
              "segments": [
                "SEG1"
              ],
              "duration": "PT2H35M"
            }
          ],
          "passengers": [
            {
              "rph": "PAX1",
              "code": "ADT",
              "type": "ADULT"
            }
          ],
          "bookingClasses": [
            {
              "rph": "BC1",
              "segmentRph": "SEG1",
              "code": "D",
              "marketingCode": "D",
              "seats": 160
            },
            {
              "rph": "BC2",
              "segmentRph": "SEG1",
              "code": "F",
              "marketingCode": "F",
              "seats": 20
            }
          ],
          "fareBrands": [
            {
              "rph": "BR1",
              "name": "Flex",
              "tenant": "polar",
              "description": "This is Flex brand description",
              "fareRuleDescription": "This is Flex brand fare rule description",
              "services": [
                {
                  "name": "Seat Selection",
                  "description": "Enhanced seating is included",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2ZyBhcmlhLWxhYmVsPSJmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Hand Baggage",
                  "description": "Carry-on bag 8KG 55X40X20",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2ZyBmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Checked-in Baggage",
                  "description": "1 Checked-in bag up to 23KG",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zyz4=",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Flexible Amendment",
                  "description": "Free changes up to 60 minutes before departure",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Flexible Cancellation",
                  "description": "Free cancellation up to 60 minutes before departure",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2dmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Food On Board",
                  "description": "Food for purchase",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2ZyBZnPg==",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                }
              ],
              "media": [
                {
                  "type": "COLOR",
                  "value": "367DD9",
                  "uri": null,
                  "description": null
                }
              ],
              "order": 3,
              "active": true
            },
            {
              "rph": "BR2",
              "name": "Smart",
              "tenant": "polar",
              "description": null,
              "fareRuleDescription": null,
              "services": [
                {
                  "name": "Seat Selection",
                  "description": "Enhanced seating for a fee",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zydmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Hand Baggage",
                  "description": "55X40X20",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHNzdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Priority Check-In",
                  "description": "Online check-in is included",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zz4=",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Food On Board",
                  "description": "Food for purchase",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Z3ZnPg==",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                }
              ],
              "media": [
                {
                  "type": "COLOR",
                  "value": "87DBFF",
                  "uri": null,
                  "description": null
                }
              ],
              "order": 2,
              "active": true
            },
            {
              "rph": "BR3",
              "name": "Business",
              "tenant": "polar",
              "description": "This is Business brand description",
              "fareRuleDescription": "This is Business brand fare rule description",
              "services": [
                {
                  "name": "Seat Selection",
                  "description": "Enhanced seating is included",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2zdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Hand Baggage",
                  "description": "Carry-on bag 8KG 55X40X20",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Checked-in Baggage",
                  "description": "2 Checked-in bag up to 23KG each",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHNZz4=",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Flexible Amendment",
                  "description": "Free changes up to 60 minutes before departure",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHNdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Flexible Cancellation",
                  "description": "Free cancellation up to 60 minutes before departure",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHNdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Food On Board",
                  "description": "Business class meal",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHNZnPg==",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                }
              ],
              "media": [
                {
                  "type": "COLOR",
                  "value": "33FF6E",
                  "uri": null,
                  "description": null
                }
              ],
              "order": 4,
              "active": true
            },
            {
              "rph": "BR4",
              "name": "Basic",
              "tenant": "polar",
              "description": null,
              "fareRuleDescription": null,
              "services": [
                {
                  "name": "Seat Selection",
                  "description": "Seating for a fee",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2zdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Hand Baggage",
                  "description": "55X40X20",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zdmc+",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Priority Check-In",
                  "description": "Online check-in included",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2Zz4=",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                },
                {
                  "name": "Food On Board",
                  "description": "Food for purchase",
                  "media": [
                    {
                      "type": "ICON",
                      "value": "data:image/svg+xml;base64,PHN2ZyZnPg==",
                      "uri": null,
                      "description": null
                    }
                  ],
                  "active": true
                }
              ],
              "media": [
                {
                  "type": "COLOR",
                  "value": "C5EBE6",
                  "uri": null,
                  "description": null
                }
              ],
              "order": 1,
              "active": true
            }
          ],
          "services": [],
          "offers": [
            {
              "offerId": "500b2030-69e6-47e3-a7c5-4e6aad3bf251",
              "offerItems": [
                {
                  "offerItemId": "5b3ccb48-8af1-4c96-b767-2465afa48c11:d70ba678-eb9c-4de6-b424-4ede86c54edc",
                  "price": {
                    "base": {
                      "currency": "USD",
                      "amount": "500.60"
                    },
                    "taxes": {
                      "taxTotal": {
                        "currency": "USD",
                        "amount": "30.00"
                      },
                      "breakdown": [
                        {
                          "taxCode": "TAX 1",
                          "name": "TAX 1",
                          "total": {
                            "currency": "USD",
                            "amount": "30.00"
                          }
                        }
                      ]
                    },
                    "fees": null,
                    "total": {
                      "currency": "USD",
                      "amount": "530.60"
                    }
                  },
                  "passengerRph": "PAX1",
                  "type": "FLIGHT",
                  "category": "TRANSPORTATION",
                  "segments": [
                    "SEG1"
                  ],
                  "services": [],
                  "fare": {
                    "fareBasisCode": "ECO",
                    "bookingClasses": [
                      "BC1"
                    ],
                    "fareBrandRph": "BR1"
                  }
                }
              ],
              "offerPrice": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "expiresAt": "2025-02-28T15:38:04.204Z"
            },
            {
              "offerId": "f6f73009-5290-4e01-9640-9c7f26c20e54",
              "offerItems": [
                {
                  "offerItemId": "9fd325d3-eaa8-49a0-a6db-af4a60f44087:eace9f86-c4c0-4192-bd89-9f96ec83f08f",
                  "price": {
                    "base": {
                      "currency": "USD",
                      "amount": "450.10"
                    },
                    "taxes": {
                      "taxTotal": {
                        "currency": "USD",
                        "amount": "30.00"
                      },
                      "breakdown": [
                        {
                          "taxCode": "TAX 1",
                          "name": "TAX 1",
                          "total": {
                            "currency": "USD",
                            "amount": "30.00"
                          }
                        }
                      ]
                    },
                    "fees": null,
                    "total": {
                      "currency": "USD",
                      "amount": "480.10"
                    }
                  },
                  "passengerRph": "PAX1",
                  "type": "FLIGHT",
                  "category": "TRANSPORTATION",
                  "segments": [
                    "SEG1"
                  ],
                  "services": [],
                  "fare": {
                    "fareBasisCode": "ECO",
                    "bookingClasses": [
                      "BC1"
                    ],
                    "fareBrandRph": "BR2"
                  }
                }
              ],
              "offerPrice": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "expiresAt": "2025-02-28T15:38:04.204Z"
            },
            {
              "offerId": "8224e9a6-66c3-4e42-bc95-b0c70d932fa3",
              "offerItems": [
                {
                  "offerItemId": "549a0b73-8427-47ad-8481-cb27208ea5d1:c1b4f7ab-c156-484b-807b-44214d03c5a3",
                  "price": {
                    "base": {
                      "currency": "USD",
                      "amount": "2000.90"
                    },
                    "taxes": {
                      "taxTotal": {
                        "currency": "USD",
                        "amount": "30.00"
                      },
                      "breakdown": [
                        {
                          "taxCode": "TAX 1",
                          "name": "TAX 1",
                          "total": {
                            "currency": "USD",
                            "amount": "30.00"
                          }
                        }
                      ]
                    },
                    "fees": null,
                    "total": {
                      "currency": "USD",
                      "amount": "2030.90"
                    }
                  },
                  "passengerRph": "PAX1",
                  "type": "FLIGHT",
                  "category": "TRANSPORTATION",
                  "segments": [
                    "SEG1"
                  ],
                  "services": [],
                  "fare": {
                    "fareBasisCode": "BIZ",
                    "bookingClasses": [
                      "BC2"
                    ],
                    "fareBrandRph": "BR3"
                  }
                }
              ],
              "offerPrice": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "expiresAt": "2025-02-28T15:38:04.204Z"
            },
            {
              "offerId": "93ac111e-15ed-461c-b8d6-3d68ccbe322a",
              "offerItems": [
                {
                  "offerItemId": "92bbf7f0-0bab-4a55-927d-0d9c494cde61:2a0b507e-1943-4435-b433-50bad588f12e",
                  "price": {
                    "base": {
                      "currency": "USD",
                      "amount": "400.20"
                    },
                    "taxes": {
                      "taxTotal": {
                        "currency": "USD",
                        "amount": "30.00"
                      },
                      "breakdown": [
                        {
                          "taxCode": "TAX 1",
                          "name": "TAX 1",
                          "total": {
                            "currency": "USD",
                            "amount": "30.00"
                          }
                        }
                      ]
                    },
                    "fees": null,
                    "total": {
                      "currency": "USD",
                      "amount": "430.20"
                    }
                  },
                  "passengerRph": "PAX1",
                  "type": "FLIGHT",
                  "category": "TRANSPORTATION",
                  "segments": [
                    "SEG1"
                  ],
                  "services": [],
                  "fare": {
                    "fareBasisCode": "ECO",
                    "bookingClasses": [
                      "BC1"
                    ],
                    "fareBrandRph": "BR4"
                  }
                }
              ],
              "offerPrice": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "expiresAt": "2025-02-28T15:38:04.205Z"
            }
          ]
        }
      }
    }
  </pre>
</details>

#### Lists available flight offers per route and flight date for Round Trip
<details open>
  <summary><b>Request body</b></summary>
  <pre>
        mutation {
            findOfferDeals(
                offerQuery: {journey: [{departure: {location: {code: "BER", context: AIRPORT}, date: "2025-03-27"}, arrival: {location: {code: "BCN", context: AIRPORT}, date: ""}}, {departure: {location: {code: "BCN", context: AIRPORT}, date: "2025-03-31"}, arrival: {location: {code: "BER", context: AIRPORT}, date: ""}}], passengers: {quantity: 1, code: "", type: ADULT}, preferences: {cabinTypes: FIRST_CLASS, carriers: "", numberOfStops: 10, transportTypes: FLIGHT}, requestParameters: NO_CACHE, requesterInfo: {currency: "", locale: ""}}
            ) {
                bookingClasses {
                    code
                    marketingCode
                    rph
                    seats
                    segmentRph
                }
                fareBrands {
                    active
                    description
                    fareRuleDescription
                    localizedName
                    media {
                        description
                        type
                        uri
                        value
                    }
                    name
                    order
                    rph
                    services {
                        active
                        description
                        localizedName
                        media {
                            description
                            type
                            uri
                            value
                        }
                        name
                    }
                    tenant
                }
                offers {
                    expiresAt
                    journey
                    offerId
                    offerItems {
                        category
                        offerItemId
                        passengerRph
                        price {
                            base {
                                amount
                                currency
                            }
                            fees {
                                breakdown {
                                    feeCode
                                    name
                                    total {
                                        amount
                                        currency
                                    }
                                }
                                feeTotal {
                                    amount
                                    currency
                                }
                            }
                            taxes {
                                breakdown {
                                    name
                                    taxCode
                                    total {
                                        amount
                                        currency
                                    }
                                }
                                taxTotal {
                                    amount
                                    currency
                                }
                            }
                            total {
                                amount
                                currency
                            }
                            vat {
                                amount
                                currency
                            }
                        }
                        type
                        ... on FlightOfferItem {
                            airlineName
                            cabinType
                            carrierCode
                            category
                            fare {
                                bookingClasses
                                fareBasisCode
                                fareBrandRph
                            }
                            offerItemId
                            originDestinationRph
                            passengerRph
                            price {
                                base {
                                    amount
                                    currency
                                }
                                fees {
                                    breakdown {
                                        feeCode
                                        name
                                        total {
                                            amount
                                            currency
                                        }
                                    }
                                    feeTotal {
                                        amount
                                        currency
                                    }
                                }
                                taxes {
                                    breakdown {
                                        name
                                        taxCode
                                        total {
                                            amount
                                            currency
                                        }
                                    }
                                    taxTotal {
                                        amount
                                        currency
                                    }
                                }
                                total {
                                    amount
                                    currency
                                }
                                vat {
                                    amount
                                    currency
                                }
                            }
                            segments
                            services
                            type
                        }
                    }
                    offerPrice {
                        base {
                            amount
                            currency
                        }
                        fees {
                            breakdown {
                                feeCode
                                name
                                total {
                                    amount
                                    currency
                                }
                            }
                            feeTotal {
                                amount
                                currency
                            }
                        }
                        taxes {
                            breakdown {
                                name
                                taxCode
                                total {
                                    amount
                                    currency
                                }
                            }
                            taxTotal {
                                amount
                                currency
                            }
                        }
                        total {
                            amount
                            currency
                        }
                        vat {
                            amount
                            currency
                        }
                    }
                }
                originDestinations {
                    duration
                    rph
                    segments
                }
                passengers {
                    code
                    rph
                    type
                }
                segments {
                    numberOfStops
                    rph
                    type
                    departure {
                        date
                        location {
                            code
                            ... on AirportCode {
                                name
                                code
                            }
                            ... on CityCode {
                                name
                                code
                            }
                            ... on CountryCode {
                                __typename
                                code
                            }
                            ... on Location {
                                context
                                code
                            }
                        }
                        time
                    }
                    arrival {
                        date
                        location {
                            code
                            ... on AirportCode {
                                name
                                code
                            }
                            ... on CityCode {
                                name
                                code
                            }
                            ... on CountryCode {
                                __typename
                                code
                            }
                            ... on Location {
                                context
                                code
                            }
                        }
                        time
                    }
                }
                services {
                    description
                    media {
                        description
                        type
                        uri
                        value
                    }
                    rfic
                    rfics
                    rph
                    serviceCategory
                    serviceCode
                    serviceName
                }
            }
        }

  </pre>
</details>

<details open>
  <summary><b>Response body</b></summary>
  <pre>
    {
  "data": {
    "offerDeals": {
      "segments": [
        {
          "departure": {
            "location": {
              "code": "BER"
            },
            "date": "2025-03-27",
            "time": "18:55:00"
          },
          "arrival": {
            "location": {
              "code": "BCN"
            },
            "date": "2025-03-27",
            "time": "21:30:00"
          },
          "rph": "SEG1",
          "flightDesignator": "PL0011",
          "operatingFlightDesignator": "PL0011"
        },
        {
          "departure": {
            "location": {
              "code": "BCN"
            },
            "date": "2025-03-31",
            "time": "15:45:00"
          },
          "arrival": {
            "location": {
              "code": "BER"
            },
            "date": "2025-03-31",
            "time": "20:30:00"
          },
          "rph": "SEG2",
          "flightDesignator": "PL0012",
          "operatingFlightDesignator": "PL0012"
        }
      ],
      "originDestinations": [
        {
          "rph": "OD1",
          "segments": [
            "SEG1"
          ],
          "duration": "PT2H35M"
        },
        {
          "rph": "OD2",
          "segments": [
            "SEG2"
          ],
          "duration": "PT4H45M"
        }
      ],
      "passengers": [
        {
          "rph": "PAX1",
          "code": "ADT",
          "type": "ADULT"
        }
      ],
      "bookingClasses": [
        {
          "rph": "BC1",
          "segmentRph": "SEG1",
          "code": "D",
          "marketingCode": "D",
          "seats": 160
        },
        {
          "rph": "BC2",
          "segmentRph": "SEG1",
          "code": "F",
          "marketingCode": "F",
          "seats": 20
        },
        {
          "rph": "BC3",
          "segmentRph": "SEG2",
          "code": "D",
          "marketingCode": "D",
          "seats": 160
        },
        {
          "rph": "BC4",
          "segmentRph": "SEG2",
          "code": "F",
          "marketingCode": "F",
          "seats": 20
        }
      ],
      "fareBrands": [
        {
          "rph": "BR1",
          "name": "Flex",
          "tenant": "polar",
          "description": "This is Flex brand description",
          "fareRuleDescription": "This is Flex brand fare rule description",
          "services": [
            {
              "name": "Seat Selection",
              "description": "Enhanced seating is included",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2Zdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Hand Baggage",
              "description": "Carry-on bag 8KG 55X40X20",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2Zzdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Checked-in Baggage",
              "description": "1 Checked-in bag up to 23KG",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2Zz4=",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Flexible Amendment",
              "description": "Free changes up to 60 minutes before departure",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Flexible Cancellation",
              "description": "Free cancellation up to 60 minutes before departure",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2zdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Food On Board",
              "description": "Food for purchase",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2ZynPg==",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            }
          ],
          "media": [
            {
              "type": "COLOR",
              "value": "367DD9",
              "uri": null,
              "description": null
            }
          ],
          "order": 3,
          "active": true
        },
        {
          "rph": "BR2",
          "name": "Basic",
          "tenant": "polar",
          "description": null,
          "fareRuleDescription": null,
          "services": [
            {
              "name": "Seat Selection",
              "description": "Seating for a fee",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2Zdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Hand Baggage",
              "description": "55X40X20",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2Zzdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Priority Check-In",
              "description": "Online check-in included",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHZz4=",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Food On Board",
              "description": "Food for purchase",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2ZnPg==",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            }
          ],
          "media": [
            {
              "type": "COLOR",
              "value": "C5EBE6",
              "uri": null,
              "description": null
            }
          ],
          "order": 1,
          "active": true
        },
        {
          "rph": "BR3",
          "name": "Smart",
          "tenant": "polar",
          "description": null,
          "fareRuleDescription": null,
          "services": [
            {
              "name": "Seat Selection",
              "description": "Enhanced seating for a fee",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2mc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Hand Baggage",
              "description": "55X40X20",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2dmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Priority Check-In",
              "description": "Online check-in is included",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHNz4=",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Food On Board",
              "description": "Food for purchase",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHNnPg==",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            }
          ],
          "media": [
            {
              "type": "COLOR",
              "value": "87DBFF",
              "uri": null,
              "description": null
            }
          ],
          "order": 2,
          "active": true
        },
        {
          "rph": "BR4",
          "name": "Business",
          "tenant": "polar",
          "description": "This is Business brand description",
          "fareRuleDescription": "This is Business brand fare rule description",
          "services": [
            {
              "name": "Seat Selection",
              "description": "Enhanced seating is included",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2dmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Hand Baggage",
              "description": "Carry-on bag 8KG 55X40X20",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN2dmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Checked-in Baggage",
              "description": "2 Checked-in bag up to 23KG each",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHNZz4=",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Flexible Amendment",
              "description": "Free changes up to 60 minutes before departure",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHdmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Flexible Cancellation",
              "description": "Free cancellation up to 60 minutes before departure",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHNmc+",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            },
            {
              "name": "Food On Board",
              "description": "Business class meal",
              "media": [
                {
                  "type": "ICON",
                  "value": "data:image/svg+xml;base64,PHN23ZnPg==",
                  "uri": null,
                  "description": null
                }
              ],
              "active": true
            }
          ],
          "media": [
            {
              "type": "COLOR",
              "value": "33FF6E",
              "uri": null,
              "description": null
            }
          ],
          "order": 4,
          "active": true
        }
      ],
      "services": [],
      "offers": [
        {
          "offerId": "0cc741ce-9a5e-4577-afdc-30faad1e8c17",
          "offerItems": [
            {
              "offerItemId": "84826c94-5dff-483f-9343-98f17bb168c7:126278c7-6687-446a-a4f8-fd13e8a3fd53",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR1"
              }
            },
            {
              "offerItemId": "f6a0cf95-7640-421f-8f44-80a448821622:b180cc74-7610-4332-b2b6-37a1404bed62",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR1"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "1001.20"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "1061.20"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "44193f42-2d21-42c5-8041-a757094c0cad",
          "offerItems": [
            {
              "offerItemId": "84826c94-5dff-483f-9343-98f17bb168c7:126278c7-6687-446a-a4f8-fd13e8a3fd53",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR1"
              }
            },
            {
              "offerItemId": "5fcc98ca-6d99-4dfd-ae7b-bbac5f33b7b9:9de9a9f8-7349-4d48-98c0-14e8d322bd24",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR2"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "900.80"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "960.80"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "35ed65e6-6962-4a8b-891b-df9f2da41745",
          "offerItems": [
            {
              "offerItemId": "84826c94-5dff-483f-9343-98f17bb168c7:126278c7-6687-446a-a4f8-fd13e8a3fd53",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR1"
              }
            },
            {
              "offerItemId": "8c6b038f-ca45-4ef5-9b95-856459294d09:d4c7b76d-9cbf-4a4a-8f16-e58ef49ea11e",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR3"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "950.70"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "1010.70"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "fd644c4e-cd6c-467d-8cc4-d612816d580e",
          "offerItems": [
            {
              "offerItemId": "84826c94-5dff-483f-9343-98f17bb168c7:126278c7-6687-446a-a4f8-fd13e8a3fd53",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR1"
              }
            },
            {
              "offerItemId": "338e2f45-d6ae-4aab-8344-26db98cc6d83:3d5fb859-6d20-4f4d-9408-0c414116df52",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC4"
                ],
                "fareBrandRph": "BR4"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2501.50"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2561.50"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "6a6dab76-61e6-403f-b451-096b1ff915fa",
          "offerItems": [
            {
              "offerItemId": "7b45aae7-88cb-471f-867f-9b3c84762dbf:77fb9fb3-c79e-4a88-82ee-d139be0666b6",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR3"
              }
            },
            {
              "offerItemId": "f6a0cf95-7640-421f-8f44-80a448821622:b180cc74-7610-4332-b2b6-37a1404bed62",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR1"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "950.70"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "1010.70"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "0944bf3b-8311-4ea2-a218-eb8f39aa079e",
          "offerItems": [
            {
              "offerItemId": "7b45aae7-88cb-471f-867f-9b3c84762dbf:77fb9fb3-c79e-4a88-82ee-d139be0666b6",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR3"
              }
            },
            {
              "offerItemId": "5fcc98ca-6d99-4dfd-ae7b-bbac5f33b7b9:9de9a9f8-7349-4d48-98c0-14e8d322bd24",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR2"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "850.30"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "910.30"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "a324787b-3ee1-4250-8764-bd2295b69c5e",
          "offerItems": [
            {
              "offerItemId": "7b45aae7-88cb-471f-867f-9b3c84762dbf:77fb9fb3-c79e-4a88-82ee-d139be0666b6",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR3"
              }
            },
            {
              "offerItemId": "8c6b038f-ca45-4ef5-9b95-856459294d09:d4c7b76d-9cbf-4a4a-8f16-e58ef49ea11e",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR3"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "900.20"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "960.20"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "d54a0254-1d32-4c56-80e7-783289f4023f",
          "offerItems": [
            {
              "offerItemId": "7b45aae7-88cb-471f-867f-9b3c84762dbf:77fb9fb3-c79e-4a88-82ee-d139be0666b6",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR3"
              }
            },
            {
              "offerItemId": "338e2f45-d6ae-4aab-8344-26db98cc6d83:3d5fb859-6d20-4f4d-9408-0c414116df52",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC4"
                ],
                "fareBrandRph": "BR4"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2451.00"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2511.00"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "b222617a-1ada-4abe-9a7a-712fea9a971b",
          "offerItems": [
            {
              "offerItemId": "ca1cd9dd-9ade-43e9-ac16-110ccbe07a5b:3978cf41-13d0-40d3-a8aa-d2ed18d2bee5",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC2"
                ],
                "fareBrandRph": "BR4"
              }
            },
            {
              "offerItemId": "f6a0cf95-7640-421f-8f44-80a448821622:b180cc74-7610-4332-b2b6-37a1404bed62",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR1"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2501.50"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2561.50"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "b5ca7395-f18f-4057-8c0a-264ed53d96ed",
          "offerItems": [
            {
              "offerItemId": "ca1cd9dd-9ade-43e9-ac16-110ccbe07a5b:3978cf41-13d0-40d3-a8aa-d2ed18d2bee5",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC2"
                ],
                "fareBrandRph": "BR4"
              }
            },
            {
              "offerItemId": "5fcc98ca-6d99-4dfd-ae7b-bbac5f33b7b9:9de9a9f8-7349-4d48-98c0-14e8d322bd24",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR2"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2401.10"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2461.10"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "3a37dd5e-7644-4bc4-ba45-0168b311ed49",
          "offerItems": [
            {
              "offerItemId": "ca1cd9dd-9ade-43e9-ac16-110ccbe07a5b:3978cf41-13d0-40d3-a8aa-d2ed18d2bee5",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC2"
                ],
                "fareBrandRph": "BR4"
              }
            },
            {
              "offerItemId": "8c6b038f-ca45-4ef5-9b95-856459294d09:d4c7b76d-9cbf-4a4a-8f16-e58ef49ea11e",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR3"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2451.00"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2511.00"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "c7d10aa9-7f1d-446d-9221-e7e73ada6b24",
          "offerItems": [
            {
              "offerItemId": "ca1cd9dd-9ade-43e9-ac16-110ccbe07a5b:3978cf41-13d0-40d3-a8aa-d2ed18d2bee5",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC2"
                ],
                "fareBrandRph": "BR4"
              }
            },
            {
              "offerItemId": "338e2f45-d6ae-4aab-8344-26db98cc6d83:3d5fb859-6d20-4f4d-9408-0c414116df52",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC4"
                ],
                "fareBrandRph": "BR4"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "4001.80"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "4061.80"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "7b9b5d1c-cdcd-49ae-8228-30ce91482f44",
          "offerItems": [
            {
              "offerItemId": "15221e3d-9501-41b6-956f-c285362bc30a:2585536e-9942-4481-a42f-ed1eb3fffddd",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR2"
              }
            },
            {
              "offerItemId": "f6a0cf95-7640-421f-8f44-80a448821622:b180cc74-7610-4332-b2b6-37a1404bed62",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "500.60"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "530.60"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR1"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "900.80"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "960.80"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "7aa11b52-5462-4d3c-8768-d7ec9eb96eb2",
          "offerItems": [
            {
              "offerItemId": "15221e3d-9501-41b6-956f-c285362bc30a:2585536e-9942-4481-a42f-ed1eb3fffddd",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR2"
              }
            },
            {
              "offerItemId": "5fcc98ca-6d99-4dfd-ae7b-bbac5f33b7b9:9de9a9f8-7349-4d48-98c0-14e8d322bd24",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR2"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "800.40"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "860.40"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "8e622dcd-fd65-446c-afd5-4c68c2c342e2",
          "offerItems": [
            {
              "offerItemId": "15221e3d-9501-41b6-956f-c285362bc30a:2585536e-9942-4481-a42f-ed1eb3fffddd",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR2"
              }
            },
            {
              "offerItemId": "8c6b038f-ca45-4ef5-9b95-856459294d09:d4c7b76d-9cbf-4a4a-8f16-e58ef49ea11e",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "450.10"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "480.10"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC3"
                ],
                "fareBrandRph": "BR3"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "850.30"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "910.30"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.298Z"
        },
        {
          "offerId": "6ba4ad05-6c78-4614-a021-e6cafa11dfee",
          "offerItems": [
            {
              "offerItemId": "15221e3d-9501-41b6-956f-c285362bc30a:2585536e-9942-4481-a42f-ed1eb3fffddd",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "400.20"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "430.20"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG1"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "ECO",
                "bookingClasses": [
                  "BC1"
                ],
                "fareBrandRph": "BR2"
              }
            },
            {
              "offerItemId": "338e2f45-d6ae-4aab-8344-26db98cc6d83:3d5fb859-6d20-4f4d-9408-0c414116df52",
              "price": {
                "base": {
                  "currency": "USD",
                  "amount": "2000.90"
                },
                "taxes": {
                  "taxTotal": {
                    "currency": "USD",
                    "amount": "30.00"
                  },
                  "breakdown": [
                    {
                      "taxCode": "TAX 1",
                      "name": "TAX 1",
                      "total": {
                        "currency": "USD",
                        "amount": "30.00"
                      }
                    }
                  ]
                },
                "fees": null,
                "total": {
                  "currency": "USD",
                  "amount": "2030.90"
                }
              },
              "passengerRph": "PAX1",
              "type": "FLIGHT",
              "category": "TRANSPORTATION",
              "segments": [
                "SEG2"
              ],
              "services": [],
              "fare": {
                "fareBasisCode": "BIZ",
                "bookingClasses": [
                  "BC4"
                ],
                "fareBrandRph": "BR4"
              }
            }
          ],
          "offerPrice": {
            "base": {
              "currency": "USD",
              "amount": "2401.10"
            },
            "taxes": {
              "taxTotal": {
                "currency": "USD",
                "amount": "60.00"
              },
              "breakdown": [
                {
                  "taxCode": "TAX 1",
                  "name": "TAX 1",
                  "total": {
                    "currency": "USD",
                    "amount": "60.00"
                  }
                }
              ]
            },
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "2461.10"
            }
          },
          "expiresAt": "2025-02-28T15:51:36.299Z"
        }
      ]
    }
  }
}
  </pre>
</details>

#### Error messages

| Message                                                | Description                                                                                                   |
|--------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| Currency {requestedCurrency} is not supported          | Requested currency is not configured as supported.<br/>Try to use supported currency or configure it.         |
| Travel classes {requestedTravelClass} is not supported | Requested travel class is not configured as supported.<br/>Try to use supported travel class or configure it. |


