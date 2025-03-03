# Get Order

## Create Order from some Offer available in the system

#### Request Parameters

| Parameter                             | Type | Data Type | Description            | Example                                    |
|---------------------------------------|------|-----------|------------------------|--------------------------------------------|
| getOrder.OrderId                      | M    | String    | Start departure date   | 2c888e14-d078-4aa4-bd2c-d57166056c51       |

#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Lists available dates per route. Usually used in the calendar picker.

<details>
  <summary><b>Request body</b></summary>

````graphql
query getOrder($orderId: ID!) {
	order: order(id: $orderId) {
		orderId
		orderStatus
		tenant
		originator {
			originatorId
			officeId
			companyId
		}
		purchasesTotal {
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
		services {
			rph
			code
			description {
				text
				link
				media {
					uri
					description
				}
			}
			rfic
			rfisc
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
				vat {amount currency}
			}
			comment
			... on OrderFlightItem {
				originDestinationRph
				segments
				services
				carrierCode
			}
			... on OrderTrainItem {
				originDestinationRph
				segments
			}
			... on OrderServiceItem {
				serviceRph
			}
			... on OrderInFlightServiceItem {
				serviceRph
			}
			... on SeatOrderItem {
                rowNumber
                columnCode
                serviceRph
                segmentRph
            }
		}
		passengers {
			rph
			rphId
			passengerId
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
				paxDocExpiry
				paxNationality
				paxBirthDate
				placeOfBirth
			}
			careTaker {
				passengerId
			}
		}
		journey {
			rph
			segments {
				rph
				rphId
				numberOfStops
				type
				departure {
					date
					time
					location {
						code
					}
				}
				arrival {
					date
					time
					location {
						code
					}
				}
				... on OrderFlightSegment {
					flightDesignator
				}
				... on OrderTrainSegment {
					trainNumber
				}
			}
		}
		pendingPurchase {
			purchaseId
			timeToLive
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
				vat {amount currency}
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
					vat {
						amount
						currency
					}
					total {
						amount
						currency
					}
					base {
						amount
						currency
					}
					vat {amount currency}
				}
				associatedBookingReference {
					bookingReference
				}
			}
		}
	}
}
````
</details>

  <pre>
Mandatory fields:
<table><tr><th>Field name</th>
        <th>Field type</th>
        <th>Example</th>
      </tr>
      <tr>
        <td>orderId</td>
        <td>String</td>
        <td>506df3e6-55eb-4dcc-b9da-9dd7ea0bf94</td>
      </tr>
</table>
  </pre>

<details>
  <summary><b>Response body</b></summary>

````graphql
{
	"data": {
		"order": {
			"orderId": "2c888e14-d078-4aa4-bd2c-d57166056c51",
			"orderStatus": "DRAFT",
			"tenant": "polar",
			"originator": null,
			"purchasesTotal": {
				"direction": "PAYMENT",
				"taxes": [],
				"fees": [],
				"total": {
					"amount": "0.00",
					"currency": "USD"
				},
				"base": {
					"amount": "0.00",
					"currency": "USD"
				}
			},
			"services": [],
			"items": [
				{
					"type": "FLIGHT",
					"id": "4d594cee-9f08-4063-bdbc-9d2ddc8e3ea9",
					"offerId": "395feee0-ce6c-491b-9644-b2c120d868d3",
					"offerItemId": "b5a2dfbb-2c1b-414e-a5f4-8ce5b46fe1a6:da821e5c-eba1-4c97-9240-620548aff8ae",
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
					"passenger": "PAX1",
					"comment": null,
					"originDestinationRph": "OD1",
					"segments": [
						"SEG1"
					],
					"services": [],
					"carrierCode": "PLR"
				}
			],
			"passengers": [
				{
					"rph": "PAX1",
					"passengerId": "b7159ade-450b-4696-82b1-eccbdaff75a9",
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
					"documents": [],
					"careTaker": null
				}
			],
			"journey": [
				{
					"rph": "OD1",
					"segments": [
						{
							"rph": "SEG1",
							"type": "FLIGHT",
							"departure": {
								"date": "2025-03-05",
								"time": "01:55:00",
								"location": {
									"code": "JFK"
								}
							},
							"arrival": {
								"date": "2025-03-05",
								"time": "20:00:00",
								"location": {
									"code": "TLV"
								}
							},
							"flightDesignator": "PL0002"
						}
					]
				}
			],
			"pendingPurchase": {
				"purchaseId": "391571d5-60b3-4fc9-9ea7-9a3262a3481b",
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
					"vat": {
						"amount": "0.00",
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
						"price": {
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
							"vat": {
								"amount": "0.00",
								"currency": "USD"
							},
							"base": {
								"amount": "400.00",
								"currency": "USD"
							}
						},
						"associatedBookingReference": {
							"bookingReference": "59561402"
						}
					}
				]
			}
		}
	}
}
````
</details>
