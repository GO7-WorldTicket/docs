## Download Tickets

### Base URL

| Production                                            | Test                                                  |
| ----------------------------------------------------- |-------------------------------------------------------|
| {{ sar_profile.production_origin }}/sms-gateway-service | {{ sar_profile.test_api_origin }}/sms-gateway-service  |


### Download all tickets in a booking

The following endpoint can be used to download a zip file containing all tickets (pdf files) of a booking.

**Endpoint:** `/tickets/confirmation/{rloc}/download`<br>
**Method:** `GET`<br>
**Content-Type:** `application/zip`

#### Request Parameters

| Parameter | Type   | Required | Description | Example |
|-----------|--------|----------|-------------|---------|
| x-api-key | Header | Yes | Access Token | [Access token]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#api-key) |
| rloc | Path | Yes | Booking reference (RLOC) | O8ZKAK |
| mode | Query | No | Download mode. Omit this parameter to use `full`, or specify `full` explicitly. `delta` and its backward-compatible alias `legacy` are deprecated and scheduled for removal at the end of 2026. After removal, only `full` will be supported. | full |

> **Migration:** Use the endpoint without the `mode` parameter to download all tickets. This is equivalent to `mode=full`.

#### Request (default mode)

```bash
curl '{base_url}/tickets/confirmation/{rloc}/download' \
    -H 'x-api-key: {api-key}' \
    --output tickets_full.zip
```

#### Request (explicit full mode)

```bash
curl '{base_url}/tickets/confirmation/{rloc}/download?mode=full' \
    -H 'x-api-key: {api-key}' \
    --output tickets_full.zip
```

> ⚠️ If an unsupported `mode` value is provided, the request returns `400 Bad Request`.

### Download a specific ticket

The following endpoint can now be used to download a specific ticket PDF using the `ticketNumber` and `couponNumber`. This change was introduced to support the ticket download for the group reservations when passenger names are unknown.

> ⚠️ **Note:** Previous query parameters like `firstName`, `lastName`, `departure`, and `arrival` are still temporarily supported but deprecated. They will be removed in the near future. Please migrate to using `ticketNumber` and `couponNumber`.

The previous version of this endpoint using passenger name and flight route details is still temporarily available, but it is deprecated and will be removed in the near future. Please migrate to using `ticketNumber` and `couponNumber`.

**Endpoint:** `/tickets/confirmation/{bookingReference}/download/passenger-segment`<br>
**Method:** `GET`<br>
**Content-Type:** `application/pdf`

#### Request Parameters (all required)

| Parameter     | Type   | Description           | Example                                |
|---------------|--------|-----------------------|----------------------------------------|
| x-api-key     | Header | Access Token          | [Access token]({{ sar_profile.documentation_root }}/OTA_API_SAR.html#api-key) |
| ticketNumber  | Query  | Ticket number         | 3333330292535                           |
| couponNumber  | Query  | Coupon number         | 1                                      |

#### Request

```
curl '{base_url}/tickets/confirmation/{bookingReference}/download/passenger-segment?ticketNumber={ticketNumber}&couponNumber={couponNumber}' \
    -H 'x-api-key: {api-key}' \
    --output ticket.pdf
```

#### Deprecated Request (will be removed soon)

```
curl '{base_url}/tickets/confirmation/{bookingReference}/download/passenger-segment?firstName={firstName}&lastName={lastName}&departure={departure}&arrival={arrival}' \
    -H 'x-api-key: {api-key}' \
    --output ticket.pdf
```
