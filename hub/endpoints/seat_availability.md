# Seat Availability Search

## Find seat availability for display seat-map by provided criteria

#### Request Parameters (all required)

| Parameter                                   | Type | Data Type | Description                                      | Example                                                                   |
|---------------------------------------------|------|-----------|--------------------------------------------------|---------------------------------------------------------------------------|
| offerRequest.selectedOfferItems.offerId     | M    | String    | Offer id from flight offer search response       | a220060b-7820-49e9-ba1c-b02c9d299fd9                                      |
| offerRequest.selectedOfferItems.offerItemId | M    | String    | Offer item id from flight offers search response | acc0342b-e71e-4018-b2f0-6c6526f5f4ae:2a0b507e-1943-4435-b433-50bad588f12e |


#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Provide seat-map structure and lists available seat offers by flight offer for One Way trip.
<details open>
  <summary><b>Request Body</b></summary>
  <pre>
        mutation {
            findSeatAvailability(
                seatAvailabilityQuery: {offerRequest: {selectedOfferItems: {offerId: "a220060b-7820-49e9-ba1c-b02c9d299fd9", offerItemId: "acc0342b-e71e-4018-b2f0-6c6526f5f4ae:2a0b507e-1943-4435-b433-50bad588f12e"}}}
            ) {
                expiresAt
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
                    segmentRph
                    serviceRph
                    type
                }
                passengers {
                    code
                    rph
                    type
                }
                salesChannel
                seatMaps {
                    cabinCompartments {
                        deckLocation
                        firstRow
                        lastRow
                        seatColumns {
                            columnCode
                            seatCharacteristic
                        }
                        seatRows {
                            rowNumber
                            seats {
                                columnCode
                                marketingCabinRph
                                offerItems
                                remark
                                seatCharacteristics
                                seatProfileRph
                                status
                            }
                        }
                    }
                    cabinDefinitions {
                        cabinType
                        description
                        rph
                        title
                    }
                    seatCharacteristicDefinitions {
                        description
                        seatCharacteristic
                    }
                    seatProfiles {
                        description
                        media {
                            description
                            type
                            uri
                        }
                        rph
                        seatCharacteristics
                        title
                    }
                    segmentRph
                }
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
  <summary><b>Response Body</b></summary>
  <pre>
    {
    "data": {
        "findSeatAvailability": {
            "offerId": "eb33c11c-d51b-411d-ae85-a0a9fa3b74f8",
            "expiresAt": "2025-03-02T21:07:24.460Z",
            "salesChannel": "IBE",
            "seatMaps": [
                {
                    "segmentRph": "SEG1",
                    "cabinDefinitions": [
                        {
                            "rph": "CABIN1",
                            "cabinType": "ECONOMY_CLASS",
                            "title": "Economy",
                            "description": null
                        }
                    ],
                    "seatCharacteristicDefinitions": [
                        {
                            "description": "test description text",
                            "seatCharacteristic": "WINDOW_SEAT"
                        },
                        {
                            "description": "seat test description",
                            "seatCharacteristic": "LEG_SPACE_SEAT"
                        }
                    ],
                    "seatProfiles": [
                        {
                            "rph": "SP1",
                            "title": "Standard seat",
                            "seatCharacteristics": null,
                            "media": [
                                {
                                    "type": "ICON",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNjI1IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSJ3aGl0ZSIgc3Ryb2tlPSIjNTA1MDUwIi8+CjxyZWN0IHg9IjAuNSIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0id2hpdGUiIHN0cm9rZT0iIzUwNTA1MCIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC42MjUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSJ3aGl0ZSIgc3Ryb2tlPSIjNTA1MDUwIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMjU2OCIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0id2hpdGUiIHN0cm9rZT0iIzUwNTA1MCIvPgo8L3N2Zz4=",
                                    "description": null
                                },
                                {
                                    "type": "ICON_SELECTED",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNjI1IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSIjNTA1MDUwIiBzdHJva2U9IiNmZmYiLz4KPHJlY3QgeD0iMC41IiB5PSIyOC42MjUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjNTA1MDUwIiBzdHJva2U9IiNmZmYiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iIzUwNTA1MCIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMjU2OCIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iIzUwNTA1MCIgc3Ryb2tlPSIjZmZmIi8+Cjwvc3ZnPg==",
                                    "description": null
                                },
                                {
                                    "type": "ICON_UNAVAILABLE",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43NzcxIiB5PSIyMC42MjUiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIwLjQ5OTI2OCIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0U5RTlFOSIgc3Ryb2tlPSIjRDNEM0QzIi8+CjxyZWN0IHg9IjMxLjExMDYiIHk9IjI4LjYyNSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIzLjY2NTc3IiB5PSI0OS4yNTY4IiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHBhdGggZD0iTTE4Ljk5OTggMzYuNTc3OUwyMy4xMjQ2IDMyLjQ1MzFMMjQuMzAzMSAzMy42MzE2TDIwLjE3ODMgMzcuNzU2NEwyNC4zMDMxIDQxLjg4MTJMMjMuMTI0NiA0My4wNTk3TDE4Ljk5OTggMzguOTM0OUwxNC44NzUgNDMuMDU5N0wxMy42OTY1IDQxLjg4MTJMMTcuODIxMyAzNy43NTY0TDEzLjY5NjUgMzMuNjMxNkwxNC44NzUgMzIuNDUzMUwxOC45OTk4IDM2LjU3NzlaIiBmaWxsPSIjRDNEM0QzIi8+Cjwvc3ZnPg==",
                                    "description": null
                                }
                            ],
                            "description": [
                                "description one",
                                "description two",
                                "description three"
                            ]
                        },
                        {
                            "rph": "SP2",
                            "title": "window",
                            "seatCharacteristics": [
                                "WINDOW_SEAT"
                            ],
                            "media": [
                                {
                                    "type": "ICON",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41MjA3NTIiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTIwNzUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjQ0NFQ0Y0IiBzdHJva2U9IiMwMDgyOUYiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iOC41MjA3NSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8cmVjdCB4PSIzLjY2NjUiIHk9IjI5LjE1MjYiIHdpZHRoPSIzMC42NjY3IiBoZWlnaHQ9IjYuMzg4ODkiIHJ4PSIyLjUiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8L3N2Zz4=",
                                    "description": null
                                },
                                {
                                    "type": "ICON_SELECTED",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41NDE1MDQiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI0U5RTlFOSIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTQxNSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI0U5RTlFOSIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSI4LjU0MTUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjMTk2Mjc5IiBzdHJva2U9IiNFOUU5RTkiLz4KPHJlY3QgeD0iMy42NjY1IiB5PSIyOS4xNzMzIiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjMTk2Mjc5IiBzdHJva2U9IiNFOUU5RTkiLz4KPC9zdmc+",
                                    "description": null
                                },
                                {
                                    "type": "ICON_UNAVAILABLE",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41MjA3NTIiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTIwNzUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iOC41MjA3NSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIzLjY2NjUiIHk9IjI5LjE1MjYiIHdpZHRoPSIzMC42NjY3IiBoZWlnaHQ9IjYuMzg4ODkiIHJ4PSIyLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cGF0aCBkPSJNMTkuMDAwNiAxNS40NzM3TDIzLjEyNTMgMTEuMzQ4OUwyNC4zMDM4IDEyLjUyNzRMMjAuMTc5MSAxNi42NTIyTDI0LjMwMzggMjAuNzc2OUwyMy4xMjUzIDIxLjk1NTRMMTkuMDAwNiAxNy44MzA3TDE0Ljg3NTggMjEuOTU1NEwxMy42OTczIDIwLjc3NjlMMTcuODIyMSAxNi42NTIyTDEzLjY5NzMgMTIuNTI3NEwxNC44NzU4IDExLjM0ODlMMTkuMDAwNiAxNS40NzM3WiIgZmlsbD0iI0QzRDNEMyIvPgo8L3N2Zz4=",
                                    "description": null
                                }
                            ],
                            "description": [
                                "test description text"
                            ]
                        },
                        {
                            "rph": "SP3",
                            "title": "extralegroom",
                            "seatCharacteristics": [
                                "LEG_SPACE_SEAT"
                            ],
                            "media": [
                                {
                                    "type": "ICON",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iIzBDMzEzQyIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0id2hpdGUiLz4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNTIwOCIgd2lkdGg9IjI2LjQ0NDQiIGhlaWdodD0iMjkuNjExMSIgcng9IjMuNSIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+CjxyZWN0IHg9IjAuNSIgeT0iMjguMDI3NiIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNEMkU0RUEiIHN0cm9rZT0iIzE5NjI3OSIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMTUyNiIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+Cjwvc3ZnPg==",
                                    "description": null
                                },
                                {
                                    "type": "ICON_SELECTED",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iIzBDMzEzQyIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0id2hpdGUiLz4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNTIwOCIgd2lkdGg9IjI2LjQ0NDQiIGhlaWdodD0iMjkuNjExMSIgcng9IjMuNSIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjAuNSIgeT0iMjguMDI3NiIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI2ZmZiIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMTUyNiIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+Cjwvc3ZnPg==",
                                    "description": null
                                },
                                {
                                    "type": "ICON_UNAVAILABLE",
                                    "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iI0U5RTlFOSIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0iI0QzRDNEMyIvPgo8cmVjdCB4PSI1Ljc3NzgzIiB5PSIyMC41MjA4IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMC41IiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0U5RTlFOSIgc3Ryb2tlPSIjRDNEM0QzIi8+CjxyZWN0IHg9IjMxLjExMTMiIHk9IjI4LjAyNzYiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMy42NjY1IiB5PSI0OS4xNTI2IiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHBhdGggZD0iTTE4LjUwMDYgMzUuNDcyN0wyMi42MjUzIDMxLjM0NzlMMjMuODAzOCAzMi41MjY0TDE5LjY3OTEgMzYuNjUxMkwyMy44MDM4IDQwLjc3NkwyMi42MjUzIDQxLjk1NDVMMTguNTAwNiAzNy44Mjk3TDE0LjM3NTggNDEuOTU0NUwxMy4xOTczIDQwLjc3NkwxNy4zMjIxIDM2LjY1MTJMMTMuMTk3MyAzMi41MjY0TDE0LjM3NTggMzEuMzQ3OUwxOC41MDA2IDM1LjQ3MjdaIiBmaWxsPSIjRDNEM0QzIi8+Cjwvc3ZnPg==",
                                    "description": null
                                }
                            ],
                            "description": [
                                "seat test description"
                            ]
                        }
                    ],
                    "cabinCompartments": [
                        {
                            "firstRow": 1,
                            "lastRow": 5,
                            "seatColumns": [
                                {
                                    "columnCode": "A",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT",
                                        "WINDOW_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": null,
                                    "seatCharacteristic": [
                                        "NO_SEAT_AT_THIS_LOCATION"
                                    ]
                                },
                                {
                                    "columnCode": "C",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": null,
                                    "seatCharacteristic": [
                                        "NO_SEAT_AT_THIS_LOCATION"
                                    ]
                                },
                                {
                                    "columnCode": "D",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": null,
                                    "seatCharacteristic": [
                                        "NO_SEAT_AT_THIS_LOCATION"
                                    ]
                                },
                                {
                                    "columnCode": "F",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT",
                                        "WINDOW_SEAT"
                                    ]
                                }
                            ],
                            "seatRows": [
                                {
                                    "rowNumber": 1,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 2,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 3,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 4,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 5,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "firstRow": 10,
                            "lastRow": 12,
                            "seatColumns": [
                                {
                                    "columnCode": "A",
                                    "seatCharacteristic": [
                                        "WINDOW_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "B",
                                    "seatCharacteristic": [
                                        "CENTER_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "C",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": null,
                                    "seatCharacteristic": [
                                        "NO_SEAT_AT_THIS_LOCATION"
                                    ]
                                },
                                {
                                    "columnCode": "D",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "E",
                                    "seatCharacteristic": [
                                        "CENTER_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "F",
                                    "seatCharacteristic": [
                                        "WINDOW_SEAT"
                                    ]
                                }
                            ],
                            "seatRows": [
                                {
                                    "rowNumber": 10,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 11,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 12,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "firstRow": 14,
                            "lastRow": 33,
                            "seatColumns": [
                                {
                                    "columnCode": "A",
                                    "seatCharacteristic": [
                                        "WINDOW_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "B",
                                    "seatCharacteristic": [
                                        "CENTER_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "C",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": null,
                                    "seatCharacteristic": [
                                        "NO_SEAT_AT_THIS_LOCATION"
                                    ]
                                },
                                {
                                    "columnCode": "D",
                                    "seatCharacteristic": [
                                        "AISLE_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "E",
                                    "seatCharacteristic": [
                                        "CENTER_SEAT"
                                    ]
                                },
                                {
                                    "columnCode": "F",
                                    "seatCharacteristic": [
                                        "WINDOW_SEAT"
                                    ]
                                }
                            ],
                            "seatRows": [
                                {
                                    "rowNumber": 14,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 15,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 16,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 17,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 18,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 19,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 20,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT",
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT",
                                                "EXIT_AND_EMERGENCY_EXIT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 21,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 22,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 23,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 24,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 25,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 26,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 27,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 28,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 29,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 30,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 31,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 32,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                },
                                {
                                    "rowNumber": 33,
                                    "seats": [
                                        {
                                            "columnCode": "A",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        },
                                        {
                                            "columnCode": "B",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "C",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": null,
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_OCCUPIED",
                                            "seatCharacteristics": [
                                                "NO_SEAT_AT_THIS_LOCATION"
                                            ],
                                            "offerItems": [],
                                            "seatProfileRph": null
                                        },
                                        {
                                            "columnCode": "D",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "AISLE_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "E",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "CENTER_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP1"
                                        },
                                        {
                                            "columnCode": "F",
                                            "marketingCabinRph": "CABIN1",
                                            "status": "SEAT_IS_FREE",
                                            "seatCharacteristics": [
                                                "WINDOW_SEAT"
                                            ],
                                            "offerItems": [
                                                "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                                            ],
                                            "seatProfileRph": "SP2"
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ],
            "segments": [
                {
                    "rph": "SEG1",
                    "departure": {
                        "location": {
                            "code": "TLV"
                        },
                        "date": "2025-03-15",
                        "time": "00:50:00"
                    },
                    "arrival": {
                        "location": {
                            "code": "JFK"
                        },
                        "date": "2025-03-15",
                        "time": "06:00:00"
                    },
                    "numberOfStops": 0,
                    "type": "FLIGHT"
                }
            ],
            "passengers": [
                {
                    "rph": "PAX1",
                    "type": "ADULT"
                }
            ],
            "services": [
                {
                    "rph": "SRV1",
                    "serviceCode": "SEAT",
                    "serviceCategory": null,
                    "description": null,
                    "media": null,
                    "rfic": null,
                    "rfics": null
                }
            ],
            "offerItems": [
                {
                    "offerItemId": "25409ee0-a2dd-4336-8128-de4a39cf2c55",
                    "price": {
                        "base": {
                            "currency": "USD",
                            "amount": "50.00"
                        },
                        "taxes": null,
                        "fees": null,
                        "total": {
                            "currency": "USD",
                            "amount": "50.00"
                        }
                    },
                    "passengerRph": "PAX1",
                    "serviceRph": "SRV1",
                    "segmentRph": "SEG1",
                    "type": "SEAT",
                    "category": "SERVICE"
                },
                {
                    "offerItemId": "f5b199c9-ebc0-401b-bd40-fc086b5e56b4",
                    "price": {
                        "base": {
                            "currency": "USD",
                            "amount": "0.00"
                        },
                        "taxes": null,
                        "fees": null,
                        "total": {
                            "currency": "USD",
                            "amount": "0.00"
                        }
                    },
                    "passengerRph": "PAX1",
                    "serviceRph": "SRV1",
                    "segmentRph": "SEG1",
                    "type": "SEAT",
                    "category": "SERVICE"
                }
            ]
        }
    }
}
  </pre>
</details>

##### Provide seat-map structure and lists available seat offers by flight offer for Round trip.
<details open>
  <summary><b>Request body</b></summary>
    <pre>
        mutation {
            findSeatAvailability(
                seatAvailabilityQuery: {offerRequest: {selectedOfferItems: [
                    {offerId: "a220060b-7820-49e9-ba1c-b02c9d299fd9", offerItemId: "acc0342b-e71e-4018-b2f0-6c6526f5f4ae:2a0b507e-1943-4435-b433-50bad588f12e"}
                    {offerId: "a220060b-7820-49e9-ba1c-b02c9d299fd9", offerItemId: "60bff682-9c0e-41a8-b386-50e12191f437:0092c2c6-8b03-47a9-b9bf-38b568f989cc"}
                ]}}
            ) {
                expiresAt
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
                    segmentRph
                    serviceRph
                    type
                }
                passengers {
                    code
                    rph
                    type
                }
                salesChannel
                seatMaps {
                    cabinCompartments {
                        deckLocation
                        firstRow
                        lastRow
                        seatColumns {
                            columnCode
                            seatCharacteristic
                        }
                        seatRows {
                            rowNumber
                            seats {
                                columnCode
                                marketingCabinRph
                                offerItems
                                remark
                                seatCharacteristics
                                seatProfileRph
                                status
                            }
                        }
                    }
                    cabinDefinitions {
                        cabinType
                        description
                        rph
                        title
                    }
                    seatCharacteristicDefinitions {
                        description
                        seatCharacteristic
                    }
                    seatProfiles {
                        description
                        media {
                            description
                            type
                            uri
                        }
                        rph
                        seatCharacteristics
                        title
                    }
                    segmentRph
                }
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
    "findSeatAvailability": {
      "offerId": "eb33c11c-d51b-411d-ae85-a0a9fa3b74f8",
      "expiresAt": "2025-03-02T21:07:24.460Z",
      "salesChannel": "IBE",
      "seatMaps": [
        {
          "segmentRph": "SEG1",
          "cabinDefinitions": [
            {
              "rph": "CABIN1",
              "cabinType": "ECONOMY_CLASS",
              "title": "Economy",
              "description": null
            }
          ],
          "seatCharacteristicDefinitions": [
            {
              "description": "test description text",
              "seatCharacteristic": "WINDOW_SEAT"
            },
            {
              "description": "seat test description",
              "seatCharacteristic": "LEG_SPACE_SEAT"
            }
          ],
          "seatProfiles": [
            {
              "rph": "SP1",
              "title": "Standard seat",
              "seatCharacteristics": null,
              "media": [
                {
                  "type": "ICON",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNjI1IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSJ3aGl0ZSIgc3Ryb2tlPSIjNTA1MDUwIi8+CjxyZWN0IHg9IjAuNSIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0id2hpdGUiIHN0cm9rZT0iIzUwNTA1MCIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC42MjUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSJ3aGl0ZSIgc3Ryb2tlPSIjNTA1MDUwIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMjU2OCIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0id2hpdGUiIHN0cm9rZT0iIzUwNTA1MCIvPgo8L3N2Zz4=",
                  "description": null
                },
                {
                  "type": "ICON_SELECTED",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNjI1IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSIjNTA1MDUwIiBzdHJva2U9IiNmZmYiLz4KPHJlY3QgeD0iMC41IiB5PSIyOC42MjUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjNTA1MDUwIiBzdHJva2U9IiNmZmYiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iIzUwNTA1MCIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMjU2OCIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iIzUwNTA1MCIgc3Ryb2tlPSIjZmZmIi8+Cjwvc3ZnPg==",
                  "description": null
                },
                {
                  "type": "ICON_UNAVAILABLE",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43NzcxIiB5PSIyMC42MjUiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIwLjQ5OTI2OCIgeT0iMjguNjI1IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0U5RTlFOSIgc3Ryb2tlPSIjRDNEM0QzIi8+CjxyZWN0IHg9IjMxLjExMDYiIHk9IjI4LjYyNSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIzLjY2NTc3IiB5PSI0OS4yNTY4IiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHBhdGggZD0iTTE4Ljk5OTggMzYuNTc3OUwyMy4xMjQ2IDMyLjQ1MzFMMjQuMzAzMSAzMy42MzE2TDIwLjE3ODMgMzcuNzU2NEwyNC4zMDMxIDQxLjg4MTJMMjMuMTI0NiA0My4wNTk3TDE4Ljk5OTggMzguOTM0OUwxNC44NzUgNDMuMDU5N0wxMy42OTY1IDQxLjg4MTJMMTcuODIxMyAzNy43NTY0TDEzLjY5NjUgMzMuNjMxNkwxNC44NzUgMzIuNDUzMUwxOC45OTk4IDM2LjU3NzlaIiBmaWxsPSIjRDNEM0QzIi8+Cjwvc3ZnPg==",
                  "description": null
                }
              ],
              "description": [
                "description one",
                "description two",
                "description three"
              ]
            },
            {
              "rph": "SP2",
              "title": "window",
              "seatCharacteristics": [
                "WINDOW_SEAT"
              ],
              "media": [
                {
                  "type": "ICON",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41MjA3NTIiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTIwNzUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjQ0NFQ0Y0IiBzdHJva2U9IiMwMDgyOUYiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iOC41MjA3NSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8cmVjdCB4PSIzLjY2NjUiIHk9IjI5LjE1MjYiIHdpZHRoPSIzMC42NjY3IiBoZWlnaHQ9IjYuMzg4ODkiIHJ4PSIyLjUiIGZpbGw9IiNDQ0VDRjQiIHN0cm9rZT0iIzAwODI5RiIvPgo8L3N2Zz4=",
                  "description": null
                },
                {
                  "type": "ICON_SELECTED",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41NDE1MDQiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI0U5RTlFOSIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTQxNSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI0U5RTlFOSIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSI4LjU0MTUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjMTk2Mjc5IiBzdHJva2U9IiNFOUU5RTkiLz4KPHJlY3QgeD0iMy42NjY1IiB5PSIyOS4xNzMzIiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjMTk2Mjc5IiBzdHJva2U9IiNFOUU5RTkiLz4KPC9zdmc+",
                  "description": null
                },
                {
                  "type": "ICON_UNAVAILABLE",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzciIHZpZXdCb3g9IjAgMCAzOCAzNyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMC41MjA3NTIiIHdpZHRoPSIyNi40NDQ0IiBoZWlnaHQ9IjI5LjYxMTEiIHJ4PSIzLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIwLjUiIHk9IjguNTIwNzUiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMzEuMTExMyIgeT0iOC41MjA3NSIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cmVjdCB4PSIzLjY2NjUiIHk9IjI5LjE1MjYiIHdpZHRoPSIzMC42NjY3IiBoZWlnaHQ9IjYuMzg4ODkiIHJ4PSIyLjUiIGZpbGw9IiNFOUU5RTkiIHN0cm9rZT0iI0QzRDNEMyIvPgo8cGF0aCBkPSJNMTkuMDAwNiAxNS40NzM3TDIzLjEyNTMgMTEuMzQ4OUwyNC4zMDM4IDEyLjUyNzRMMjAuMTc5MSAxNi42NTIyTDI0LjMwMzggMjAuNzc2OUwyMy4xMjUzIDIxLjk1NTRMMTkuMDAwNiAxNy44MzA3TDE0Ljg3NTggMjEuOTU1NEwxMy42OTczIDIwLjc3NjlMMTcuODIyMSAxNi42NTIyTDEzLjY5NzMgMTIuNTI3NEwxNC44NzU4IDExLjM0ODlMMTkuMDAwNiAxNS40NzM3WiIgZmlsbD0iI0QzRDNEMyIvPgo8L3N2Zz4=",
                  "description": null
                }
              ],
              "description": [
                "test description text"
              ]
            },
            {
              "rph": "SP3",
              "title": "extralegroom",
              "seatCharacteristics": [
                "LEG_SPACE_SEAT"
              ],
              "media": [
                {
                  "type": "ICON",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iIzBDMzEzQyIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0id2hpdGUiLz4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNTIwOCIgd2lkdGg9IjI2LjQ0NDQiIGhlaWdodD0iMjkuNjExMSIgcng9IjMuNSIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+CjxyZWN0IHg9IjAuNSIgeT0iMjguMDI3NiIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiNEMkU0RUEiIHN0cm9rZT0iIzE5NjI3OSIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMTUyNiIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iI0QyRTRFQSIgc3Ryb2tlPSIjMTk2Mjc5Ii8+Cjwvc3ZnPg==",
                  "description": null
                },
                {
                  "type": "ICON_SELECTED",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iIzBDMzEzQyIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0id2hpdGUiLz4KPHJlY3QgeD0iNS43Nzc4MyIgeT0iMjAuNTIwOCIgd2lkdGg9IjI2LjQ0NDQiIGhlaWdodD0iMjkuNjExMSIgcng9IjMuNSIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjAuNSIgeT0iMjguMDI3NiIgd2lkdGg9IjYuMzg4ODkiIGhlaWdodD0iMjYuNDQ0NCIgcng9IjMuMTk0NDQiIGZpbGw9IiMxOTYyNzkiIHN0cm9rZT0iI2ZmZiIvPgo8cmVjdCB4PSIzMS4xMTEzIiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+CjxyZWN0IHg9IjMuNjY2NSIgeT0iNDkuMTUyNiIgd2lkdGg9IjMwLjY2NjciIGhlaWdodD0iNi4zODg4OSIgcng9IjIuNSIgZmlsbD0iIzE5NjI3OSIgc3Ryb2tlPSIjZmZmIi8+Cjwvc3ZnPg==",
                  "description": null
                },
                {
                  "type": "ICON_UNAVAILABLE",
                  "uri": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iNTciIHZpZXdCb3g9IjAgMCAzOCA1NyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuNSA0LjAyMDc1QzQuNSAxLjgxMTYxIDYuMjkwODYgMC4wMjA3NTIgOC41IDAuMDIwNzUySDI5LjVDMzEuNzA5MSAwLjAyMDc1MiAzMy41IDEuODExNjEgMzMuNSA0LjAyMDc1VjE2LjAyMDhDMzMuNSAxOC4yMjk5IDMxLjcwOTEgMjAuMDIwOCAyOS41IDIwLjAyMDhIOC41QzYuMjkwODYgMjAuMDIwOCA0LjUgMTguMjI5OSA0LjUgMTYuMDIwOFY0LjAyMDc1WiIgZmlsbD0iI0U5RTlFOSIvPgo8cGF0aCBkPSJNMTcuNjgwMyAxNC4wMjA4TDE1LjUxMDMgMTAuODgwOEwxMi43MzAzIDcuMDIwNzVIMTQuMzUwM0wxNi40NzAzIDEwLjEyMDhMMTkuMzAwMyAxNC4wMjA4SDE3LjY4MDNaTTEyLjY4MDMgMTQuMDIwOEwxNS4zNTAzIDEwLjIxMDhMMTYuMjcwMyAxMS4wMDA4TDE0LjIwMDMgMTQuMDIwOEgxMi42ODAzWk0xNi42MzAzIDEwLjc3MDhMMTUuNzIwMyAxMC4wMTA4TDE3LjY4MDMgNy4wMjA3NUgxOS4yMDAzTDE2LjYzMDMgMTAuNzcwOFpNMjAuMzk0MSAxNC4wMjA4VjcuMDIwNzVIMjEuNjk0MVYxMi44MjA4SDI0LjkyNDFWMTQuMDIwOEgyMC4zOTQxWiIgZmlsbD0iI0QzRDNEMyIvPgo8cmVjdCB4PSI1Ljc3NzgzIiB5PSIyMC41MjA4IiB3aWR0aD0iMjYuNDQ0NCIgaGVpZ2h0PSIyOS42MTExIiByeD0iMy41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMC41IiB5PSIyOC4wMjc2IiB3aWR0aD0iNi4zODg4OSIgaGVpZ2h0PSIyNi40NDQ0IiByeD0iMy4xOTQ0NCIgZmlsbD0iI0U5RTlFOSIgc3Ryb2tlPSIjRDNEM0QzIi8+CjxyZWN0IHg9IjMxLjExMTMiIHk9IjI4LjAyNzYiIHdpZHRoPSI2LjM4ODg5IiBoZWlnaHQ9IjI2LjQ0NDQiIHJ4PSIzLjE5NDQ0IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHJlY3QgeD0iMy42NjY1IiB5PSI0OS4xNTI2IiB3aWR0aD0iMzAuNjY2NyIgaGVpZ2h0PSI2LjM4ODg5IiByeD0iMi41IiBmaWxsPSIjRTlFOUU5IiBzdHJva2U9IiNEM0QzRDMiLz4KPHBhdGggZD0iTTE4LjUwMDYgMzUuNDcyN0wyMi42MjUzIDMxLjM0NzlMMjMuODAzOCAzMi41MjY0TDE5LjY3OTEgMzYuNjUxMkwyMy44MDM4IDQwLjc3NkwyMi42MjUzIDQxLjk1NDVMMTguNTAwNiAzNy44Mjk3TDE0LjM3NTggNDEuOTU0NUwxMy4xOTczIDQwLjc3NkwxNy4zMjIxIDM2LjY1MTJMMTMuMTk3MyAzMi41MjY0TDE0LjM3NTggMzEuMzQ3OUwxOC41MDA2IDM1LjQ3MjdaIiBmaWxsPSIjRDNEM0QzIi8+Cjwvc3ZnPg==",
                  "description": null
                }
              ],
              "description": [
                "seat test description"
              ]
            }
          ],
          "cabinCompartments": [
            {
              "firstRow": 1,
              "lastRow": 5,
              "seatColumns": [
                {
                  "columnCode": "A",
                  "seatCharacteristic": [
                    "AISLE_SEAT",
                    "WINDOW_SEAT"
                  ]
                },
                {
                  "columnCode": null,
                  "seatCharacteristic": [
                    "NO_SEAT_AT_THIS_LOCATION"
                  ]
                },
                {
                  "columnCode": "C",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": null,
                  "seatCharacteristic": [
                    "NO_SEAT_AT_THIS_LOCATION"
                  ]
                },
                {
                  "columnCode": "D",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": null,
                  "seatCharacteristic": [
                    "NO_SEAT_AT_THIS_LOCATION"
                  ]
                },
                {
                  "columnCode": "F",
                  "seatCharacteristic": [
                    "AISLE_SEAT",
                    "WINDOW_SEAT"
                  ]
                }
              ],
              "seatRows": [
                {
                  "rowNumber": 1,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 2,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 3,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 4,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 5,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "25409ee0-a2dd-4336-8128-de4a39cf2c55"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                }
              ]
            },
            {
              "firstRow": 10,
              "lastRow": 12,
              "seatColumns": [
                {
                  "columnCode": "A",
                  "seatCharacteristic": [
                    "WINDOW_SEAT"
                  ]
                },
                {
                  "columnCode": "B",
                  "seatCharacteristic": [
                    "CENTER_SEAT"
                  ]
                },
                {
                  "columnCode": "C",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": null,
                  "seatCharacteristic": [
                    "NO_SEAT_AT_THIS_LOCATION"
                  ]
                },
                {
                  "columnCode": "D",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": "E",
                  "seatCharacteristic": [
                    "CENTER_SEAT"
                  ]
                },
                {
                  "columnCode": "F",
                  "seatCharacteristic": [
                    "WINDOW_SEAT"
                  ]
                }
              ],
              "seatRows": [
                {
                  "rowNumber": 10,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 11,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 12,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                }
              ]
            },
            {
              "firstRow": 14,
              "lastRow": 33,
              "seatColumns": [
                {
                  "columnCode": "A",
                  "seatCharacteristic": [
                    "WINDOW_SEAT"
                  ]
                },
                {
                  "columnCode": "B",
                  "seatCharacteristic": [
                    "CENTER_SEAT"
                  ]
                },
                {
                  "columnCode": "C",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": null,
                  "seatCharacteristic": [
                    "NO_SEAT_AT_THIS_LOCATION"
                  ]
                },
                {
                  "columnCode": "D",
                  "seatCharacteristic": [
                    "AISLE_SEAT"
                  ]
                },
                {
                  "columnCode": "E",
                  "seatCharacteristic": [
                    "CENTER_SEAT"
                  ]
                },
                {
                  "columnCode": "F",
                  "seatCharacteristic": [
                    "WINDOW_SEAT"
                  ]
                }
              ],
              "seatRows": [
                {
                  "rowNumber": 14,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 15,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 16,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 17,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 18,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 19,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 20,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT",
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT",
                        "EXIT_AND_EMERGENCY_EXIT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 21,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 22,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 23,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 24,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 25,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 26,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 27,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 28,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 29,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 30,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 31,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 32,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                },
                {
                  "rowNumber": 33,
                  "seats": [
                    {
                      "columnCode": "A",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    },
                    {
                      "columnCode": "B",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "C",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": null,
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_OCCUPIED",
                      "seatCharacteristics": [
                        "NO_SEAT_AT_THIS_LOCATION"
                      ],
                      "offerItems": [],
                      "seatProfileRph": null
                    },
                    {
                      "columnCode": "D",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "AISLE_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "E",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "CENTER_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP1"
                    },
                    {
                      "columnCode": "F",
                      "marketingCabinRph": "CABIN1",
                      "status": "SEAT_IS_FREE",
                      "seatCharacteristics": [
                        "WINDOW_SEAT"
                      ],
                      "offerItems": [
                        "f5b199c9-ebc0-401b-bd40-fc086b5e56b4"
                      ],
                      "seatProfileRph": "SP2"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ],
      "segments": [
        {
          "rph": "SEG1",
          "departure": {
            "location": {
              "code": "TLV"
            },
            "date": "2025-03-15",
            "time": "00:50:00"
          },
          "arrival": {
            "location": {
              "code": "JFK"
            },
            "date": "2025-03-15",
            "time": "06:00:00"
          },
          "numberOfStops": 0,
          "type": "FLIGHT"
        }
      ],
      "passengers": [
        {
          "rph": "PAX1",
          "type": "ADULT"
        }
      ],
      "services": [
        {
          "rph": "SRV1",
          "serviceCode": "SEAT",
          "serviceCategory": null,
          "description": null,
          "media": null,
          "rfic": null,
          "rfics": null
        }
      ],
      "offerItems": [
        {
          "offerItemId": "25409ee0-a2dd-4336-8128-de4a39cf2c55",
          "price": {
            "base": {
              "currency": "USD",
              "amount": "50.00"
            },
            "taxes": null,
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "50.00"
            }
          },
          "passengerRph": "PAX1",
          "serviceRph": "SRV1",
          "segmentRph": "SEG1",
          "type": "SEAT",
          "category": "SERVICE"
        },
        {
          "offerItemId": "f5b199c9-ebc0-401b-bd40-fc086b5e56b4",
          "price": {
            "base": {
              "currency": "USD",
              "amount": "0.00"
            },
            "taxes": null,
            "fees": null,
            "total": {
              "currency": "USD",
              "amount": "0.00"
            }
          },
          "passengerRph": "PAX1",
          "serviceRph": "SRV1",
          "segmentRph": "SEG1",
          "type": "SEAT",
          "category": "SERVICE"
        }
      ]
    }
  }
}
  </pre>
</details>
