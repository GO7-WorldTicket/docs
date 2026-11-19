# Cancellation Email Endpoint

This document explains how to use the `/notifications/cancellation-email` endpoint to send and resend cancellation emails.

# Base URL

|Production                                            | Test                                     |
|----------------------------------------------------- | ---------------------------------------- |
|{{ sar_profile.production_origin }}/sms-gateway-service | {{ sar_profile.test_api_origin }}/sms-gateway-service |

## Endpoint Overview

**Endpoint:** `/notifications/cancellation-email`<br>
**Method:** `POST`<br>
**Content-Type:** `application/json`

## Description:

This endpoint is designed for sending and resending cancellation emails. It is used for Online Travel Agency (OTA) support representatives to send notifications of a cancelled booking, or segments within a booking, to specific recipients.

### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#api-key) |

This endpoint does not accept any parameters in the URL. All necessary data should be included in the request body.

### Request Body

Send a JSON body with `recordLocator` and `emails`. Use `ccEmails` and `bccEmails` to add optional recipients.

- Omit `segments` or pass an empty array to include all cancelled segments on the booking that have yet to depart. This also applies to a partially cancelled booking.
- To include only specific cancelled segments, pass a non-empty `segments` array. Each entry must match the booking's `flightDesignator`, `departure` station code, `arrival` station code, and `departureDate` in `YYYY-MM-DD` format. The filter selects segments that are already cancelled.

### Example Request Body

<details open>
  <summary>Resend for all cancelled segments</summary>
  <pre>
{
    "emails": ["{{ sar_profile.cancellation_to_email }}"],
    "recordLocator": "ABC123"
}
</pre>
</details>

<details>
  <summary>Resend for specific cancelled segments</summary>
  <pre>
{
    "emails": ["{{ sar_profile.cancellation_to_email }}"],
    "ccEmails": ["{{ sar_profile.cancellation_cc_email }}"],
    "bccEmails": ["{{ sar_profile.cancellation_bcc_email }}"],
    "recordLocator": "ABC123",
    "segments": [{
        "flightDesignator": "DEF4321",
        "departure": "ABC",
        "arrival": "DEF",
        "departureDate": "2026-12-15"
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
