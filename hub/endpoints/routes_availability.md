# Find Available Routes

## Find all available routes

#### Request Parameters

| Parameter         | Type | Data Type | Description            | Example                  |
|-------------------|------|-----------|------------------------|--------------------------|
| departure.code    | O    | String    | Departure airport code | BER                      |
| departure.context | O    | Enum      | Departure context      | [AIRPORT, CITY, COUNTRY] |
| arrival.code      | O    | String    | Arrival airport code   | BCN                      |
| arrival.context   | O    | Enum      | Arrival context        | [AIRPORT, CITY, COUNTRY] |


#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Lists all possible city pairs selling by the airline and sale channel

<details open>
  <summary><b>Request body</b></summary>
  <pre>
        query {
            routes(
                routeQuery: {}
            ) {
            numberOfStops
            arrival {
                airportCode {
                    code
                    name
                }
                cityCode {
                    code
                    name
                }
                countryCode {
                    code
                }
                landmarks {
                    name
                }
                name
                tenant
            }
            departure {
                airportCode {
                    code
                    name
                }
                cityCode {
                    code
                    name
                }
                countryCode {
                    code
                }
                landmarks {
                    name
                }
                name
                tenant
            }
            tenant
        }
    }
    
  </pre>
</details>

<details open>
  <summary><b>Response body</b></summary>
  <pre>
{
  "data": {
    "routes": [
      {
        "arrival": {
          "airportCode": {
            "code": "BCN",
            "name": null
          },
          "cityCode": {
            "code": "BCN",
            "name": null
          },
          "countryCode": {
            "code": "ES"
          },
          "landmarks": [],
          "name": "Barcelona-El Prat Airport",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "BER",
            "name": null
          },
          "cityCode": {
            "code": "BER",
            "name": null
          },
          "countryCode": {
            "code": "DE"
          },
          "landmarks": [],
          "name": "Berlin Brandenburg Airport",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "JFK",
            "name": null
          },
          "cityCode": {
            "code": "NYC",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [
            {
              "name": "New York Hall of Science"
            }
          ],
          "name": "New York/Kennedy"
        },
        "departure": {
          "airportCode": {
            "code": "TLV",
            "name": null
          },
          "cityCode": {
            "code": "TLV",
            "name": null
          },
          "countryCode": {
            "code": "IL"
          },
          "landmarks": [
            {
              "name": "Sea"
            }
          ],
          "name": "Tel Aviv/Ben Gurion"
        },
        "tenant": "polar",
        "connections": [
          {
            "agreementId": "1cab6da7-11ec-4714-a107-88274acacc88",
            "routes": [
              {
                "arrival": {
                  "airportCode": {
                    "code": "BER",
                    "name": null
                  },
                  "cityCode": {
                    "code": "BER",
                    "name": null
                  },
                  "countryCode": {
                    "code": "GE"
                  },
                  "landmarks": [],
                  "name": "Berlin Brandenburg Airport"
                },
                "departure": {
                  "airportCode": {
                    "code": "TLV",
                    "name": null
                  },
                  "cityCode": {
                    "code": "TLV",
                    "name": null
                  },
                  "countryCode": {
                    "code": "IL"
                  },
                  "name": "Tel Aviv/Ben Gurion"
                },
                "tenant": "polar"
              },
              {
                "arrival": {
                  "airportCode": {
                    "code": "JFK",
                    "name": null
                  },
                  "cityCode": {
                    "code": "NYC",
                    "name": null
                  },
                  "countryCode": {
                    "code": "US"
                  },
                  "landmarks": [
                    {
                      "name": "New York Hall of Science"
                    }
                  ],
                  "name": "New York/Kennedy"
                },
                "departure": {
                  "airportCode": {
                    "code": "BER",
                    "name": null
                  },
                  "cityCode": {
                    "code": "BER",
                    "name": null
                  },
                  "countryCode": {
                    "code": "GE"
                  },
                  "landmarks": [],
                  "name": "Berlin Brandenburg Airport"
                },
                "tenant": "sky"
              }
            ]
          }
        ]
      },
      {
        "arrival": {
          "airportCode": {
            "code": "BER",
            "name": null
          },
          "cityCode": {
            "code": "BER",
            "name": null
          },
          "countryCode": {
            "code": "DE"
          },
          "landmarks": [],
          "name": "Berlin Brandenburg Airport",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "BCN",
            "name": null
          },
          "cityCode": {
            "code": "BCN",
            "name": null
          },
          "countryCode": {
            "code": "ES"
          },
          "landmarks": [],
          "name": "Barcelona-El Prat Airport",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "JFK",
            "name": null
          },
          "cityCode": {
            "code": "NYC",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [
            {
              "name": "New York Hall of Science"
            }
          ],
          "name": "New York/Kennedy",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "ZRH",
            "name": null
          },
          "cityCode": {
            "code": "ZRH",
            "name": null
          },
          "countryCode": {
            "code": "CH"
          },
          "landmarks": [
            {
              "name": "Grossmünster"
            }
          ],
          "name": "Zurich Airport",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "TLV",
            "name": null
          },
          "cityCode": {
            "code": "TLV",
            "name": null
          },
          "countryCode": {
            "code": "IL"
          },
          "landmarks": [
            {
              "name": "Sea"
            }
          ],
          "name": "Tel Aviv/Ben Gurion",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "JFK",
            "name": null
          },
          "cityCode": {
            "code": "NYC",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [
            {
              "name": "New York Hall of Science"
            }
          ],
          "name": "New York/Kennedy",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "TLV",
            "name": null
          },
          "cityCode": {
            "code": "TLV",
            "name": null
          },
          "countryCode": {
            "code": "IL"
          },
          "landmarks": [
            {
              "name": "Sea"
            }
          ],
          "name": "Tel Aviv/Ben Gurion",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "ZRH",
            "name": null
          },
          "cityCode": {
            "code": "ZRH",
            "name": null
          },
          "countryCode": {
            "code": "CH"
          },
          "landmarks": [
            {
              "name": "Grossmünster"
            }
          ],
          "name": "Zurich Airport",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "FLL",
            "name": null
          },
          "cityCode": {
            "code": "FLL",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [],
          "name": "Fort Lauderdale (FLL)",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "JFK",
            "name": null
          },
          "cityCode": {
            "code": "NYC",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [
            {
              "name": "New York Hall of Science"
            }
          ],
          "name": "New York/Kennedy",
          "tenant": "polar"
        },
        "tenant": "polar"
      },
      {
        "arrival": {
          "airportCode": {
            "code": "FLL",
            "name": null
          },
          "cityCode": {
            "code": "FLL",
            "name": null
          },
          "countryCode": {
            "code": "US"
          },
          "landmarks": [],
          "name": "Fort Lauderdale (FLL)",
          "tenant": "polar"
        },
        "departure": {
          "airportCode": {
            "code": "TLV",
            "name": null
          },
          "cityCode": {
            "code": "TLV",
            "name": null
          },
          "countryCode": {
            "code": "IL"
          },
          "landmarks": [
            {
              "name": "Sea"
            }
          ],
          "name": "Tel Aviv/Ben Gurion",
          "tenant": "polar"
        },
        "tenant": "polar"
      }
    ]
  }
}
  </pre>
