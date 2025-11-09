---
layout: default
title: Booking Cancellation
---

# Cancel Booking

The purpose is to cancel entire bookings or specific segments/passengers.

## Table of Contents

- [Cancel Booking](#cancel-booking)
  - [Table of Contents](#table-of-contents)
  - [Base URLs](#base-urls)
  - [Endpoints](#endpoints)
  - [Basic Request Format](#basic-request-format)
    - [With JWT Authentication](#with-jwt-authentication)
    - [With API Key Authentication](#with-api-key-authentication)
  - [HTTP Headers](#http-headers)
  - [Full Booking Cancellation](#full-booking-cancellation)
    - [JSON Request](#json-request)
    - [JSON Response](#json-response)
  - [Cancel Specific Segments](#cancel-specific-segments)
    - [JSON Request](#json-request-1)
    - [JSON Response](#json-response-1)
  - [Cancel Specific Passengers](#cancel-specific-passengers)
    - [JSON Request](#json-request-2)
    - [JSON Response](#json-response-2)
  - [Cancellation Policies](#cancellation-policies)
    - [Cancel Duration Policy](#cancel-duration-policy)
    - [Cancel Refund Policy](#cancel-refund-policy)
  - [Automatic Refund Process](#automatic-refund-process)
    - [Refund Processing Timeline](#refund-processing-timeline)
  - [Resend Cancellation Email](#resend-cancellation-email)
    - [JSON Request](#json-request-3)
    - [JSON Response](#json-response-3)
  - [Error Responses](#error-responses)
    - [Booking Not Found](#booking-not-found)
    - [Cancellation Not Allowed](#cancellation-not-allowed)
    - [Already Cancelled](#already-cancelled)
    - [Too Late to Cancel](#too-late-to-cancel)

## Base URLs

| Environment | URL |
|-------------|-----|
| Production  | https://api.worldticket.net |
| Test        | https://test-api.worldticket.net |

## Endpoints

- Method: `POST`
- Path: `/ota/v2015b/OTA_CancelRQ`
- Full URL: `{base_url}/ota/v2015b/OTA_CancelRQ` (choose base URL per environment above)

## Basic Request Format

### With JWT Authentication

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_CancelRQ' \
  -H 'Authorization: Bearer {access_token}' \
  -H 'Content-Type: application/json' \
  -d @OTA_CancelRQ.json
```

### With API Key Authentication

```bash
curl -X POST \
  'https://test-api.worldticket.net/ota/v2015b/OTA_CancelRQ' \
  -H 'X-API-Key: {api_key}' \
  -H 'Content-Type: application/json' \
  -d @OTA_CancelRQ.json
```

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

## Full Booking Cancellation

Cancel the entire booking and all associated passengers.

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "echoToken": "{echo_token}",
  "timeStamp": "{timestamp}",
  "target": "Production",
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "erSPUserID": "{ersp_user_id}",
        "agentSine": "{agent_sine}",
        "pseudoCityCode": "{pseudo_city_code}",
        "isocountry": "{iso_country}",
        "isoCurrency": "{iso_currency}",
        "airlineVendorID": "{airline_vendor_id}",
        "requestorID": {
          "type": "5",
          "id": "{requestor_id}"
        },
        "bookingChannel": {
          "type": "COM"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "idContext": "{airline_code}"
  },
  "verification": {
    "personName": {
      "surname": "{lead_passenger_last_name}"
    }
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
  "echoToken": "36732",
  "timeStamp": "2003-11-14T10:30:00",
  "target": "Production",
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "erSPUserID": "1#Preved",
        "agentSine": "2BB",
        "pseudoCityCode": "ATL",
        "isocountry": "US",
        "isoCurrency": "EUR",
        "airlineVendorID": "1P",
        "requestorID": {
          "type": "5",
          "id": "35896241"
        },
        "bookingChannel": {
          "type": "COM"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "11XS4L",
    "idContext": "EK"
  },
  "verification": {
    "personName": {
      "surname": "WorldTicket"
    }
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
  "version": "2.001",
  "success": {},
  "uniqueID": {
    "type": "14",
    "id": "11XS4L"
  }
}
```

</div>
</details>

## Cancel Specific Segments

For multi-segment bookings, cancel individual flights.

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
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "companyName": {
      "code": "{airline_code}"
    }
  },
  "cancellationOverrides": {
    "cancellationOverride": {
      "type": "SegmentCancellation",
      "flightSegment": {
        "flightNumber": "{flight_number}",
        "departureDateTime": "{departure_datetime}",
        "departureAirport": {
          "locationCode": "{origin_code}"
        },
        "arrivalAirport": {
          "locationCode": "{destination_code}"
        }
      }
    }
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
        "requestorID": {
          "type": "5",
          "id": "AGENT123",
          "name": "AGENCY1"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "ABC123",
    "companyName": {
      "code": "DX"
    }
  },
  "cancellationOverrides": {
    "cancellationOverride": {
      "type": "SegmentCancellation",
      "flightSegment": {
        "flightNumber": "FL456",
        "departureDateTime": "2024-12-26T15:00:00",
        "departureAirport": {
          "locationCode": "XMK"
        },
        "arrivalAirport": {
          "locationCode": "JED"
        }
      }
    }
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
  "version": "2.001",
  "success": {},
  "uniqueID": {
    "type": "14",
    "id": "ABC123",
    "companyName": {
      "code": "DX"
    }
  },
  "cancellationStatus": {
    "status": "Confirmed",
    "dateTime": "2024-12-25T11:15:00Z",
    "text": "Segment cancellation completed"
  },
  "refundInfo": {
    "refundAmount": {
      "amount": "150.00",
      "currencyCode": "USD",
      "description": "Refund for cancelled segment"
    },
    "refundMethod": "Original payment method",
    "processingTime": "5-10 business days"
  },
  "cancellationConfirmation": {
    "confirmationNumber": "SEGSCANC20241225001",
    "emailSent": true
  }
}
```

</div>
</details>

## Cancel Specific Passengers

Remove individual passengers from group bookings.

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
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "companyName": {
      "code": "{airline_code}"
    }
  },
  "cancellationOverrides": {
    "cancellationOverride": {
      "type": "PassengerCancellation",
      "passengerInfo": {
        "personName": {
          "givenName": "{passenger_first_name}",
          "surname": "{passenger_last_name}"
        },
        "travelerRefNumber": {
          "rph": "{passenger_reference}"
        }
      }
    }
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
        "requestorID": {
          "type": "5",
          "id": "AGENT123",
          "name": "AGENCY1"
        }
      }
    ]
  },
  "uniqueID": {
    "type": "14",
    "id": "ABC123",
    "companyName": {
      "code": "DX"
    }
  },
  "cancellationOverrides": {
    "cancellationOverride": {
      "type": "PassengerCancellation",
      "passengerInfo": {
        "personName": {
          "givenName": "Jane",
          "surname": "Smith"
        },
        "travelerRefNumber": {
          "rph": "2"
        }
      }
    }
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
  "version": "2.001",
  "success": {},
  "uniqueID": {
    "type": "14",
    "id": "ABC123",
    "companyName": {
      "code": "DX"
    }
  },
  "cancellationStatus": {
    "status": "Confirmed",
    "dateTime": "2024-12-25T11:45:00Z",
    "text": "Passenger cancellation completed"
  },
  "refundInfo": {
    "refundAmount": {
      "amount": "95.00",
      "currencyCode": "USD",
      "description": "Refund for cancelled passenger"
    },
    "refundMethod": "Original payment method",
    "processingTime": "5-10 business days"
  },
  "cancellationConfirmation": {
    "confirmationNumber": "PASSENGERCANC20241225001",
    "emailSent": true
  }
}
```

</div>
</details>

## Cancellation Policies

### Cancel Duration Policy

Cancellation policies vary by fare type and timing:

- **Free Cancellation Period**: Usually 24 hours from booking
- **Standard Cancellation**: Fees apply based on fare rules
- **Non-refundable Fares**: May only allow cancellation with penalties
- **Last Minute Cancellation**: Higher fees or restrictions

### Cancel Refund Policy

Refund amounts depend on several factors:

1. **Fare Conditions**: Each fare has specific refund rules
2. **Timing**: When cancellation occurs relative to departure
3. **Reason**: Voluntary vs involuntary cancellations
4. **Taxes and Fees**: Usually refundable minus processing fees

## Automatic Refund Process

For eligible cancellations, refunds can be processed automatically:

### Refund Processing Timeline

1. **Immediate**: Service fees and taxes
2. **3-5 Business Days**: Credit card refunds
3. **5-10 Business Days**: Bank transfer refunds
4. **Manual Processing**: Complex refund cases

## Resend Cancellation Email

If the cancellation email needs to be resent:

### JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "recordLocator": "{record_locator}",
  "emailAddress": "{recipient_email}",
  "cancellationConfirmation": "{cancellation_confirmation}"
}
```

</div>
</details>

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "recordLocator": "ABC123",
  "emailAddress": "customer@example.com",
  "cancellationConfirmation": "CANC20241225001"
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
  "success": true,
  "message": "Cancellation email resent successfully",
  "emailSentTo": "customer@example.com",
  "sentDateTime": "2024-12-25T12:00:00Z"
}
```

</div>
</details>

## Error Responses

### Booking Not Found

```json
{
  "errors": [
    {
      "code": "BOOKING_NOT_FOUND",
      "message": "No booking found with the provided record locator"
    }
  ]
}
```

### Cancellation Not Allowed

```json
{
  "errors": [
    {
      "code": "CANCELLATION_NOT_ALLOWED",
      "message": "This booking cannot be cancelled due to fare restrictions",
      "fareType": "Non-refundable"
    }
  ]
}
```

### Already Cancelled

```json
{
  "errors": [
    {
      "code": "ALREADY_CANCELLED",
      "message": "This booking has already been cancelled",
      "cancellationDate": "2024-12-20T10:00:00Z"
    }
  ]
}
```

### Too Late to Cancel

```json
{
  "errors": [
    {
      "code": "CANCELLATION_CUTOFF_PASSED",
      "message": "Cancellation is not allowed within 24 hours of departure"
    }
  ]
}
```
