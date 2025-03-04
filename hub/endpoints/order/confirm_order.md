# Add Service

## Add additional Service for Passengers in Initial Order

#### Request Parameters

| Parameter           | Type | Data Type | Description         | Example                              |
|---------------------|------|-----------|---------------------|--------------------------------------|
| confirm.orderId     | M    | String    | Order Id            | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| confirm.total       | M    | String    | Total cost          | 430.00                               |
| confirm.paxname     | O    | String    | Passenger Name      | John                                 |
| confirm.paxlastname | O    | String    | Passenger Last name | Doe                                  |
| confirm.paxname     | O    | String    | Passenger Email     | John.Doe@example.com                 |


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

```json
mutation (
    $orderId: ID!
    $total: BigDecimal!
    $paxname: String!
    $paxlastname: String!
    $paxemail: String!
) {
    payment: confirm(
        request: {
            orderId: $orderId
            paymentOption: {
                paymentType: CASH
                paymentMethod: CASH
                name: "CASH"
                paymentFeeAmount: 0
                paymentFeeCurrency: "USD"
                description: "empty"
                providerName: null
                submitMethod: null
                totalAmount: $total
                totalCurrency: "USD"
            }
            buyer: {
                firstName: $paxname
                lastName: $paxlastname
                countryCode: { code: "US" }
                city: "Kyiv"
                address: "Random Str, 69"
                postalCode: "02140"
                phone: "+380601233344"
                email: $paxemail
                locale: "ENGLISH"
            }
            clientRedirectUri: "http://localhost:8080"
        }
    ) {
        id
        createDateTime
        expirationDateTime
        paymentTransactionType
        purchaseId
        buyer {
            firstName
            lastName
            countryCode
            city
            address
            postalCode
            phone
            email
            locale
        }
        salesChannel
        route {
            departureAirport {
                code
            }
            arrivalAirport {
                code
            }
        }
        orderId
        externalOrderId
        recordLocator
        totalInOrderAmount
        totalInOrderCurrency
        addendumData
        paymentConfigurationName
        paymentType
        paymentMethod
        paymentFeeAmount
        paymentFeeCurrency
        totalAmount
        totalCurrency
        comment
        providerTransaction {
            id
            externalProviderTransactionId
            transactionStatus
            paymentDateTime
            failureReason
            additionalData
            redirectUrl
            acsUrl
            paReq
            creditCardType
            creditCardNumber
            capturedAmount
            capturedCurrency
        }
        clientRedirectUri
        cancellationReason
        version
        airlineData {
            passengerFirstName
            passengerLastName
            passengerType
            genderCode
            passengerBirthDate
            ticketDataList {
                origin
                destination
                carrier
                clazz
                fareBasis
                flightNumber
                departureDate
                arrivalDate
                ticketNumber {
                    accountingCode
                    number
                }
                descrCode
                couponNumber
                taxes {
                    taxCode
                    name
                    total {
                        currency
                        amount
                    }
                }
                ancillaries {
                    ancillaryCode
                    ancillaryDesc
                    totalAmount
                    baseAmount
                    taxTotal
                }
            }
        }
    }
}
```

</details>

<details>
  <summary><b>Response body</b></summary>

```graphql
```
</details>
# Add Service

## Add additional Service for Passengers in Initial Order

#### Request Parameters

| Parameter           | Type | Data Type | Description         | Example                              |
|---------------------|------|-----------|---------------------|--------------------------------------|
| confirm.orderId     | M    | String    | Order Id            | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| confirm.total       | M    | String    | Total cost          | 430.00                               |
| confirm.paxname     | O    | String    | Passenger Name      | John                                 |
| confirm.paxlastname | O    | String    | Passenger Last name | Doe                                  |
| confirm.paxname     | O    | String    | Passenger Email     | John.Doe@example.com                 |


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

```json
mutation (
    $orderId: ID!
    $total: BigDecimal!
    $paxname: String!
    $paxlastname: String!
    $paxemail: String!
) {
    payment: confirm(
        request: {
            orderId: $orderId
            paymentOption: {
                paymentType: CASH
                paymentMethod: CASH
                name: "CASH"
                paymentFeeAmount: 0
                paymentFeeCurrency: "USD"
                description: "empty"
                providerName: null
                submitMethod: null
                totalAmount: $total
                totalCurrency: "USD"
            }
            buyer: {
                firstName: $paxname
                lastName: $paxlastname
                countryCode: { code: "US" }
                city: "Kyiv"
                address: "Random Str, 69"
                postalCode: "02140"
                phone: "+380601233344"
                email: $paxemail
                locale: "ENGLISH"
            }
            clientRedirectUri: "http://localhost:8080"
        }
    ) {
        id
        createDateTime
        expirationDateTime
        paymentTransactionType
        purchaseId
        buyer {
            firstName
            lastName
            countryCode
            city
            address
            postalCode
            phone
            email
            locale
        }
        salesChannel
        route {
            departureAirport {
                code
            }
            arrivalAirport {
                code
            }
        }
        orderId
        externalOrderId
        recordLocator
        totalInOrderAmount
        totalInOrderCurrency
        addendumData
        paymentConfigurationName
        paymentType
        paymentMethod
        paymentFeeAmount
        paymentFeeCurrency
        totalAmount
        totalCurrency
        comment
        providerTransaction {
            id
            externalProviderTransactionId
            transactionStatus
            paymentDateTime
            failureReason
            additionalData
            redirectUrl
            acsUrl
            paReq
            creditCardType
            creditCardNumber
            capturedAmount
            capturedCurrency
        }
        clientRedirectUri
        cancellationReason
        version
        airlineData {
            passengerFirstName
            passengerLastName
            passengerType
            genderCode
            passengerBirthDate
            ticketDataList {
                origin
                destination
                carrier
                clazz
                fareBasis
                flightNumber
                departureDate
                arrivalDate
                ticketNumber {
                    accountingCode
                    number
                }
                descrCode
                couponNumber
                taxes {
                    taxCode
                    name
                    total {
                        currency
                        amount
                    }
                }
                ancillaries {
                    ancillaryCode
                    ancillaryDesc
                    totalAmount
                    baseAmount
                    taxTotal
                }
            }
        }
    }
}
```
</details>

<details>
  <summary><b>Response body</b></summary>

```graphql
```
</details>
