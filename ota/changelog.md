## Changelog

### 2025-04-16

#### Improved documents URLs in `TPAExtension` for `OTA_AirDemandTicketRS` and `OTA_AirBookRS`

To eliminate ambiguity in document download URLs and to simplify handling service responses, 
the `links` block has been added instead of the string field `urls`. 
The old field (`urls`) will remain for backward compatibility. 
The new field will contain the actual URL (`href`), a relation type (`rel`), and **optional** `segmentRPH` and `travelerRPH`.

```
 "links": [
    {
      "href" : "https://domain.com/tickets/download?ref=11",
      "rel" : "downloadTicket",
      "segmentRPH" : "1", // Optional
      "travelerRPH" : "1" // Optional
    }
  ]
```

<details open>
  <summary>Old version</summary>
  <pre><code>
    "tpaextensions": {
      "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX"
    }
  </code></pre>
</details>

<details open>
  <summary>New version</summary>
  <pre><code>
    "tpaextensions": {
      "urls": "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX",
      "links": [
        {
          "href" : "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=MKX&arrival=DMX",
          "rel" : "downloadTicket",
          "segmentRPH" : "1",
          "travelerRPH" : "1"
        },
        {
          "href" : "https://test-api.worldticket.net/sms-gateway-service/tickets/confirmation/QN6HQV/download/passenger-segment?firstName=JENNIFER&lastName=STEWART&departure=DMX&arrival=MKX",
          "rel" : "downloadTicket",
          "segmentRPH" : "2",
          "travelerRPH" : "1"
        }
      ]
    }
  </code></pre>
</details>

**Example**
- [See Response Payload (named passengers) in Payment and Ticketing](endpoints/payment_and_ticketing.md#request)
- [See Response Payload in Read booking](endpoints/read_booking.md#response)
