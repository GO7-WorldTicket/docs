## Full Booking Cancellation

Send `OTA_CancelRQ` to cancel the full booking. To cancel a passenger or segment, use [Modify booking]({{ sar_profile.documentation_root }}/endpoints/modify-booking.html) with `OTA_AirBookModifyRQ`.

#### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#api-key) |
| local-name   | Header  | Custom HTTP header | OTA_CancelRQ             |
| agentId      | Payload |                    | ota                      |
| agencyId     | Payload |                    | ota                      |

Send `POST /ota/v2015b/OTA` to the [OTA API origin for your environment]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#ota-for-reservation-workflow), with `Content-Type: application/json`, `x-api-key`, and `local-name: OTA_CancelRQ`. Use a top-level `uniqueID` array with the WorldTicket booking reference.

## JSON Request

<details>
<summary><strong>📋 JSON Request Template</strong></summary>
<div markdown="1">

```json
{
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "isoCurrency": "{currency_code}",
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        },
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "uniqueID": [
    {
      "id": "{record_locator}",
      "type": "14"
    }
  ]
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
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "agentId",
          "name": "agencyId"
        },
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "uniqueID": [
    {
      "id": "VU7HQN",
      "type": "14"
    }
  ]
}
```

</div>

</details>

## JSON Response

<details>
<summary><strong>✅ Example</strong></summary>
<div markdown="1">

```json
{
  "success": {},
  "uniqueID": [
    {
      "type": "14",
      "id": "VU7HQN"
    }
  ],
  "segment": [],
  "status": "CANCELLED",
  "timeStamp": "2025-11-25T04:14:27.963Z",
  "version": 2.001,
  "retransmissionIndicator": false
}
```

</div>

</details>

### Cancellation and Refund Penalty Policy

Read the booking to find its cancellation deadline and the penalty rules for the applicable fare. Check the refund amounts and penalties in the booking details after cancellation.

This policy sets the rules for handling cancellations and refund penalties as per the commercial agreements between SAR and the OTA. The different terms and conditions will apply based on the fare class, booking channel, and specific contractual agreements.
The system will automatically verify the cancellation and refund rules for each OTA based on their agreement and provide the appropriate result. Once the cancellation is successful, a cancelation email will be sent automatically.

### Cancellation email
Support sending cancellation email automatically after HHR success cancelled the booking or segment

![Alt text](../../images/example_cancelEmail.png "Example of Cancellation email")
