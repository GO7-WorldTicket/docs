# Cancellation Email Endpoint

This document explains how to use the `/notifications/cancellation-email` endpoint to send and resend cancellation emails.

# Base URL

|Production                                            | Test                                     |
|----------------------------------------------------- | ---------------------------------------- |
|https://api.sar.worldticket.cloud/sms-gateway-service | https://test-api.worldticket.net/sms-gateway |

## Endpoint Overview

**Endpoint:** `/notifications/cancellation-email`  
**Method:** `POST`  
**Content-Type:** `application/json`

## Description:

This endpoint is designed for sending and resending cancellation emails. It is used for Online Travel Agency (OTA) support representatives to send notifications of a cancelled booking, or segments within a booking, to specific recipients.

### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token](#api-key) |

This endpoint does not accept any parameters in the URL. All necessary data should be included in the request body.

### Request Body

The request body must be in JSON format. The following fields must be included in the body:

- `emails` (Array of strings - mandatory): List of email addresses to send the email to.
- `ccEmails` (Array of strings - optional): List of email addresses to send a carbon copy (CC) to.
- `bccEmails` (Array of strings - optional): List of email addresses to send a blind carbon copy (BCC) to.
- `recordLocator` (String - mandatory): The record locator or booking reference.

The request body may include the following field:

- `segments` (Array of segment information - mandatory): List of specific cancelled segment within the booking to include in the email. Each segment must include the following information:
  - `flightDesignator` (String - mandatory): The code of the flight
  - `departure` (String - mandatory): Three letters code of the departure airport/station
  - `arrival` (String - mandatory): Three letters code of the arrival airport/station
  - `departureDate` (String - mandatory): Departure date of the segment in YYYY-MM-DD format

In the case where no `segment` is provided, an email will be sent with information of all cancelled segments within the booking.

### Example Request Body

<details open>
  <summary>Request Payload</summary>
  <pre>
{
    "emails" : ["to@go7.io"],
    "ccEmails": ["cc@go7.io"],
    "bccEmails": ["bcc@go7.io"],
    "recordLocator" : "ABC123",
    "segments" : [{
        "flightDesignator": "DEF4321",
        "departure": "ABC",
        "arrival": "DEF",
        "departureDate": "2025-07-30"
    }]
}
</pre>
</details>

### Response

If the request is successful, the endpoint will return a status code of `204 No Content`.

### Example Response

```
HTTP/1.1 204 No Content
```

