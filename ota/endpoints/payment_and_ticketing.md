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

Note that for bookings with named passengers, the response will also contain download links for tickets in the booking  (see [Download Tickets](download_tickets.md) for more information).

<details>
  <summary>Response Payload (named passengers)</summary>
  <pre>
    {
      "success": {},
      "bookingReferenceID": {
        "companyName": {
          "companyShortName": "test-skywork-dev",
          "code": "test-skywork-dev"
        },
        "type": "14",
        "id": "QN6HQV"
      },
      "ticketItemInfo": [
        {
          "passengerName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "JENNIFER LO"
            ],
            "middleName": [],
            "surname": "STEWART",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058951",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 460.00,
          "paymentType": "4",
          "netAmount": 400.00
        },
        {
          "passengerName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "MARY"
            ],
            "middleName": [],
            "surname": "THOMSON",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "ADT",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=MARY&lastName=THOMSON&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=MARY&lastName=THOMSON&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058952",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 460.00,
          "paymentType": "4",
          "netAmount": 400.00
        },
        {
          "passengerName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "ELIZABETH LILY"
            ],
            "middleName": [],
            "surname": "ROBERTSON",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "CHD",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=ELIZABETH&lastName=ROBERTSON&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=ELIZABETH&lastName=ROBERTSON&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058953",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 230.00,
          "paymentType": "4",
          "netAmount": 200.00
        },
        {
          "passengerName": {
            "namePrefix": [
              "MR"
            ],
            "givenName": [
              "PATRICIA"
            ],
            "middleName": [],
            "surname": "ANDERSON",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "CHD",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=PATRICIA&lastName=ANDERSON&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=PATRICIA&lastName=ANDERSON&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058954",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 230.00,
          "paymentType": "4",
          "netAmount": 200.00
        },
        {
          "passengerName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "LINDA"
            ],
            "middleName": [],
            "surname": "SCOTT",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "INF",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=LINDA&lastName=SCOTT&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=LINDA&lastName=SCOTT&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058955",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 46.00,
          "paymentType": "4",
          "netAmount": 40.00
        },
        {
          "passengerName": {
            "namePrefix": [
              "MISS"
            ],
            "givenName": [
              "BARBARA BROWN"
            ],
            "middleName": [],
            "surname": "TAYLOR",
            "nameSuffix": [],
            "nameTitle": [],
            "passengerTypeCode": "INF",
            "tpaextensions": {
              "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=BARBARA&lastName=TAYLOR&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=BARBARA&lastName=TAYLOR&departure=DMX&arrival=MKX"
            }
          },
          "conjunctiveTicket": [],
          "ticketNumber": "3333330058956",
          "type": "E_TICKET",
          "itemNumber": "",
          "totalAmount": 46.00,
          "paymentType": "4",
          "netAmount": 40.00
        }
      ],
      "timeStamp": "2024-07-03T08:43:25.130Z",
      "version": 2.001,
      "retransmissionIndicator": false
    }
  </pre>
</details>