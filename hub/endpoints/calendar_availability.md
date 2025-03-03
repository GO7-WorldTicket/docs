# Calendar Availability

## Find low fare calendar availability

#### Request Parameters

| Parameter                             | Type | Data Type | Description            | Example                                      |
|---------------------------------------|------|-----------|------------------------|----------------------------------------------|
| calendarItemsQuery.departureDateFrom  | M    | String    | Start departure date   | 2025-03-01                                   |
| calendarItemsQuery.departureDateTo    | M    | String    | End departure date     | 2025-03-31                                   |
| calendarItemsQuery.origin             | M    | String    | Departure airport code | BER                                          |
| calendarItemsQuery.destination        | M    | String    | Arrival airport code   | BCN                                          |
| calendarItemsQuery.journeyType        | M    | Enum      | Type of journey        | [ONE_WAY, ROUND_TRIP, CIRCLE_TRIP, OPEN_JAW] |
| calendarItemsQuery.originContext      | M    | Enum      | Departure context      | [AIRPORT, CITY, COUNTRY]                     |
| calendarItemsQuery.destinationContext | M    | Enum      | Arrival context        | [AIRPORT, CITY, COUNTRY]                     |
| calendarItemsQuery.passengerType      | M    | Enum      | Type of passenger      | [ADULT, CHILD, INFANT, UNACCOMPINED_MINOR]   |

#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Lists available dates per route. Usually used in the calendar picker. 

<details open>
  <summary><b>Request body</b></summary>
  <pre>
        query {
            calendarItems(
                calendarItemsQuery: {departureDateFrom: "2025-03-01", departureDateTo: "2025-03-31", origin: "BER", destination: "BCN", carrierCodes: "", currency: "", destinationContext: AIRPORT, journeyType: ONE_WAY, originContext: AIRPORT, passengerType: ADULT, priceFrom: "", priceTo: ""}
            ) {
                carrierCode
                currency
                date
                price
            }
        }

Mandatory fields:
<table><tr><th>Field name</th>
        <th>Field type</th>
        <th>Example</th>
      </tr>
      <tr>
        <td>departureDateFrom</td>
        <td>LocalDate</td>
        <td>2025-03-01</td>
      </tr>
      <tr>
        <td>departureDateTo</td>
        <td>LocalDate</td>
        <td>2025-03-31</td>
      </tr>
      <tr>
        <td>origin</td>
        <td>String</td>
        <td>BER</td>
      </tr>
      <tr>
        <td>destination</td>
        <td>String</td>
        <td>BCN</td>
      </tr>
      <tr>
        <td>journeyType</td>
        <td>Enum</td>
        <td>[ONE_WAY, ROUND_TRIP, CIRCLE_TRIP, OPEN_JAW]</td>
      </tr>
      <tr>
        <td>originContext</td>
        <td>Enum</td>
        <td>[AIRPORT, CITY, COUNTRY]</td>
      </tr>
      <tr>
        <td>destinationContext</td>
        <td>Enum</td>
        <td>[AIRPORT, CITY, COUNTRY]</td>
      </tr>
      <tr>
        <td>passengerType</td>
        <td>Enum</td>
        <td>[ADULT, CHILD, INFANT, UNACCOMPINED_MINOR]</td>
      </tr>
</table>
  </pre>
</details>

<details open>
  <summary><b>Response body</b></summary>
  <pre>
    {
    "data": {
        "calendarItems": [
            {
                "date": "2025-03-01",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-02",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-03",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-04",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-05",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-06",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-07",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-08",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-09",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-10",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-11",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-12",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-13",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-14",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-15",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-16",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-17",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-18",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-19",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-20",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-21",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-22",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-23",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-24",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-25",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-26",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-27",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-28",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-29",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-30",
                "price": 480.00,
                "currency": "USD",
                "carrierCode": "PLR"
            },
            {
                "date": "2025-03-31",
                "price": 430.00,
                "currency": "USD",
                "carrierCode": "PLR"
            }
        ]
    }
}
  </pre>
</details>
