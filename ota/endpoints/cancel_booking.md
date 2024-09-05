## Cancel Booking

This method cancels entire booking. In case you need to cancel individual passenger or segment use `OTA_AirBookingModifyRQ` and not `OTA_CancelRQ` message. 

#### Request Parameters

| Parameter    | Type    | Description        | Example                  |
|--------------|---------|--------------------|--------------------------|
| x-api-key    | Header  | Access Token       | [Access token](#api-key) |
| local-name   | Header  | Custom HTTP header | OTA_CancelRQ             |
| agentId      | Payload |                    | ota                      |
| agencyId     | Payload |                    | ota                      |

<details open>
  <summary><b>Request Payload</b></summary>
  <pre>
{
  "version": "2.001",
  "cancelType": "Commit",
  "pos": {
    "source": [
      {
        "isoCurrency": "SAR",
        "requestorID": {
          "type": "5",
          "id": "<ins>agentId</ins>",
          "name": "<ins>agencyId</ins>"
        },
        "bookingChannel": {
          "type": "OTA"
        }
      }
    ]
  },
  "uniqueID": [
    {
      "id": "6ZEFCG",
      "type": "14"
    }
  ]
}
  </pre>
</details>

<details open>
  <summary><b>Response Payload</b></summary>
  <pre>
{
  "success": {},
  "uniqueID": [
    {
      "type": "14",
      "id": "6ZEFCG"
    }
  ],
  "segment": [],
  "status": "CANCELLED",
  "timeStamp": "2024-05-15T05:56:22.041Z",
  "version": 2.001
}
  </pre>
</details>

### Cancellation and Refund Penalty Policy
This policy sets the rules for handling cancellations and refund penalties as per the commercial agreements between SAR and the OTA. The different terms and conditions will apply based on the fare class, booking channel, and specific contractual agreements.
The system will automatically verify the cancellation and refund rules for each OTA based on their agreement and provide the appropriate result. Once the cancellation is successful, a cancelation email will be sent automatically.

### Cancellation email
Support sending cancellation email automatically after HHR success cancelled the booking or segment

![Alt text](../../images/example_cancelEmail.png "Example of Cancellation email")