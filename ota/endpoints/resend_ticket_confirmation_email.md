# Ticket Confirmation Resource Endpoint

This document explains how to use the `/notifications/email` endpoint to send and resend ticket confirmation emails.

# Base URL

|                                  | Production                                            | Test                                     |
|----------------------------------| ----------------------------------------------------- | ---------------------------------------- |
| Resend Ticket Confirmation Email | https://api.sar.worldticket.cloud/sms-gateway-service | https://test.worldticket.net/sms-gateway |

## Endpoint Overview

**Endpoint:** `/notifications/email`  
**Method:** `POST`  
**Content-Type:** `application/json`

## Description:

This endpoint is designed for sending and resending train ticket confirmation emails. It is particularly useful for Online Travel Agency (OTA) support representatives who need to resend the train ticket email in case the passenger does not receive it. This functionality applies only to confirmed bookings with QR codes issued and booking status active.

### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token](#api-key) |

This endpoint does not accept any parameters in the URL. All necessary data should be included in the request body.

### Request Body

The request body must be in JSON format and include the following fields:

- `emails` (Array of strings): List of email addresses to send the confirmation to.
- `ccEmails` (Array of strings): List of email addresses to send a carbon copy (CC) of the confirmation.
- `bccEmails` (Array of strings): List of email addresses to send a blind carbon copy (BCC) of the confirmation.
- `recordLocator` (String): The record locator or booking reference.
- `passengers` (Array of Objects): List of passenger details, where each object contains:
    - `firstName` (String): The first name of the passenger.
    - `middleName` (String): The middle name of the passenger.
    - `lastName` (String): The last name of the passenger.

### Example Request Body

<details open>
  <summary>Request Payload</summary>
  <pre>
{
  "emails": [
    "test@go7.io"
  ],
  "ccEmails": [],
  "bccEmails": [],
  "recordLocator": "7U3ESF",
  "passengers": [
    {
      "firstName": "PAXTWO",
      "middleName": "JAMES",
      "lastName": "PARKER"
    },
    {
      "firstName": "PAXTWO",
      "middleName": "ALEXANDER",
      "lastName": "PARKER"
    },
    {
      "firstName": "PAXTHREE",
      "lastName": "PARKER"
    }
  ]
}
  </pre>
</details>

### Response

If the request is successful, the endpoint will return a status code of `204 No Content`.

### Example Response

```
HTTP/1.1 204 No Content
```

