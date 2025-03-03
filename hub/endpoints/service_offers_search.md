# Service Offers Search

## Find service offers by provided criteria

| Parameter                       | Type | Data Type | Description                                      | Example                                                                   |
|---------------------------------|------|-----------|--------------------------------------------------|---------------------------------------------------------------------------|
| serviceQuery.currencyCode       | C    | String    | Request service offer currency code              | USD                                                                       |
| offerItemSearchKeys.offerId     | M    | Enum      | Offer id from flight offers search response      | a220060b-7820-49e9-ba1c-b02c9d299fd9                                      |
| offerItemSearchKeys.offerItemId | M    | String    | Offer item id from flight offers search response | acc0342b-e71e-4018-b2f0-6c6526f5f4ae:2a0b507e-1943-4435-b433-50bad588f12e |

#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

#### Lists available service offers by flight offer for One Way trip

<details open>
  <summary><b>Request body</b></summary>
  <pre>
      mutation {
            findServiceOffers(
                serviceQuery: {currencyCode: "USD", offerItemSearchKeys: {offerId: "a220060b-7820-49e9-ba1c-b02c9d299fd9", offerItemId: "acc0342b-e71e-4018-b2f0-6c6526f5f4ae:2a0b507e-1943-4435-b433-50bad588f12e"}}
            ) {
                bookingClasses {
                    code
                    marketingCode
                    rph
                    seats
                    segmentRph
                }
                expiresAt
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
                journey {
                    duration
                    rph
                    segments {
                        arrival {
                            date
                            location {
                                code
                                ... on AirportCode {
                                    name
                                    code
                                }
                            }
                            time
                        }
                        departure {
                            date
                            location {
                                code
                                ... on AirportCode {
                                    name
                                    code
                                }
                            }
                            time
                        }
                        numberOfStops
                        rph
                        type
                        ... on FlightSegment {
                            operatingFlightDesignator
                            aircraftType
                            aircraftIataCode
                            arrival {
                                date
                                location {
                                    code
                                    ... on AirportCode {
                                        name
                                        code
                                    }
                                }
                                time
                            }
                            departure {
                                date
                                location {
                                    code
                                    ... on AirportCode {
                                        name
                                        code
                                    }
                                }
                                time
                            }
                            flightDesignator
                            numberOfStops
                            rph
                            type
                        }
                    }
                }
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
                passengers {
                    code
                    rph
                    type
                }
                salesChannel
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
            "offers": [
                {
                    "offerId": "ef4a4cad-a75b-4be8-8937-561082f231f8",
                    "journey": [
                        {
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
                                    "flightDesignator": "PL0011"
                                }
                            ]
                        }
                    ],
                    "passengers": [
                        {
                            "rph": "PAX1",
                            "type": "ADULT"
                        }
                    ],
                    "bookingClasses": [
                        {
                            "rph": "BC1",
                            "segmentRph": "SEG1",
                            "code": "D",
                            "seats": 160
                        }
                    ],
                    "services": [
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge Pass",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV1"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 2",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV2"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 3",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV3"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Test (description) - Test item",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV4"
                        },
                        {
                            "serviceCode": "XBAG",
                            "serviceCategory": "Ancillaries",
                            "description": "Checked-bag  (Are you not feeling like light travelers? Check-in your bag!) - test",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV5"
                        },
                        {
                            "serviceCode": "DSLB",
                            "serviceCategory": "SpecialAssistance",
                            "description": "Disabled pax",
                            "media": null,
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV6"
                        },
                        {
                            "serviceCode": "WCHR",
                            "serviceCategory": "SpecialAssistance",
                            "description": "Wheelchair",
                            "media": null,
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV7"
                        }
                    ],
                    "offerItems": [
                        {
                            "offerItemId": "7b16f35d-a76b-4001-8a4f-e889600ca87f",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "55.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV1",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "81015472-e67a-4ef4-8fa6-ab837abfa1f5",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "11.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "1.10"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "2.20"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "3.30"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "4.40"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "66.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV2",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "97006254-ae94-4989-b4e9-ef0cedab93af",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV3",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "7934bef2-a5c1-45b6-80a4-213b20363b9b",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV4",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "6b95df8b-be71-4d85-91bd-2734decfe00d",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV5",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "e3d146c2-3b59-40e8-b486-17ccb9ed426c",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV6",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "21315b15-6d31-46f6-aa7f-7b92a27ca781",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV7",
                            "segmentRph": "SEG1"
                        }
                    ],
                    "offerPrice": {
                        "base": {
                            "amount": "326.00",
                            "currency": "USD"
                        },
                        "taxes": {
                            "taxTotal": {
                                "amount": "11.00",
                                "currency": "USD"
                            },
                            "breakdown": [
                                {
                                    "taxCode": "tax1",
                                    "name": "tax1",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "1.10"
                                    }
                                },
                                {
                                    "taxCode": "tax2",
                                    "name": "tax2",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "2.20"
                                    }
                                },
                                {
                                    "taxCode": "tax3",
                                    "name": "tax3",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "3.30"
                                    }
                                },
                                {
                                    "taxCode": "tax4",
                                    "name": "tax4",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "4.40"
                                    }
                                }
                            ]
                        },
                        "fees": null,
                        "total": {
                            "currency": "USD",
                            "amount": "347.00"
                        }
                    }
                }
            ]
        }
    }
  </pre>
