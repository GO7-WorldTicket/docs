# Update Passenger

## Update Passenger's data in Initial Order

#### Request Parameters

| Parameter                    | Type | Data Type | Description          | Example                              |
|------------------------------|------|-----------|----------------------|--------------------------------------|
| updatePassengers.orderId     | M    | String    | Start departure date | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| updatePassengers.passengerId | M    | String    | Passenger identifier | 395feee0-ce6c-491b-9644-b2c120d868d3 |
| updatePassengers.paxname     | O    | String    | Passenger Name       | John                                 |
| updatePassengers.paxlastname | O    | String    | Passenger Last name  | Doe                                  |
| updatePassengers.paxname     | O    | String    | Passenger Email      | John.Doe@example.com                 |


#### Request
````shell
    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
````

##### Update all Passengers data.

<details>
  <summary><b>Request body</b></summary>

````graphql
mutation updatePassengers
(
    $orderId: ID!,
    $passengerId: ID!,
    $paxname: String!,
    $paxlastname: String!,
    $paxemail: String!
)
{
    updatePassengers(
        orderId: $orderId
        request: {
            passengers: [
                {
                    passengerId: $passengerId
                    firstName: $paxname
                    lastName: $paxlastname
                    paxNameGroup: "Fast group"
                    paxAge: 29
                    paxTitle: "MRS"
                    paxPhoneNumber: "+3-8060-111-22-33"
                    paxPhoneCountry: "US"
                    paxEmail: $paxemail
                    genderCode: FEMALE
                    type: ADULT
                    address: {
                        address: "39b"
                        countryCode: "UA"
                        countryName: "Ukraine"
                        city: "Kyiv"
                        postalCode: "01240"
                        street: "Test street lane"
                    }
                    documents: [
                        {
                            paxDocType: "PP"
                            paxDocNumber: "123123"
                            paxDocIssuer: "UA government"
                            paxDocIssueCountry: "UA"
                            paxDocExpiry: "2030-01-01"
                            paxNationality: "UA"
                            paxBirthDate: "1994-02-11"
                            placeOfBirth: "UA"
                        }
                    ]
                }
            ]
        }
    ) {
        orderId
        passengers {
            rph
            passengerId
            firstName
            lastName
            paxNameGroup
            paxAge
            paxTitle
            paxPhoneNumber
            paxPhoneCountry
            paxEmail
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
                paxDocExpiry
                paxNationality
                paxBirthDate
            }
            careTaker {
                passengerId
            }
        }
    }
}
````
</details>

<details>
  <summary><b>Response body</b></summary>

````graphql
{
	"data": {
		"order": {
			"orderId": "506df3e6-55eb-4dcc-b9da-9dd7ea0bf946",
			"orderStatus": "DRAFT",
			"tenant": "polar",
			"items": [
				{
					"guarantee": {
						"externalOrderId": "55600796",
						"recordLocator": "5957F982",
						"guarantee": {
							"guaranteeId": "64f01f5f-54d0-444a-83f0-a956f6658f64",
							"status": "SUCCEEDED",
							"paymentTimeLimit": "2025-02-28T15:43Z",
							"ticketingTimeLimit": "2025-03-01T15:23Z"
						}
					}
				}
			]
		}
	}
}
````
</details>
