# Add Service

## Add additional Service for Passengers in Initial Order

#### Request Parameters

| Parameter                       | Type | Data Type | Description   | Example                              |
|---------------------------------|------|-----------|---------------|--------------------------------------|
| addServiceOrderItem.orderId     | M    | String    | Order Id      | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| addServiceOrderItem.offerId     | M    | String    | Offer Id      | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| addServiceOrderItem.offerItemId | M    | String    | Offer Item Id | 395feee0-ce6c-491b-9644-b2c120d868d3 |


#### Request
````shell
    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
````

##### Add additional Service for Passengers (e.g. Meal, Baggage).

<details>
  <summary><b>Request body</b></summary>

````graphql
mutation ($orderId: ID!, $offerId: ID!, $offerItemId: String!, $offerItemId2: String!) {
    order: addServiceOrderItem(
        orderId: $orderId
        request: {
            offerId: $offerId
            items: [
                { offerItemId: $offerItemId, comment: "COMMENT" }
                { offerItemId: $offerItemId2, comment: "COMMENT" }
            ]
        }
    ) {
        orderId
        orderStatus
        journey {
            segments {
                rph
                type
                departure {
                    date
                    time
                }
                arrival {
                    date
                    time
                }
                numberOfStops
                ... on OrderFlightSegment {
                    flightDesignator
                    marketingFlightDesignator
                }
                ... on OrderTrainSegment {
                    trainNumber
                }
            }
        }
        passengers {
            rph
            firstName
            lastName
            paxNameGroup
            paxAge
            paxTitle
            paxPhoneNumber
            paxPhoneCountry
            paxEmail
            genderCode
            type
            address {
                address
                countryCode
                countryName
                city
                postalCode
                street
            }
            documents {
                paxDocType
                paxDocNumber
                paxDocIssuer
                paxDocIssueCountry
                placeOfBirth
                paxDocExpiry
                paxNationality
                paxBirthDate
            }
        }
        services {
            rph
            code
        }
        items {
            type
            id
            offerId
            offerItemId
            supplier {
                carrierName
            }
            status
            quantity
            price {
                direction
                total {
                    amount
                    currency
                }
                taxes {
                    taxCode
                    name
                    total {
                        currency
                        amount
                    }
                }
                fees {
                    description
                    amount {
                        currency
                        amount
                    }
                    feeType
                }
                base {
                    amount
                    currency
                }
            }
            comment
            passenger
            ... on OrderFlightItem {
                segments
                carrierCode
                ticketNumber
            }
            ... on OrderTrainItem {
                segments
                ticketNumber
            }
            ... on OrderServiceItem {
                serviceRph
            }
            ... on OrderInFlightServiceItem {
                serviceRph
                segmentRph
            }
        }
        pendingPurchase {
            purchaseId
            total {
                direction
                taxes {
                    taxCode
                    name
                    total {
                        currency
                        amount
                    }
                }
                fees {
                    description
                    amount {
                        currency
                        amount
                    }
                    feeType
                }
                total {
                    amount
                    currency
                }
                base {
                    amount
                    currency
                }
            }
            transactions {
                transactionId
                status
                amount
                currency
            }
            status
            items {
                type
                price {
                    direction
                    taxes {
                        taxCode
                        name
                        total {
                            currency
                            amount
                        }
                    }
                    fees {
                        description
                        amount {
                            currency
                            amount
                        }
                        feeType
                    }
                    total {
                        amount
                        currency
                    }
                    base {
                        amount
                        currency
                    }
                }
                associatedBookingReference {
                    bookingReference
                }
            }
        }
        availableActions {
            actionType
        }
    }
}
````
</details>

<details>
  <summary><b>Response body</b></summary>

````graphql
````
</details>
