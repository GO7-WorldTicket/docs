## Full Booking Cancellation

This method cancels entire booking. In case you need to cancel individual passenger or segment use `OTA_AirBookingModifyRQ` and not `OTA_CancelRQ` message. 

#### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token](#api-key) |
| local-name   | Header  | Custom HTTP header | OTA_CancelRQ             |
| agentId      | Payload |                    | ota                      |
| agencyId     | Payload |                    | ota                      |

## JSON Request

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
        "isoCurrency": "{currency_code}"
      }
    ]
  },
  "readRequests": {
    "readRequest": [
      {
        "uniqueID": {
          "id": "{record_locator}",
          "type": "14"
        }
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
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "isoCurrency": "USD",
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
This policy sets the rules for handling cancellations and refund penalties as per the commercial agreements between SAR and the OTA. The different terms and conditions will apply based on the fare class, booking channel, and specific contractual agreements.
The system will automatically verify the cancellation and refund rules for each OTA based on their agreement and provide the appropriate result. Once the cancellation is successful, a cancelation email will be sent automatically.

### Cancellation email
Support sending cancellation email automatically after HHR success cancelled the booking or segment

![Alt text](../../images/example_cancelEmail.png "Example of Cancellation email")