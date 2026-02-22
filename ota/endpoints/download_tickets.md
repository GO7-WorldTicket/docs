## Download Tickets

### Base URL

| Production                                            | Test                                                  |
| ----------------------------------------------------- |-------------------------------------------------------|
| https://api.sar.worldticket.cloud/sms-gateway-service | https://test-api.worldticket.net/sms-gateway-service  |


### Download all tickets in a booking

The following endpoint can be used to download a zip file containing all tickets (pdf files) of a booking.

**Endpoint:** `/tickets/confirmation/{rloc}/download`   
**Method:** `GET`  
**Content-Type:** `application/zip`

#### Request Parameters

| Parameter | Type   | Required | Description | Example |
|-----------|--------|----------|-------------|---------|
| x-api-key | Header | Yes | Access Token | [Access token](../OTA_API_SAR#api-key) |
| rloc | Path | Yes | Booking reference (RLOC) | O8ZKAK |
| mode | Query | No | Download mode. Supported values: `full` (default), `delta`. `legacy` is accepted for backward compatibility and behaves as `delta`. | full |

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

#### Request (delta mode)

```bash
curl '{base_url}/tickets/confirmation/{rloc}/download?mode=delta' \
    -H 'x-api-key: {api-key}' \
    --output tickets_delta.zip
```

> ⚠️ If an unsupported `mode` value is provided, the request returns `400 Bad Request`.

### Download a specific ticket

The following endpoint can now be used to download a specific ticket PDF using the `ticketNumber` and `couponNumber`. This change was introduced to support the ticket download for the group reservations when passenger names are unknown.

> ⚠️ **Note:** Previous query parameters like `firstName`, `lastName`, `departure`, and `arrival` are still temporarily supported but deprecated. They will be removed in the near future. Please migrate to using `ticketNumber` and `couponNumber`.

The previous version of this endpoint using passenger name and flight route details is still temporarily available, but it is deprecated and will be removed in the near future. Please migrate to using `ticketNumber` and `couponNumber`.

**Endpoint:** `/tickets/confirmation/{bookingReference}/download/passenger-segment`   
**Method:** `GET`  
**Content-Type:** `application/pdf`

#### Request Parameters (all required)

| Parameter     | Type   | Description           | Example                                |
|---------------|--------|-----------------------|----------------------------------------|
| x-api-key     | Header | Access Token          | [Access token](../OTA_API_SAR#api-key) |
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
