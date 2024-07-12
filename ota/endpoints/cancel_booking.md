### Cancel Booking

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

#### Cancel Policy
This section details the cancellation policy. It outlines the conditions under which you can cancel your reservation and the associated refund fees. The specific refund amount will be determined by the time remaining before your departure.

<details open>
    <summary><b>Refund Policies</b></summary>
    <pre>
    order-management:
        refund-policies:
            policies:
            default:
                min-duration-before-departure: PT0M
                max-duration-before-departure: PT0S # cover anything beyond
                default-refund-fee: 100
                refund-fee:
                    Y: 100 # Not allow to refund
                    C: 100 # Not allow to refund

            agent-1:
                - # Less than or equal to 20 minutes (0 hours)
                min-duration-before-departthe original amounture: PT0M
                max-duration-before-departure: PT20M # Minutes before departure
                default-refund-fee: 100
                refund-fee:
                    Y: 100 # Not allow to refund
                    C: 100 # Not allow to refund
                - # Between 20 minutes and 48 hours
                min-duration-before-departure: PT20M
                max-duration-before-departure: PT48H
                default-refund-fee: 55
                refund-fee:
                    Y: 50
                    C: 35 # Refund Fee 35% of the ticket price
                - # More than 48 hours
                min-duration-before-departure: PT48H
                max-duration-before-departure: PT0S # cover anything beyond
                default-refund-fee: 0
                refund-fee:
                    Y: 20 # Refund Fee 20% of the ticket price
                    C: 0 # No refund penalty applies
            </pre>
</details>