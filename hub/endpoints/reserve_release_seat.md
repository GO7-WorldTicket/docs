# Reserve and release seat

## Reserve seat by seat availability offer

#### Request Parameters(all required)

| Parameter                                 | Type | Data Type | Description                         | Example                              |
|-------------------------------------------|------|-----------|-------------------------------------|--------------------------------------|
| request.orderId                           | M    | String    | Order identifier                    | a220060b-7820-49e9-ba1c-b02c9d299fd9 |
| request.selectedSeats.columnCode          | M    | String    | Selected seat column code           | A                                    |
| request.selectedSeats.rowNumber           | M    | String    | Selected seat row number            | 1                                    |
| request.selectedSeats.orderPassengerRphId | M    | String    | Passenger rph id from order payload | A                                    |
| request.selectedSeats.offerId             | M    | String    | Selected seat offer id              | eb33c11c-d51b-411d-ae85-a0a9fa3b74f8 |
| request.selectedSeats.offerItemId         | M    | String    | Selected seat offer item id         | 25409ee0-a2dd-4336-8128-de4a39cf2c55 |


#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Reserve seat
<details open>
  <summary><b>Request Body</b></summary>
  <pre>
mutation {
    reserveSeats(
        request: {selectedSeats: {offerId: "", offerItemId: "", orderPassengerRphId: 10, rowNumber: 10, columnCode: ""}, orderId: ""}
    ) {
        availableActions {
            actionType
        }
        bookingClasses {
            code
            marketingCode
            rph
            seats
            segmentRph
        }
        items {
            associatedBookingReference {
                bookingReference
            }
            availableActions {
                actionType
            }
            bookingConfirmation
            comment
            externalOrderId
            guarantee {
                externalOrderId
                guarantee {
                    guaranteeId
                    paymentTimeLimit
                    status
                    ticketingTimeLimit
                }
                orderItemId
                recordLocator
            }
            id
            offerId
            offerItemId
            passenger
            price {
                base {
                    amount
                    currency
                }
                direction
                feeTotal {
                    amount
                    currency
                }
                fees {
                    amount {
                        amount
                        currency
                    }
                    description
                    feeType
                }
                taxTotal {
                    amount
                    currency
                }
                taxes {
                    name
                    taxCode
                    total {
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
            quantity
            status
            supplier {
                carrierName
            }
            type
            ... on OrderFlightItem {
                id
                associatedBookingReference {
                    bookingReference
                }
                availableActions {
                    actionType
                }
                bookingConfirmation
                carrierCode
                comment
                externalOrderId
                fare {
                    bookingClasses {
                        code
                        marketingCode
                        rph
                        seats
                        segmentRph
                    }
                    fareBasisCode
                    fareDescriptions {
                        category
                        description
                    }
                }
                guarantee {
                    externalOrderId
                    guarantee {
                        guaranteeId
                        paymentTimeLimit
                        status
                        ticketingTimeLimit
                    }
                    orderItemId
                    recordLocator
                }
                offerId
                offerItemId
                originDestinationRph
                passenger
                price {
                    base {
                        amount
                        currency
                    }
                    direction
                    feeTotal {
                        amount
                        currency
                    }
                    fees {
                        amount {
                            amount
                            currency
                        }
                        description
                        feeType
                    }
                    taxTotal {
                        amount
                        currency
                    }
                    taxes {
                        name
                        taxCode
                        total {
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
                quantity
                segments
                services
                status
                supplier {
                    carrierName
                }
                ticketNumber
                type
            }
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
                    }
                    time
                }
                numberOfStops
                rph
                rphId
                status
                type
                violations
            }
        }
        orderId
        orderStatus
        originator {
            companyId
            officeId
            originatorId
        }
        passengers {
            address {
                address
                city
                countryCode
                countryName
                postalCode
                street
            }
            careTaker {
                passengerId
            }
            code
            documents {
                paxBirthDate
                paxDocExpiry
                paxDocIssueCountry
                paxDocIssuer
                paxDocNumber
                paxDocType
                paxNationality
                placeOfBirth
            }
            exchangedPassenger {
                passengerId
            }
            firstName
            genderCode
            lastName
            passengerId
            paxAge
            paxEmail
            paxNameGroup
            paxPhoneCountry
            paxPhoneNumber
            paxTitle
            rph
            rphId
            type
        }
        pendingPurchase {
            bookingClasses {
                code
                marketingCode
                rph
                seats
                segmentRph
            }
            items {
                comment
                externalOrderId
                guarantee {
                    externalOrderId
                    guarantee {
                        guaranteeId
                        paymentTimeLimit
                        status
                        ticketingTimeLimit
                    }
                    orderItemId
                    recordLocator
                }
                id
                offerId
                offerItemId
                passenger
            }
            journey {
                duration
                rph
            }
            purchaseId
            services {
                rfic
                description
                rfics
                rph
                serviceCategory
                serviceCode
                serviceName
            }
            status
            timeToLive
            total {
                direction
                base {
                    amount
                    currency
                }
                feeTotal {
                    amount
                    currency
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
        pointOfSale {
            salesChannel
            userId
        }
        purchasesTotal {
            direction
            total {
                amount
                currency
            }
        }
        tenant
    }
}
  </pre>
</details>

<details open>
  <summary><b>Response Body</b></summary>
  <pre>
{
    "data": {
        "order": {
            "orderId": "54a7b265-8a3c-4f01-a83f-ae0d00cd1172",
            "orderStatus": "DRAFT",
            "journey": [
                {
                    "segments": [
                        {
                            "type": "FLIGHT",
                            "departure": {
                                "date": "2025-03-15",
                                "time": "00:50:00"
                            },
                            "arrival": {
                                "date": "2025-03-15",
                                "time": "06:00:00"
                            },
                            "numberOfStops": 0,
                            "flightDesignator": "PL0001"
                        }
                    ]
                }
            ],
            "passengers": [
                {
                    "rph": "PAX1",
                    "firstName": null,
                    "lastName": null,
                    "paxNameGroup": null,
                    "paxAge": null,
                    "paxTitle": null,
                    "paxPhoneNumber": null,
                    "paxPhoneCountry": null,
                    "paxEmail": null,
                    "genderCode": null,
                    "type": "ADULT",
                    "address": null,
                    "documents": []
                }
            ],
            "services": [
                {
                    "rph": "SRV1",
                    "code": "SEAT"
                }
            ],
            "items": [
                {
                    "type": "FLIGHT",
                    "id": "ac355ce6-de65-4423-a753-0715fb2ef908",
                    "offerId": "2e2c55ca-e563-4167-9b8f-c6fafad122d7",
                    "offerItemId": "aa4f43f8-8e25-4d68-b849-7bbc6573ee2a:1437a03c-d27d-4b6f-b19a-ce370d8e8580",
                    "supplier": null,
                    "status": "ADDED",
                    "quantity": 1,
                    "price": {
                        "direction": "PAYMENT",
                        "total": {
                            "amount": "430.00",
                            "currency": "USD"
                        },
                        "taxes": [
                            {
                                "taxCode": "TAX 1",
                                "name": "TAX 1",
                                "total": {
                                    "currency": "USD",
                                    "amount": "30.00"
                                }
                            }
                        ],
                        "fees": [],
                        "base": {
                            "amount": "400.00",
                            "currency": "USD"
                        }
                    },
                    "comment": null,
                    "passenger": "PAX1",
                    "segments": [
                        "SEG1"
                    ],
                    "carrierCode": "PLR"
                },
                {
                    "type": "SEAT_FEE",
                    "id": "f11a4c72-fb74-422e-8dbf-8ed97fd5933d",
                    "offerId": "d8680173-86cd-4ca4-849a-c6f17c9bb330",
                    "offerItemId": "99031f08-513f-47e7-8a4f-02216f0faa48",
                    "supplier": null,
                    "status": "ADDED",
                    "quantity": 1,
                    "price": {
                        "direction": "PAYMENT",
                        "total": {
                            "amount": "0.00",
                            "currency": "USD"
                        },
                        "taxes": [],
                        "fees": [],
                        "base": {
                            "amount": "0.00",
                            "currency": "USD"
                        }
                    },
                    "comment": null,
                    "passenger": "PAX1",
                    "rowNumber": 11,
                    "columnCode": "C",
                    "serviceRph": "SRV1",
                    "segmentRph": "SEG1"
                }
            ],
            "availableActions": null,
            "pendingPurchase": {
                "total": {
                    "direction": "PAYMENT",
                    "taxes": [
                        {
                            "taxCode": "TAX 1",
                            "name": "TAX 1",
                            "total": {
                                "currency": "USD",
                                "amount": "30.00"
                            }
                        }
                    ],
                    "fees": [],
                    "total": {
                        "amount": "430.00",
                        "currency": "USD"
                    },
                    "base": {
                        "amount": "400.00",
                        "currency": "USD"
                    }
                },
                "transactions": [],
                "status": "ADDED",
                "items": [
                    {
                        "type": "FLIGHT",
                        "id": "ac355ce6-de65-4423-a753-0715fb2ef908",
                        "offerId": "2e2c55ca-e563-4167-9b8f-c6fafad122d7",
                        "offerItemId": "aa4f43f8-8e25-4d68-b849-7bbc6573ee2a:1437a03c-d27d-4b6f-b19a-ce370d8e8580",
                        "supplier": null,
                        "status": "ADDED",
                        "quantity": 1,
                        "price": {
                            "direction": "PAYMENT",
                            "total": {
                                "amount": "430.00",
                                "currency": "USD"
                            },
                            "taxes": [
                                {
                                    "taxCode": "TAX 1",
                                    "name": "TAX 1",
                                    "total": {
                                        "currency": "USD",
                                        "amount": "30.00"
                                    }
                                }
                            ],
                            "fees": [],
                            "base": {
                                "amount": "400.00",
                                "currency": "USD"
                            }
                        },
                        "comment": null,
                        "passenger": "PAX1",
                        "originDestinationRph": "OD1",
                        "segments": [
                            "SEG1"
                        ],
                        "services": [],
                        "carrierCode": "PLR",
                        "ticketNumber": null
                    },
                    {
                        "type": "SEAT_FEE",
                        "id": "f11a4c72-fb74-422e-8dbf-8ed97fd5933d",
                        "offerId": "d8680173-86cd-4ca4-849a-c6f17c9bb330",
                        "offerItemId": "99031f08-513f-47e7-8a4f-02216f0faa48",
                        "supplier": null,
                        "status": "ADDED",
                        "quantity": 1,
                        "price": {
                            "direction": "PAYMENT",
                            "total": {
                                "amount": "0.00",
                                "currency": "USD"
                            },
                            "taxes": [],
                            "fees": [],
                            "base": {
                                "amount": "0.00",
                                "currency": "USD"
                            }
                        },
                        "comment": null,
                        "passenger": "PAX1",
                        "serviceRph": "SRV1",
                        "segmentRph": "SEG1",
                        "rowNumber": 11,
                        "columnCode": "C"
                    }
                ]
            }
        }
    }
}
  </pre>
</details>

## Release seat

#### Request Parameters (all required)

| Parameter           | Type | Data Type | Description                   | Example                              |
|---------------------|------|-----------|-------------------------------|--------------------------------------|
| request.orderId     | M    | String    | Order identifier              | a220060b-7820-49e9-ba1c-b02c9d299fd9 |
| request.seatItemIds | M    | String    | Selected seat item identifier | eb33c11c-d51b-688d-ae99-a0a9fa3b74f8 |


#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Release seat
<details open>
  <summary><b>Request Body</b></summary>
  <pre>
mutation {
    releaseSeats(request: {orderId: "a220060b-7820-49e9-ba1c-b02c9d299fd9", seatItemIds: "eb33c11c-d51b-688d-ae99-a0a9fa3b74f8"})
     {
        availableActions {
            actionType
        }
        bookingClasses {
            code
            marketingCode
            rph
            seats
            segmentRph
        }
        items {
            associatedBookingReference {
                bookingReference
            }
            availableActions {
                actionType
            }
            bookingConfirmation
            comment
            externalOrderId
            guarantee {
                externalOrderId
                guarantee {
                    guaranteeId
                    paymentTimeLimit
                    status
                    ticketingTimeLimit
                }
                orderItemId
                recordLocator
            }
            id
            offerId
            offerItemId
            passenger
            price {
                base {
                    amount
                    currency
                }
                direction
                feeTotal {
                    amount
                    currency
                }
                fees {
                    amount {
                        amount
                        currency
                    }
                    description
                    feeType
                }
                taxTotal {
                    amount
                    currency
                }
                taxes {
                    name
                    taxCode
                    total {
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
            quantity
            status
            supplier {
                carrierName
            }
            type
            ... on OrderFlightItem {
                id
                associatedBookingReference {
                    bookingReference
                }
                availableActions {
                    actionType
                }
                bookingConfirmation
                carrierCode
                comment
                externalOrderId
                fare {
                    bookingClasses {
                        code
                        marketingCode
                        rph
                        seats
                        segmentRph
                    }
                    fareBasisCode
                    fareDescriptions {
                        category
                        description
                    }
                }
                guarantee {
                    externalOrderId
                    guarantee {
                        guaranteeId
                        paymentTimeLimit
                        status
                        ticketingTimeLimit
                    }
                    orderItemId
                    recordLocator
                }
                offerId
                offerItemId
                originDestinationRph
                passenger
                price {
                    base {
                        amount
                        currency
                    }
                    direction
                    feeTotal {
                        amount
                        currency
                    }
                    fees {
                        amount {
                            amount
                            currency
                        }
                        description
                        feeType
                    }
                    taxTotal {
                        amount
                        currency
                    }
                    taxes {
                        name
                        taxCode
                        total {
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
                quantity
                segments
                services
                status
                supplier {
                    carrierName
                }
                ticketNumber
                type
            }
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
                    }
                    time
                }
                numberOfStops
                rph
                rphId
                status
                type
                violations
            }
        }
        orderId
        orderStatus
        originator {
            companyId
            officeId
            originatorId
        }
        passengers {
            address {
                address
                city
                countryCode
                countryName
                postalCode
                street
            }
            careTaker {
                passengerId
            }
            code
            documents {
                paxBirthDate
                paxDocExpiry
                paxDocIssueCountry
                paxDocIssuer
                paxDocNumber
                paxDocType
                paxNationality
                placeOfBirth
            }
            exchangedPassenger {
                passengerId
            }
            firstName
            genderCode
            lastName
            passengerId
            paxAge
            paxEmail
            paxNameGroup
            paxPhoneCountry
            paxPhoneNumber
            paxTitle
            rph
            rphId
            type
        }
        pendingPurchase {
            bookingClasses {
                code
                marketingCode
                rph
                seats
                segmentRph
            }
            items {
                comment
                externalOrderId
                guarantee {
                    externalOrderId
                    guarantee {
                        guaranteeId
                        paymentTimeLimit
                        status
                        ticketingTimeLimit
                    }
                    orderItemId
                    recordLocator
                }
                id
                offerId
                offerItemId
                passenger
            }
            journey {
                duration
                rph
            }
            purchaseId
            services {
                rfic
                description
                rfics
                rph
                serviceCategory
                serviceCode
                serviceName
            }
            status
            timeToLive
            total {
                direction
                base {
                    amount
                    currency
                }
                feeTotal {
                    amount
                    currency
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
        pointOfSale {
            salesChannel
            userId
        }
        purchasesTotal {
            direction
            total {
                amount
                currency
            }
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
        "order": {
            "orderId": "54a7b265-8a3c-4f01-a83f-ae0d00cd1172",
            "orderStatus": "DRAFT",
            "journey": [
                {
                    "segments": [
                        {
                            "type": "FLIGHT",
                            "departure": {
                                "date": "2025-03-15",
                                "time": "00:50:00"
                            },
                            "arrival": {
                                "date": "2025-03-15",
                                "time": "06:00:00"
                            },
                            "numberOfStops": 0,
                            "flightDesignator": "PL0001"
                        }
                    ]
                }
            ],
            "passengers": [
                {
                    "rph": "PAX1",
                    "firstName": null,
                    "lastName": null,
                    "paxNameGroup": null,
                    "paxAge": null,
                    "paxTitle": null,
                    "paxPhoneNumber": null,
                    "paxPhoneCountry": null,
                    "paxEmail": null,
                    "genderCode": null,
                    "type": "ADULT",
                    "address": null,
                    "documents": []
                }
            ],
            "services": [
                {
                    "rph": "SRV1",
                    "code": "SEAT"
                }
            ],
            "items": [
                {
                    "type": "FLIGHT",
                    "id": "ac355ce6-de65-4423-a753-0715fb2ef908",
                    "offerId": "2e2c55ca-e563-4167-9b8f-c6fafad122d7",
                    "offerItemId": "aa4f43f8-8e25-4d68-b849-7bbc6573ee2a:1437a03c-d27d-4b6f-b19a-ce370d8e8580",
                    "supplier": null,
                    "status": "ADDED",
                    "quantity": 1,
                    "price": {
                        "direction": "PAYMENT",
                        "total": {
                            "amount": "430.00",
                            "currency": "USD"
                        },
                        "taxes": [],
                        "fees": [],
                        "base": {
                            "amount": "400.00",
                            "currency": "USD"
                        }
                    },
                    "comment": null,
                    "passenger": "PAX1",
                    "segments": [
                        "SEG1"
                    ],
                    "carrierCode": "PLR"
                },
                {
                    "type": "SEAT_FEE",
                    "id": "f11a4c72-fb74-422e-8dbf-8ed97fd5933d",
                    "offerId": "d8680173-86cd-4ca4-849a-c6f17c9bb330",
                    "offerItemId": "99031f08-513f-47e7-8a4f-02216f0faa48",
                    "supplier": null,
                    "status": "CANCELLED",
                    "quantity": 1,
                    "price": {
                        "direction": "PAYMENT",
                        "total": {
                            "amount": "0.00",
                            "currency": "USD"
                        },
                        "taxes": [],
                        "fees": [],
                        "base": {
                            "amount": "0.00",
                            "currency": "USD"
                        }
                    },
                    "comment": null,
                    "passenger": "PAX1",
                    "rowNumber": 11,
                    "columnCode": "C",
                    "serviceRph": "SRV1",
                    "segmentRph": "SEG1"
                }
            ],
            "availableActions": null,
            "pendingPurchase": {
                "total": {
                    "direction": "PAYMENT",
                    "taxes": [],
                    "fees": [],
                    "total": {
                        "amount": "430.00",
                        "currency": "USD"
                    },
                    "base": {
                        "amount": "400.00",
                        "currency": "USD"
                    }
                },
                "transactions": [],
                "status": "ADDED",
                "items": [
                    {
                        "type": "FLIGHT",
                        "id": "ac355ce6-de65-4423-a753-0715fb2ef908",
                        "offerId": "2e2c55ca-e563-4167-9b8f-c6fafad122d7",
                        "offerItemId": "aa4f43f8-8e25-4d68-b849-7bbc6573ee2a:1437a03c-d27d-4b6f-b19a-ce370d8e8580",
                        "supplier": null,
                        "status": "ADDED",
                        "quantity": 1,
                        "price": {
                            "direction": "PAYMENT",
                            "total": {
                                "amount": "430.00",
                                "currency": "USD"
                            },
                            "taxes": [],
                            "fees": [],
                            "base": {
                                "amount": "400.00",
                                "currency": "USD"
                            }
                        },
                        "comment": null,
                        "passenger": "PAX1",
                        "originDestinationRph": "OD1",
                        "segments": [
                            "SEG1"
                        ],
                        "services": [],
                        "carrierCode": "PLR",
                        "ticketNumber": null
                    }
                ]
            }
        }
    }
}
  </pre>
</details>

#### Error messages

| Message                                                                                                                           | Description                                                                             |
|-----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| Order with id {s} not found                                                                                                       | Unable to find order by provided order id. Make sure that provided order id is correct. |
| Passenger with rph {n} already contains reserved seat {s}/{s} for segment with rph {n}. Release it first before reserving new one | Release already reserved seat before reserve new one                                    |
| For given order items guarantee failed: {s}                                                                                       | Reserve/release operation failed on PSS side                                            |



