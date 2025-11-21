---
layout: default
title: Payment and Ticketing
---

# Payment and Ticketing

The purpose is to make a payment for existing booking and issue tickets.

## Table of Contents

- [Payment and Ticketing](#payment-and-ticketing)
  - [Table of Contents](#table-of-contents)
  - [Base URLs](#base-urls)
  - [Endpoints](#endpoints)
  - [Supported Payment Types](#supported-payment-types)
  - [Make Payment for Issuing a Ticket](#make-payment-for-issuing-a-ticket)
    - [Basic Request Format](#basic-request-format)
      - [With JWT Authentication](#with-jwt-authentication)
      - [With API Key Authentication](#with-api-key-authentication)
    - [HTTP Headers](#http-headers)
    - [JSON Request](#json-request)
    - [JSON Response](#json-response)
  - [Payment with Cash](#payment-with-cash)
    - [JSON Request Example](#json-request-example)
    - [JSON Response Example](#json-response-example)
  - [Currency Conversion](#currency-conversion)
    - [Get Conversion Rate](#get-conversion-rate)
    - [Response](#response-1)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | <https://api.worldticket.net> |
| Test        | <https://test-api.worldticket.net> |

## Endpoints
- Method: `POST`
- Path: `/ota/v2015b/OTA_AirDemandTicketRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_AirDemandTicketRQ` (choose base URL per environment above)

## Supported Payment Types

| Payment Type | OTA Code |
|--------------|----------|
| Credit card | 5 |
| Cash | 1 |
| Debit credit account | 4 |

## Make Payment for Issuing a Ticket

### Basic Request Format

#### With JWT Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirDemandTicketRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @AirDemandTicketRQ.json
```

#### With API Key Authentication
```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_AirDemandTicketRQ' \
  -H 'X-API-Key: {api_key}' \
  -H 'Content-Type: application/json' \
  -d @AirDemandTicketRQ.json
```

### HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
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
          "id": "{agent_id}",
          "name": "{agency_id}"
        },
        "isocountry": "US",
        "isoCurrency": "USD"
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
      "id": "{record_locator}",
      "type": "14",
      "companyName": {
        "code": "{airline_code}",
        "companyShortName": "{tenant_name}"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "5",
        "creditCardInfo": [
          {
            "cardHolderName": "{cardholder_name}"
          }
        ],
        "currencyCode": "USD",
        "amount": 100.00
      }
    ]
  }
}
```

</div>

</details>

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
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
          "id": "AGENT123",
          "name": "AGENCY1"
        },
        "isocountry": "US",
        "isoCurrency": "USD"
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
      "id": "ABC123",
      "type": "14",
      "companyName": {
        "code": "DX",
        "companyShortName": "DX"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "5",
        "creditCardInfo": [
          {
            "cardHolderName": "JOHN DOE"
          }
        ],
        "currencyCode": "USD",
        "amount": 300.00
      }
    ]
  }
}
```

</div>

</details>

### JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "success": {},
  "bookingReferenceID": {
    "companyName": {
      "companyShortName": "DX",
      "code": "DX"
    },
    "type": "14",
    "id": "ABC123"
  },
  "ticketItemInfo": [
    {
      "passengerName": {
        "namePrefix": ["MR"],
        "givenName": ["JOHN"],
        "middleName": [],
        "surname": "DOE",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "3333330012345",
      "type": "E_TICKET",
      "itemNumber": "1",
      "totalAmount": 300.00,
      "paymentType": "5",
      "netAmount": 270.00
    }
  ],
  "timeStamp": "2024-10-30T10:00:00.000Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>

</details>

## Payment with Cash

### JSON Request
<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "bookingChannel": {
          "type": "OTA"
        },
        "isocountry": "US",
        "isoCurrency": "USD"
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
      "id": "7YF3OW",
      "type": "14",
      "companyName": {
        "code": "DX",
        "companyShortName": "DX"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "1",
        "currencyCode": "USD",
        "amount": 39.73
      }
    ]
  }
}
```

</div>

</details>

### JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "success": {},
  "bookingReferenceID": {
    "companyName": {
      "companyShortName": "DX",
      "code": "DX"
    },
    "type": "14",
    "id": "7YF3OW"
  },
  "ticketItemInfo": [
    {
      "passengerName": {
        "namePrefix": [
          "MR"
        ],
        "givenName": [
          "QA"
        ],
        "middleName": [],
        "surname": "TESTER",
        "nameSuffix": [],
        "nameTitle": [],
        "passengerTypeCode": "ADT"
      },
      "conjunctiveTicket": [],
      "ticketNumber": "2772770020247",
      "type": "E_TICKET",
      "itemNumber": "",
      "totalAmount": 40.73,
      "paymentType": "1",
      "netAmount": 31.76
    }
  ],
  "timeStamp": "2025-11-19T10:07:32.521Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>

</details>

## Currency Conversion

Payment currency can be different from booking currency.

### Get Conversion Rate

```bash
curl -X GET \
  'https://test-api.worldticket.net/sms-gateway/currencies/convert?currency_from={from_currency}&currency_to={to_currency}&amount={amount}' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json'
```

### Response

The endpoint returns the converted amount as a BigDecimal number:

```text
81.07
```

