## Payment and Ticketing

The purpose is to make a payment of existing booking in SMS.

Supported payment types:

| Payment Type         | OTA Code |
| -------------------- | -------- |
| External payment     | 32       |
| Credit card          | 5        |
| Cash                 | 1        |
| Debit credit account | 4        |
| Invoice              | 40       |

### Make payment for issuing a ticket (AirDemandTicketRQ)

### Request Parameters in the header (all required)

| Parameter  | Type    | Description        | Example                  |
| ---------- | ------- | ------------------ | ------------------------ |
| x-api-key  | Header  | Access Token       | [Access token](#api-key) |
| local-name | Header  | Custom HTTP header | OTA_AirDemandTicketRQ    |
| agentId    | Payload | Custom HTTP header | ota                      |
| agencyId   | Payload | Custom HTTP header | ota                      |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api-key}' \
    -H 'local-name: {local_name}' \
```

<details open>
  <summary>Request Payload</summary>
  <pre>
    {
      "version": "2.001",
      "pos": {
        "source": [
          {
            "bookingChannel": {
              "type": "OTA"
            },
            "requestorID": {
              "type": "5",
              "id": "<ins>agentId</ins>",
              "name": "<ins>agencyId</ins>"
              "location": "CPH"
            },
            "isocountry": "US",
            "isoCurrency": "SAR"
          }
        ]
      },
      "demandTicketDetail": {
        "messageFunction": [
          {
            "function": "ET"
          }
        ],
        "bookingReferenceID": {
          "id": "N6G2NW",
          "type": "14",
          "companyName": {
            "code": "test-rs3",
            "companyShortName": "test-rs3"
          }
        },
        "paymentInfo": [
          {
            "paymentType": "4",
            "creditCardInfo": [
              {
                "cardHolderName": "TEST TESTER"
              }
            ]
          }
        ]
      }
    }
  </pre>
</details>

<details open>
  <summary>Response Payload</summary>
  <pre>
    {
      "success": {},
      "bookingReferenceID": {
        "companyName": {
          "companyShortName": "test-rs3",
          "code": "test-rs3"
        },
        "type": "14",
        "id": "N6G2NW"
      },
      "ticketItemInfo": [
        {
          "passengerName": {
            "namePrefix": [
              null
            ],
            "givenName": [
              ""
            ],
            "middleName": [],
            "surname": "",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT"
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330007692",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 19.55,
          "paymentType": "4",
          "netAmount": 2
        },
        {
          "passengerName": {
            "namePrefix": [
              null
            ],
            "givenName": [
              ""
            ],
            "middleName": [],
            "surname": "",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT"
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330007693",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 19.55,
          "paymentType": "4",
          "netAmount": 2
        },
        {
          "passengerName": {
            "namePrefix": [
              null
            ],
            "givenName": [
              ""
            ],
            "middleName": [],
            "surname": "",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT"
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330007694",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 19.55,
          "paymentType": "4",
          "netAmount": 2
        },
        {
          "passengerName": {
            "namePrefix": [
              null
            ],
            "givenName": [
              ""
            ],
            "middleName": [],
            "surname": "",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT"
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330007695",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 19.55,
          "paymentType": "4",
          "netAmount": 2
        },
        {
          "passengerName": {
            "namePrefix": [
              null
            ],
            "givenName": [
              ""
            ],
            "middleName": [],
            "surname": "",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT"
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330007696",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 19.55,
          "paymentType": "4",
          "netAmount": 2
        }
      ],
      "timeStamp": "2024-03-15T10:13:19.653Z",
      "version": 2.001,
      "retransmissionIndicator": false
    }
  </pre>
</details>