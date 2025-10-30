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
  - [Payment with Debit-Credit Account](#payment-with-debit-credit-account)
  - [Payment with Redirect](#payment-with-redirect)
  - [Issue EMDs for Ancillaries](#issue-emds-for-ancillaries)
  - [Currency Conversion](#currency-conversion)
  - [Error Responses](#error-responses)
    - [Payment Declined](#payment-declined)
    - [Insufficient Funds](#insufficient-funds)
    - [Payment Timeout](#payment-timeout)

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
| External payment | 32 |
| Credit card | 5 |
| Cash | 1 |
| Debit credit account | 4 |
| Invoice | 40 |

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
        "companyShortName": "{airline_code}"
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

## Payment with Debit-Credit Account

### Get Available Debit-Credit Accounts

```bash
curl -X GET \
  'https://test-api.worldticket.net/payment-service/debit-credit/accounts' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json'
```

### Response

```json
{
  "accounts": [
    {
      "accountId": "{account_id}",
      "accountName": "{account_name}",
      "balance": {
        "amount": "{balance_amount}",
        "currency": "{currency_code}"
      },
      "status": "active"
    }
  ]
}
```

### Payment with Debit-Credit Account

<details>
<summary><strong>✅ Request Example</strong></summary>
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
        "companyShortName": "{airline_code}"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "4",
        "creditCardInfo": [
          {
            "cardHolderName": "{account_name}"
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

## Payment with Redirect

For asynchronous payment processing where customers are redirected to payment provider websites.

### Payment Flow

1. **Payment Request**: Initiate payment and receive redirect URL
2. **Customer Redirect**: Customer completes payment on provider site
3. **Return to Merchant**: Customer returns with payment confirmation
4. **Ticket Demand**: Request tickets after successful payment

### Get Payment URL

#### Request

```bash
curl -X POST \
  'https://api.worldticket.net/payment-service/payments/{tenant}' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @payment-request.json
```

#### Request Body

```json
{
  "orderId": "{record_locator}",
  "paymentInfo": {
    "method": "credit_card",
    "provider": "stripe"
  },
  "buyerInfo": {
    "firstName": "{first_name}",
    "lastName": "{last_name}",
    "email": "{email}",
    "phone": "{phone}"
  },
  "amount": "{total_amount}",
  "currency": "{currency_code}"
}
```

#### Response

```json
{
  "paymentId": "{payment_id}",
  "asynchronousRedirectUrl": "{redirect_url}",
  "expiryTime": "{expiry_datetime}",
  "status": "pending"
}
```

### Request Tickets (After Payment)

When payment has already been completed via redirect, you can request tickets without payment information:

<details>
<summary><strong>✅ Request Example</strong></summary>
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
        "companyShortName": "{airline_code}"
      }
    }
  }
}
```

**Note:** No `paymentInfo` is required in the request since payment was already processed.

</div>

</details>

## Issue EMDs for Ancillaries

Electronic Miscellaneous Documents (EMDs) for additional services.

### EMD Request

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
        "function": "EMD"
      }
    ],
    "bookingReferenceID": {
      "id": "{record_locator}",
      "type": "14",
      "companyName": {
        "code": "{airline_code}",
        "companyShortName": "{airline_code}"
      }
    },
    "paymentInfo": [
      {
        "paymentType": "32",
        "text": "{external_transaction_id}",
        "currencyCode": "USD",
        "amount": 50.00
      }
    ]
  }
}
```

</div>

</details>

### EMD Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "success": {},
  "bookingReferenceID": {
    "companyName": {
      "companyShortName": "{airline_code}",
      "code": "{airline_code}"
    },
    "type": "14",
    "id": "{record_locator}"
  },
  "emdItemInfo": [
    {
      "emdNumber": "{emd_number}",
      "netAmount": 45.00,
      "totalAmount": 50.00,
      "serviceInfo": {
        "serviceType": "Baggage",
        "serviceCode": "BAGS",
        "description": "Extra Baggage - 20kg"
      }
    }
  ],
  "timeStamp": "2024-10-30T10:00:00.000Z",
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
  'https://test-api.worldticket.net/payment-service/currencies/convert?currency_from={from_currency}&currency_to={to_currency}&amount={amount}' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json'
```

### Response

```json
{
  "fromCurrency": "{from_currency}",
  "toCurrency": "{to_currency}",
  "originalAmount": "{original_amount}",
  "convertedAmount": "{converted_amount}",
  "exchangeRate": "{exchange_rate}",
  "conversionDate": "{conversion_date}"
}
```

## Error Responses

Common error responses for payment and ticketing requests:

### Payment Declined

<details>
<summary><strong>❌ Error Example</strong></summary>
<div markdown="1">

```json
{
  "errors": [
    {
      "code": "PAYMENT_DECLINED",
      "shortText": "Payment declined",
      "message": "The payment was declined by the card issuer. Please try a different card."
    }
  ]
}
```

</div>

</details>

### Insufficient Funds

<details>
<summary><strong>❌ Error Example</strong></summary>
<div markdown="1">

```json
{
  "errors": [
    {
      "code": "INSUFFICIENT_FUNDS",
      "message": "Insufficient funds in debit-credit account",
      "accountId": "{account_id}"
    }
  ]
}
```

</div>

</details>

### Payment Timeout

<details>
<summary><strong>❌ Error Example</strong></summary>
<div markdown="1">

```json
{
  "errors": [
    {
      "code": "PAYMENT_TIMEOUT",
      "message": "Payment processing timed out. Please try again.",
      "paymentId": "{payment_id}"
    }
  ]
}
```

</div>

</details>
