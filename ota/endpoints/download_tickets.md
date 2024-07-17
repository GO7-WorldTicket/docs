## Download Tickets

### Base URL

| Production                                            | Test                                                  |
| ----------------------------------------------------- |-------------------------------------------------------|
| https://api.sar.worldticket.cloud/sms-gateway-service | https://test-api.worldticket.net/sms-gateway-service  |


### Download all tickets in a booking

The following endpoint can be used to download a zip file containing all tickets (pdf files) of a booking.

**Endpoint:** `/tickets/confirmation/{bookingReference}/download`   
**Method:** `GET`  
**Content-Type:** `application/zip`

#### Request Parameters (all required)

| Parameter        | Type   | Description       | Example                  |
|------------------|--------|-------------------|--------------------------|
| x-api-key        | Header | Access Token      | [Access token](#api-key) |
| bookingReference | Path   | Booking reference | O8ZKAK                   |

#### Request

```
curl '{base_url}/tickets/confirmation/{bookingReference}/download' \
    -H 'x-api-key: {api-key}' \
    --output tickets.zip
```

### Download a specific ticket

The following endpoint can be used to download a ticket (pdf file) of a ticket within a booking.

**Endpoint:** `/tickets/confirmation/{bookingReference}/download/passenger-segment`   
**Method:** `GET`  
**Content-Type:** `application/pdf`

#### Request Parameters (all required)

| Parameter        | Type   | Description               | Example                                |
|------------------|--------|---------------------------|----------------------------------------|
| x-api-key        | Header | Access Token              | [Access token](../OTA_API_SAR#api-key) |
| bookingReference | Path   | Booking reference         | O8ZKAK                                 |
| firstName        | Query  | Passenger first name      | JENNIFER                               |
| lastName         | Query  | Passenger last name       | STEWART                                |
| departure        | Query  | Departure airport/station | DMX                                    |
| arrival          | Query  | Arrival airport/station   | JED                                    |

#### Request

```
curl '{base_url}/tickets/confirmation/{booking-reference}/download/passenger-segment?firstName={firstName}&lastName={lastName}&departure={departure}&arrival={arrival}' \
    -H 'x-api-key: {api-key}' \
    --output ticket.pdf
```