</details>

##### Lists of city pairs filtered by search criteria.

<details open>
  <summary><b>Request body</b></summary>

  <pre>
        query {
            routes(
                routeQuery: {departure: {code: "BER", context: AIRPORT}, arrival: {code: "BCN", context: AIRPORT}}
            ) {
            numberOfStops
            arrival {
                airportCode {
                    code
                    name
                }
                cityCode {
                    code
                    name
                }
                countryCode {
                    code
                }
                landmarks {
                    name
                }
                name
                tenant
            }
            departure {
                airportCode {
                    code
                    name
                }
                cityCode {
                    code
                    name
                }
                countryCode {
                    code
                }
                landmarks {
                    name
                }
                name
                tenant
            }
            tenant
        }
    }
  </pre>
</details>

<details open>
  <summary><b>Response body</b></summary>
  <pre>
    {
    "data": {
        "routes": [
            {
                "numberOfStops": 0,
                "arrival": {
                    "airportCode": {
                        "code": "BCN",
                        "name": null
                    },
                    "cityCode": {
                        "code": "BCN",
                        "name": null
                    },
                    "countryCode": {
                        "code": "ES"
                    },
                    "landmarks": [],
                    "name": "Barcelona-El Prat Airport",
                    "tenant": "polar"
                },
                "departure": {
                    "airportCode": {
                        "code": "BER",
                        "name": null
                    },
                    "cityCode": {
                        "code": "BER",
                        "name": null
                    },
                    "countryCode": {
                        "code": "DE"
                    },
                    "landmarks": [],
                    "name": "Berlin Brandenburg Airport",
                    "tenant": "polar"
                },
                "tenant": "polar"
            }
        ]
    }
}
  </pre>
</details>
