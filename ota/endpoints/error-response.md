## OTA Error Response

- [1. Introduction](#1-introduction)
  - [1.1 Purpose of this Document](#11-purpose-of-this-document)
  - [1.2 Error Response Format](#12-error-response-format)
      - [Error Response Structure](#error-response-structure)
      - [Response fields and meaning](#response-fields-and-meaning)
      - [HTTP Status Codes](#http-status-codes)
- [2. Type of Error](#2-type-of-error)
  - [2.1 Error Content](#21-error-content)
- [3. Error Code](#3-error-code)
  - [3.1 GO7 Internal OTA Error Code](#31-go7-internal-ota-error-code)
  - [3.2 External OTA Error Code](#32-external-ota-error-code)

### 1. Introduction
#### 1.1 Purpose of this Document

To establish a standardized way to handle and respond to errors during API communication between GO7 and OTA partners. This enables better troubleshooting, clear messaging, and smooth end-user experiences.

#### 1.2 Error Response Format

All API responses containing errors will be returned with the following JSON structure and appropriate HTTP status codes:

##### Error Response Structure

```json
{
  "status": HTTP Status Codes,
  "code": "ERR_CODE",
  "title": "Human-readable description of the error",
  "detail": "Optional technical details for debugging (if any)",
  "correlationId": "e76b44e8-91e2-4fba-88d8-562a6ed7d755"
}
```
**Note:** Other elements not listed in the structure are optional and are intended for internal use by GO7.

#### Response fields and meaning

| Name           | Meaning                                                       |
|----------------|---------------------------------------------------------------|
| status         | HTTP response status code                                     |
| error          | HTTP response status name                                     |
| code           | Original error code shows the root cause of the error.        |
| title          | Error reason                                                  |
| detail         | Error details                                                 |
| correlationId  | Reference number of the transaction that got error            |

#### HTTP Status Codes

| HTTP Status Code | Description                                           |
|------------------|-------------------------------------------------------|
| 400              | Bad Request – The request is invalid.                |
| 401              | Unauthorized – Authentication required.              |
| 403              | Forbidden – Access is denied.                        |
| 404              | Not Found – The requested resource is missing.       |
| 409              | Conflict – Duplicate or conflicting request.         |
| 422              | Unprocessable Entity – Validation error.             |
| 429              | Too Many Requests – Rate limit exceeded.             |
| 500              | Internal Server Error.                               |
| 503              | Service Unavailable – Try again later.               |


### 2. Type of Error
There are 2 types of error included in the content which are ‘External error’ and ‘Internal error’.

    External error - any errors return from HHR system or any 3rd party  
    Internal error - any errors occurs in GO7 microservice

To ensure clarity on error origins, any failure caused by an external service is explicitly reported as the primary error in our response. While doing so, our system reformats the error information received from the external service to match our standard response structure; this changes only the format, ensuring the original error content is preserved. This overall design allows consumers of our service to immediately identify when a reported issue stems from an external dependency, while still receiving the necessary details in a consistent format.

#### 2.1 Error Content

Error responses contain specific details for investigating issues. The main reason (root cause) are shown in the first level which are `status`, `error`, `code`, `title`, and `correlationId` that required by the support team for further investigation. Information contained within the `cause` field should generally be disregarded, as it typically presents low-level technical details intended for developers.

<details>
  <summary>Example of error response</summary>
  <pre>
  {
    "status": 422,
    "error": "Unprocessable Entity",
    "code": "878",
    "title": "Missing/incorrect document type",
    "detail": "No identType found for document type code CC",
    "correlationId": "88f48120-952c-4ebe-b889-809c129932ea",
    "service": "ota-service",
    "instance": "/v2015b/OTA",
    "tenant": "test-skywork-dev",
    "timestamp": "2025-04-16T02:48:11.178912262Z",
    "cause": {
      "status": 422,
      "title": "Missing/incorrect document type",
      "detail": "Issuing tickets for 76ZWU2 failed: 422 : \"{\"type\":null,\"status\":422,\"code\":\"878\",\"title\":\"Missing/incorrect document type\",\"detail\":\"No identType found for document type code CC\",\"correlationId\":\"79f48120-952c-4ebe-b889-809c129932ee\",\"service\":\"hhr-proxy\",\"instance\":\"/tickets/A4561192D\",\"tenant\":\"mservice\",\"timestamp\":\"2025-04-17T02:48:11.127672994Z\",\"cause\":null}\"",
      "correlationId": "88f48120-952c-4ebe-b889-809c129932ea",
      "service": "ticket-service",
      "tenant": "mservice",
      "timestamp": "2025-04-16T02:48:11.164445981Z",
      "cause": {
        "status": 422,
        "code": "878",
        "title": "Missing/incorrect document type",
        "detail": "No identType found for document type code CC",
        "correlationId": "88f48120-952c-4ebe-b889-809c129932ea",
        "service": "hhr-proxy",
        "tenant": "mservice",
        "timestamp": "2025-04-16T02:48:11.164401079Z"
      }
    }
  }
  </pre>
</details>

### 3. Error Code
#### 3.1 GO7 Internal OTA Error Code

| Error Code | Title / Description                                      |
|------------|----------------------------------------------------------|
| 6          | Service closed for sales                                 |
| 7          | Route code invalid                                       |
| 8          | No reservations on route requested                       |
| 9          | Requested service is fully booked                        |
| 11         | Service connections not possible                         |
| 15         | Invalid date                                             |
| 16         | Service has been cancelled                               |
| 17         | Time request not with fare/tariff                        |
| 19         | Name is missing or incomplete                            |
| 20         | Number of passengers invalid                             |
| 21         | Passenger type quota exceeded                            |
| 22         | Passengers exceed commercial rules                       |
| 23         | Passenger type not supported                             |
| 24         | Passenger class capacity exceeded                        |
| 25         | Passenger types not consistent                           |
| 26         | At least one adult must be included                      |
| 27         | Passenger details are mandatory                          |
| 42         | Too many classes                                         |
| 48         | Tariff type invalid                                      |
| 49         | Tariff invalid for passenger mix                         |
| 53         | No price exists for the tariff                           |
| 58         | Price(s) cannot be validated                             |
| 59         | Offer price cannot be calculated                         |
| 60         | Ticket numbers missing or invalid                        |
| 61         | Invalid currency code                                    |
| 63         | Cannot ticket until booking priced                       |
| 64         | Tickets do not match reservation                         |
| 65         | Cannot ticket - already issued                           |
| 71         | Cannot ticket at this agency                             |
| 72         | Cannot ticket - cancelled booking                        |
| 73         | Cannot ticket - expired booking                          |
| 74         | Cannot ticket - itinerary commenced                      |
| 76         | Ticket issue request not possible                        |
| 83         | Leg/journey/itinerary reference invalid                  |
| 86         | Cannot cancel - itinerary complete                       |
| 87         | Booking reference invalid                                |
| 95         | Booking already cancelled                                |
| 96         | Duplicated itinerary                                     |
| 97         | Booking reference not found                              |
| 99         | Booking not owned by requester                           |
| 101        | Cannot book - departure too close                        |
| 102        | Booking reference not connected                          |
| 103        | Cannot access - itinerary complete                       |
| 107        | Cannot book - too far in advance                         |
| 111        | Booking invalid                                          |
| 113        | Mandatory booking details missing                        |
| 117        | Cannot access booking details                            |
| 118        | Booking status invalid                                   |
| 122        | End date has passed                                      |
| 123        | Too many children                                        |
| 124        | Too many babies                                          |
| 127        | Reservation already exists                               |
| 146        | Service requested incorrect                              |
| 158        | Departure or to date required                            |
| 161        | Search criteria invalid                                  |
| 163        | Payment type invalid                                     |
| 167        | Payment rejected                                         |
| 171        | Booking not made by this agent                           |
| 172        | Requested action not possible                            |
| 173        | Agency code required                                     |
| 174        | Bookings made by different agents                        |
| 175        | Password invalid                                         |
| 181        | Invalid country code                                     |
| 182        | Password required                                        |
| 183        | Agency suspended - access denied                         |
| 184        | Language code invalid                                    |
| 187        | System currently unavailable                             |
| 189        | Payment not authorised                                   |
| 190        | Wrong network - access denied                            |
| 191        | System busy - please try later                           |
| 193        | Cancellation process failed                              |
| 194        | No matching bookings found                               |
| 195        | Service restriction - security                           |
| 239        | Flight number must be accompanied by an airline.         |
| 240        | Credit card has expired                                  |
| 241        | Expiration date is invalid                               |
| 242        | Credit card number is invalid or missing                 |
| 244        | Email address is invalid                                 |
| 248        | Invalid airline code                                     |
| 254        | Reservation date has passed                              |
| 264        | Reservation cannot be cancelled                          |
| 285        | Invalid first name                                       |
| 286        | First name contains invalid characters                   |
| 287        | Invalid last name                                        |
| 288        | Last name contains invalid characters                    |
| 293        | Invalid departure time                                   |
| 294        | Invalid arrival time                                     |
| 297        | Unable to process - insufficient data                    |
| 305        | Invalid booking source                                   |
| 310        | Required data missing: last name                         |
| 311        | Required data missing: first name                        |
| 312        | Required data missing: airline flight number             |
| 314        | Required data missing: country of residence              |
| 318        | Required data missing: arrival time                      |
| 320        | Invalid value                                            |
| 321        | Required field missing                                   |
| 322        | No availability                                          |
| 353        | Departure date is past dated                             |
| 356        | Invalid action/status code                               |
| 407        | Item too long                                            |
| 417        | Name change not allowed                                  |
| 420        | Need e-mail address                                      |
| 448        | System error                                             |
| 450        | Unable to process                                        |
| 458        | Date outside inventory period                            |
| 497        | Authorization error                                      |
| 499        | The selected train, segment, or fare is no longer available |
| 501        | Invalid date for flight requested                        |
| 508        | Invalid/missing reservation booking designator           |
| 523        | Surname too long                                         |
| 524        | Given name/title too long                                |
| 559        | Booking period restriction applies                       |
| 568        | Cancellation penalties apply                             |
| 569        | Group booking required                                   |
| 570        | Cannot cancel - arrival too close - call property        |
| 571        | Travel agency name required                              |
| 572        | Company name required                                    |
| 631        | Company name code invalid or missing                     |
| 632        | Prepaid modify or cancel not allowed-call reservations   |
| 633        | We are unable to process your request-please remove the slash |
| 635        | Data not found                                           |
| 713        | Currency of payment cannot be changed-must cancel or change |
| 743        | Invalid message length                                   |
| 744        | Invalid field length                                     |
| 745        | Invalid field ID                                         |
| 768        | Inconsistent status                                      |
| 770        | Required data missing: reservation holder                |
| 854        | Booking allotment blocking failed                        |
| 860        | Passenger details error                                  |
| 877        | Insufficient available funds found in your credit line   |
| 878        | Missing/incorrect document type                          |
| 879        | Missing/incorrect document number                        |
| 883        | Price change detected                                    |
| 884        | Currency change detected                                 |
| 885        | Inconsistency between total returned and estimated total |
| 886        | Inconsistent settings for this client                    |
| 888        | Degraded performance, system throttling                  |

#### 3.2 External OTA Error Code

| Error Code | Title / Description |
|------------|---------------------|
| 1000 | Missing request token |
| 1001 | Missing parameter: <NAME> |
| 1002 | Unknown parameter: <NAME> |
| 1003 | Empty parameter: <NAME> |
| 1004 | Parameter <NAME> has invalid value <VALUE> |
| 1010 | Agency <CODE> not found |
| 1011 | User <AGENT> not found |
| 1020 | Route <ID> not found |
| 1021 | The route <ID> does not contain a segment <ID> |
| 1022 | Missing segment <ID> for route <ID> |
| 1023 | Missing segment stations. |
| 1024 | The segment is duplicated in the request |
| 1025 | The transport <ID> has a departure time before the previous booking arrival |
| 1026 | Segments <IDs> have already been cancelled |
| 1030 | Invalid category <CLASS> |
| 1031 | Invalid profile <ID> |
| 1032 | Missing or empty profiles |
| 1033 | Missing or invalid profile quantity <QTY> |
| 1050 | RFU |
| 1051 | ¡ Already used reference id: <ID> |
| 1052 | Invalid reference <ID> |
| 1053 | Not enough seats for category <ID> |
| 1054 | Selected category <ID> not found, or is not available |
| 1055 | Selected fare <ID> not found, or is not available |
| 1056 | Selected profile <ID> not found, or is not available |
| 1057 | Invalid context credentials for current request |
| 1058 | Unable to assign traveler seat |
| 1059 | Selected station not found: <VALUE> |
| 1060 | Unknown purchase id: <ID> |
| 1061 | Invalid state <STATE> for purchase id: <ID> |
| 1062 | Invalid details for purchase id: <ID> |
| 1063 | Unknown traveller id: <ID> |
| 1064 | Invalid profile <PROFILE_ID> for traveller <TRAVELLER_ID> |
| 1065 | traveller name not provided |
| 1066 | traveller surname not provided |
| 1067 | traveller birthday not provided |
| 1068 | traveller identType not provided |
| 1069 | traveller identNumber not provided |
| 1070 | traveller identExpiration not provided |
| 1071 | ticket price not provided |
| 1072 | ticket spaceId not provided |
| 1073 | ticket travellerId not provided |
| 1074 | ticket transportId not provided |
| 1075 | ticket fareId not provided |
| 1076 | Missing operationId |
| 1077 | traveller gender type not provided |
| 1078 | traveller id not provided |
| 1079 | traveller nationality not provided |
| 1080 | Selected locale <LOCALE> not found, or is not available |
| 1081 | Invalid selected locale |
| 1082 | traveller person type not provided |
| 1083 | there are ident numbers applicated to more than one traveler: <ID> |
| 1501 | Unable to recover downstream categories, response received: <CODE> |
| 1502 | Unable to recover downstream categories, empty response received |
| 1503 | Unable to recover downstream profiles, response received: <CODE> |
| 1504 | Unable to recover downstream profiles, empty response received |
| 1505 | Unable to recover downstream fares, response received: <CODE> |
| 1506 | Unable to recover downstream fares, empty response received |
| 1507 | Unable to recover downstream fare revenue, response received: <CODE> |
| 1508 | Unable to recover downstream fare revenue, empty response received |
| 1509 | Unable to recover downstream fare families, response received: <CODE> |
| 1510 | Unable to recover downstream fare families, empty response received |
| 1511 | Unable to recover downstream fees, response received: <CODE> |
| 1512 | Unable to recover downstream fees, empty response received |
| 1513 | Unable to recover downstream VAT, response received: <CODE> |
| 1514 | Unable to recover downstream VAT, empty response received |
| 1515 | Unable to recover downstream occupancy, response received: <CODE> |
| 1516 | Unable to recover downstream occupancy, empty response received |
| 1517 | Unable to recover downstream occupancy rules, response received: <CODE> |
| 1518 | Unable to recover downstream occupancy rules, empty response received |
| 1519 | Unable to recover downstream routes, response received: <CODE> |
| 1520 | Unable to recover downstream routes, empty response received |
| 1521 | Unable to recover downstream routes, response received: <CODE> |
| 1522 | Unable to recover downstream routes, empty response received |
| 1523 | Unable to recover downstream trains, response received: <CODE> |
| 1524 | Unable to recover downstream trains, empty response received |
| 1600 | Availability service fault: <CAUSE> |
| 1601 | Unable to generate pass, missing traveller space |
| 1602 | Unable to confirm bookings |
| 1603 | Unable to cancel bookings |
| 1604 | Unable to decline bookings |
| 1900 | Policy [<POLICY_NAME>] not satisfied |
| 3001 | Booking ids not found: <CODE> |
| 3002 | Missing search parameters |
| 3003 | Service [traind: <CODE>, departureStation: <CODE>, arrivalStation: <CODE>, departureTime: <DATE>, arrivalTime: <DATE>] not found |
| 3004 | An infant cannot travel without an accompanied adult |
| 3005 | Each infant must be assigned to a single adult within the reservation |
| 3501 | Missing parameter <NAME> |
| 3502 | The seat <CODE> / <DATE> / <DATE> is not reserved |
| 3503 | The seat <CODE> has invalid <CODE> state |
| 3504 | The seat [seatId: <CODE>, departureTime: <DATE>, arrivalTime: <DATE>] is not anymore reserved |
| 3505 | The reservation cannot be cancelled: <CAUSE> |
| 3506 | Occupancy for train [traind: <CODE> , departureTime: <DATE>, arrivalTime: <DATE>] not found |
| 3507 | There is no occupancy data for the <CODE> category |
| 3508 | There are no available seats to complete the reservation |
| 3509 | Train [traind: <CODE>, departureStation: <CODE>, arrivalStation: <CODE>, departureTime: <DATE>, arrivalTime: <DATE>] was cancelled |
| 3510 | Train [traind: <CODE>, departureStation: <CODE>, arrivalStation: <CODE>, departureTime: <DATE>, arrivalTime: <DATE>] was locked |
| 3511 | The reservation cannot be completed. The quota for the service has been changed |
| 5001 | Unknown purchase id: <CODE> |
| 5002 | Invalid state <CODE> for booking id: <ID> |