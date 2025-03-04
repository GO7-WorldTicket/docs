# Create Initial Order

## Create Order from some Offer available in the system

#### Request Parameters

| Parameter                             | Type | Data Type | Description            | Example                                      |
|---------------------------------------|------|-----------|------------------------|----------------------------------------------|
| createOrder.offerId                   | M    | String    | Start departure date   | 395feee0-ce6c-491b-9644-b2c120d868d3         |

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

<pre>
mutation createOrder($offerId: String!) {
	order: createOrder(createOrderRequest: { offerId: $offerId }) {
		orderId
		orderStatus
		tenant
		items {
			guarantee {
				externalOrderId
				recordLocator
				guarantee {
					guaranteeId
					status
					paymentTimeLimit
					ticketingTimeLimit
				}
			}
		}
		pendingPurchase {
			purchaseId
			timeToLive
		}
	}
}
</pre>
</details>

<details>
  <summary><b>Response body</b></summary>
  
<pre>
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
</pre>
</details>