</details>

#### Lists available service offers by flight offer for Round trip
<details open>
  <summary><b>Request body</b></summary>
  <pre>
        mutation {
            findServiceOffers(
                serviceQuery: {currencyCode: "USD", offerItemSearchKeys: [
                    {offerId: "59936e5e-5439-4960-92ae-277ba4c1fe5e", offerItemId: "b6d1fc6a-f2c1-4f90-a915-c35bedd078a9:7f5beacd-5194-4acc-aa0a-f4e88e34160a"},
                    {offerId: "59936e5e-5439-4960-92ae-277ba4c1fe5e", offerItemId: "60bff682-9c0e-41a8-b386-50e12191f437:0092c2c6-8b03-47a9-b9bf-38b568f989cc"}  
                ]}
            ) {
                bookingClasses {
                    code
                    marketingCode
                    rph
                    seats
                    segmentRph
                }
                expiresAt
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
                journey {
                    duration
                    rph
                    segments {
                        arrival {
                            date
                            location {
                                code
                                ... on AirportCode {
                                    name
                                    code
                                }
                            }
                            time
                        }
                        departure {
                            date
                            location {
                                code
                                ... on AirportCode {
                                    name
                                    code
                                }
                            }
                            time
                        }
                        numberOfStops
                        rph
                        type
                        ... on FlightSegment {
                            operatingFlightDesignator
                            aircraftType
                            aircraftIataCode
                            arrival {
                                date
                                location {
                                    code
                                    ... on AirportCode {
                                        name
                                        code
                                    }
                                }
                                time
                            }
                            departure {
                                date
                                location {
                                    code
                                    ... on AirportCode {
                                        name
                                        code
                                    }
                                }
                                time
                            }
                            flightDesignator
                            numberOfStops
                            rph
                            type
                        }
                    }
                }
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
                passengers {
                    code
                    rph
                    type
                }
                salesChannel
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
            "offers": [
                {
                    "offerId": "bb2b9aeb-a573-49a0-ab6b-1972f6c7b29b",
                    "journey": [
                        {
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
                                    "flightDesignator": "PL0011"
                                }
                            ]
                        },
                        {
                            "segments": [
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
                                    "flightDesignator": "PL0012"
                                }
                            ]
                        }
                    ],
                    "passengers": [
                        {
                            "rph": "PAX1",
                            "type": "ADULT"
                        }
                    ],
                    "bookingClasses": [
                        {
                            "rph": "BC1",
                            "segmentRph": "SEG1",
                            "code": "D",
                            "seats": 160
                        },
                        {
                            "rph": "BC2",
                            "segmentRph": "SEG2",
                            "code": "D",
                            "seats": 160
                        }
                    ],
                    "services": [
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge Pass",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV1"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 2",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV2"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 3",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV3"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Test (description) - Test item",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV4"
                        },
                        {
                            "serviceCode": "XBAG",
                            "serviceCategory": "Ancillaries",
                            "description": "Checked-bag  (Are you not feeling like light travelers? Check-in your bag!) - test",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV5"
                        },
                        {
                            "serviceCode": "DSLB",
                            "serviceCategory": "SpecialAssistance",
                            "description": "Disabled pax",
                            "media": null,
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV6"
                        },
                        {
                            "serviceCode": "WCHR",
                            "serviceCategory": "SpecialAssistance",
                            "description": "Wheelchair",
                            "media": null,
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV7"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge Pass",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV8"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 2",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV9"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Lounge Access (Instead of spending money at the duty-free, spending some time at the lounge!) - Lounge pass 3",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV10"
                        },
                        {
                            "serviceCode": "",
                            "serviceCategory": "Other",
                            "description": "Test (description) - Test item",
                            "media": [
                                {
                                    "uri": "https://storage.aerocrs.com/595/system/Polar.png",
                                    "description": "Service image url"
                                }
                            ],
                            "rfic": "G",
                            "rfics": null,
                            "rph": "SRV11"
                        }
                    ],
                    "offerItems": [
                        {
                            "offerItemId": "d1cb221f-2b4d-4389-b8d2-bc928a5dddbb",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "55.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV1",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "d2d3c42c-9465-4eb1-8fb3-0ba7c9a4663d",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "11.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "1.10"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "2.20"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "3.30"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "4.40"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "66.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV2",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "5e208f91-725e-4fa8-8818-0af3dd8cab0e",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV3",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "2b7bd840-b1bb-4b0a-a619-207e6997168a",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV4",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "46e4701a-42ae-4fd0-bc3c-b2068daf5065",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV5",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "b4ebba83-5175-46e7-bc06-ef82323c0982",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV6",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "bfdd43ea-86f0-439c-9abe-3935a7de0550",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV7",
                            "segmentRph": "SEG1"
                        },
                        {
                            "offerItemId": "2b596357-f05a-4971-a54d-023266bd6d06",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "55.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV8",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "328bc0a0-88ff-4a90-9fad-baa8569d0468",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "11.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "1.10"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "2.20"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "3.30"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "4.40"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "5.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "66.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV9",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "903cff13-533a-4e73-8163-af65dbebd6d0",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "77.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV10",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "ca9a055a-bdeb-41a0-907d-80f7f9e83607",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "99.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV11",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "9947680a-9e7e-470c-a9f4-ccc6f5b4381d",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": [
                                        {
                                            "taxCode": "tax1",
                                            "name": "tax1",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax2",
                                            "name": "tax2",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax3",
                                            "name": "tax3",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        },
                                        {
                                            "taxCode": "tax4",
                                            "name": "tax4",
                                            "total": {
                                                "currency": "USD",
                                                "amount": "0.00"
                                            }
                                        }
                                    ]
                                },
                                "vat": {
                                    "amount": "0.00",
                                    "currency": "USD"
                                },
                                "total": {
                                    "currency": "USD",
                                    "amount": "50.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV5",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "9c41f7b5-0c70-4aaf-8cfd-2a6233852b2a",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV6",
                            "segmentRph": "SEG2"
                        },
                        {
                            "offerItemId": "bea00ded-2235-4d85-91f8-530d795ad421",
                            "price": {
                                "base": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                },
                                "taxes": {
                                    "taxTotal": {
                                        "amount": "0.00",
                                        "currency": "USD"
                                    },
                                    "breakdown": []
                                },
                                "vat": null,
                                "total": {
                                    "currency": "USD",
                                    "amount": "0.00"
                                }
                            },
                            "passengerRph": "PAX1",
                            "type": "IN_FLIGHT_SERVICE",
                            "category": "TRANSPORTATION",
                            "serviceRph": "SRV7",
                            "segmentRph": "SEG2"
                        }
                    ],
                    "offerPrice": {
                        "base": {
                            "amount": "652.00",
                            "currency": "USD"
                        },
                        "taxes": {
                            "taxTotal": {
                                "amount": "22.00",
                                "currency": "USD"
                            },
                            "breakdown": [
                                {
                                    "taxCode": "tax1",
                                    "name": "tax1",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "2.20"
                                    }
                                },
                                {
                                    "taxCode": "tax2",
                                    "name": "tax2",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "4.40"
                                    }
                                },
                                {
                                    "taxCode": "tax3",
                                    "name": "tax3",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "6.60"
                                    }
                                },
                                {
                                    "taxCode": "tax4",
                                    "name": "tax4",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "8.80"
                                    }
                                }
                            ]
                        },
                        "fees": null,
                        "total": {
                            "currency": "USD",
                            "amount": "694.00"
                        }
                    }
                }
            ]
        }
    }
  </pre>
</details>


