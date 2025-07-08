---
layout: default
title: The Title of Your Page
---

# OTA API Request and Response for SAR integration

## Table of Contents

- [Introduction](#introduction)
- [Business Flow](#business-flow)
- [Authentication](#authentication)
  - [JWT](#jwt)
  - [API Key](#api-key)
- [OTA XML Schema 2015](#ota-xml-schema-2015)
- [Postman Collection](#postman-collection)
- [Code Lists](#code-lists)
  - [Booking Class](#booking-class)
  - [Passenger Type](#passengers-type)
  - [Document Type](#document-type)
- [Available Routes and Flights](#available-routes-and-flights-calendar)
- [OTA for Reservation workflow](#ota-for-reservation-workflow)

## Change Log

| Change Description                                                                                        | Changed By              | Change Date |
|-----------------------------------------------------------------------------------------------------------|-------------------------|-------------|
| [Add resend cancellation email endpoint](endpoints/resend_cancellation_email)                             | Duangtida Athakravi     | 2025-07-08  |
| [Add policy for OTA_AirBookRS, OTA_AirPriceRS](changelog.md#2025-07-02)                                   | Thotsaphorn Phonlabutr  | 2025-06-26  |
| [Clarify request and response for AirLowFareSearch (one-way with booking class)](changelog.md#2025-06-26) | Sittiwet Mahapratoom    | 2025-06-26  |
| [Deprecate download endpoint using passenger details](changelog.md#2025-06-21)                            | Sittiwet Mahapratoom    | 2025-06-21  |
| [Error handling change](changelog.md#2025-04-23)                                                          | Sittiwet Mahapratoom    | 2025-04-23  |
| [Add group booking completion policy](endpoints/create_booking#group-booking-completion-policy)           | Sittiwet Mahapratoom    | 2025-04-22  |
| [Describe error response changes](endpoints/error-response)                                               | Sittiwet Mahapratoom    | 2025-04-22  |
| [Specify the required fields summary](endpoints/create_booking#-required-fields-summary)                  | Sittiwet Mahapratoom    | 2025-04-22  |
| [Download Ticket URI](changelog.md#2025-04-16)                                                            | Andrii Denysenko        | 2025-04-16  |
| Add send cancelled email flow                                                                             | Benjaporn Kunathanachot | 2024-07-24  |
| Add download ticket endpoints                                                                             | Duangtida Athakravi     | 2024-07-16  |
| Add cancel duration policy                                                                                | Arnon Ruangthanawes     | 2024-07-16  |
| Add resending email endpoint                                                                              | Sittiwet Mahapratoom    | 2024-07-12  |
| Revise document structures                                                                                | Arnon Ruangthanawes     | 2024-07-12  |
| Upload schema and postman files                                                                           | Arnon Ruangthanawes     | 2024-05-29  |
| Describe how to cancel booking entirely or partially                                                      | Sergii Poltorak         | 2024-05-22  |
| Include error messages in Low Fare Search                                                                 | Arnon Ruangthanawes     | 2024-05-14  |
| Update code mapping                                                                                       | Arnon Ruangthanawes     | 2024-05-13  |
| Update api urls, and add examples                                                                         | Arnon Ruangthanawes     | 2024-03-26  |
| Initial creation of the document                                                                          | Arnon Ruangthanawes     | 2024-03-19  |

<br />

# Introduction

This document outlines the integration of the Booking API with HHR systems, leveraging it over the OTA API.

## Endpoints

### Test Endpoints

|                  | Test                                            |
|------------------|-------------------------------------------------|
| Auth API         | https://test-auth.worldticket.net/auth          |
| OTA API          | https://test-api.worldticket.net/ota/v2015b/OTA |
| REST API         | https://test-api.worldticket.net/{service-name} |


### Production Endpoints

|                  | Production                                            |
|------------------|-------------------------------------------------------|
| Auth API         | https://api.sar.worldticket.cloud/auth                |
| OTA API          | https://api.sar.worldticket.cloud/ota/v2015b/OTA      |
| REST API         | https://api.sar.worldticket.cloud/{service-name}      |

# Business Flow

This diagram illustrates the API call sequence for searching available trains, creating a reservation, and the intermediate steps required to issue tickets.

![Alt text](../images/business_flow.svg "Business flow")

# Authentication

This section provides the procedures necessary for authorized access. Refer to this section for credentials information and endpoints for the authentication.

There are two authentication types:

- [API Key](#api-key)
- [JWT](#jwt)

## API KEY

The API key should be attached to the HTTP request as `X-API-Key` HTTP header.

`Never deploy your key in client-side like browsers or mobile apps as it allows malicious users to take that key and make requests on your behalf.`

| API KEY                        |
| ------------------------------ |
| 8cee91a8-4d2c-47e5-b174-xxxxxx |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api_key}' \
    -H 'local-name: {local_name}' \
```

## JWT

|                   | Production                             | Test                                   |
| ----------------- | -------------------------------------- | -------------------------------------- |
| Identity Provider | https://api.sar.worldticket.cloud/auth | https://test-auth.worldticket.net/auth |

Before calling any OTA method it's mandatory to get access and refresh tokens from the Identity Provider.

Replace all variables in curly braces with the actual values.

| Variable      | Description                         | Example                                |
| ------------- | ----------------------------------- | -------------------------------------- |
| base_url      | Identity provider URL               | https://test-auth.worldticket.net/auth |
| tenant        | Short airline name stands for realm | test-rs3                               |
| client_id     | Application ID                      | sms4                                   |
| client_secret | Application secret                  | 33357c21-3233-4eb3-a420-**\*\*\*\***   |
| username      | User login                          | username                               |
| password      | User password                       | **\*\*\*\***                           |

<details>
  <summary><b>Authentication Request and Response</b></summary>
  <h4>Request</h4>
  <pre>
    curl -X POST \
    {base_url}/realms/{tenant}/protocol/openid-connect/token \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d 'grant_type=password&client_id=sms4&client_secret={client_secret}&username={username}&password={password}'
  </pre>

  <h4>Response</h4>
  <pre>
    {
      "access_token": "eyJhbGciOiJSU...",
      "expires_in": 7200,
      "refresh_expires_in": 14400,
      "refresh_token": "eyJhbGciOiJ...",
      "token_type": "bearer",
      "id_token": "eyJhbGciOiJ...",
      "not-before-policy": 1565113348,
      "session_state": "89fde8f3-39ff-436e-9dce-99387c591fda"
    }
  </pre>
</details>
<br /><br />

# OTA XML Schema 2015
[Download OTA XML Schema 2015](/docs/assets/resources/ota-xmlbeans-2015B.zip)
<br />

# Postman Collection
[Download Postman Collection](/docs/assets/resources/OTA_postman_collection.json)
Please update the variables in collection such as apiKey, agent_id, agent_name and tenant.
<br /><br />

# Code Lists

## Booking Class

| Class | Description    | HHR Booking Class |
| ----- | -------------- | ----------------- |
| Y     | Economy class  | T                 |
| C     | Business class | P                 |

## Passengers type

| Code   | Description | HHR Code |
| ------ | ----------- | -------- |
| ADULT  | Adult       | 1        |
| CHILD  | Child       | 2        |
| INFANT | Infant      | 3        |

## Document Type

| Code | Description |
| ---- | ----------- |
| 2    | Passport    |
| 5    | National ID |


<br /><br />

# Available Routes and Flights Calendar

|                  | Production                                            | Test                                     |
| ---------------- | ----------------------------------------------------- | ---------------------------------------- |
| Routes & Flights | https://api.sar.worldticket.cloud/sms-gateway-service | https://test.worldticket.net/sms-gateway |


- [Routes](endpoints/available_routes_and_flights#routes)
- [Calendar Availability](endpoints/available_routes_and_flights#calendar-availability)
<br /><br />

# OTA for Reservation workflow

|         | Production                                       | Test                                            |
| ------- | ------------------------------------------------ | ----------------------------------------------- |
| OTA API | https://api.sar.worldticket.cloud/ota/v2015b/OTA | https://test-api.worldticket.net/ota/v2015b/OTA |

- [Error Response](endpoints/error-response)
- [Low Fare Search](endpoints/low_fare_search)
  - [One-way trip](endpoints/low_fare_search#airlowfaresearchrq-for-oneway-trip)
  - [One-way trip with booking class](endpoints/low_fare_search#airlowfaresearchrq-for-oneway-trip-with-booking-class-preference)
  - [Round trip](endpoints/low_fare_search#airlowfaresearchrq-for-round-trip)
  - [Round trip with booking class](endpoints/low_fare_search#airlowfaresearchrq-for-round-trip-with-booking-class-preference)
  - [Error Message](endpoints/low_fare_search#lowfare-search-error-message)
- [Create a booking](endpoints/create_booking)
- [Regular booking](endpoints/create_booking#create-a-regular-booking-airbookrq)
  - [Regular booking for One-way trip](endpoints/create_booking#airbookrq-for-oneway-trip)
  - [Regular booking for Round trip](endpoints/create_booking#airbookrq-for-round-trip)
- [Group booking](endpoints/create_booking#create-a-group-booking-airpricerq)
  - [Group booking for One-way trip](endpoints/create_booking#airpricerq-for-oneway-trip)
  - [Group booking for Round trip](endpoints/create_booking#airpricerq-for-round-trip)
  - [Group booking completion policy](endpoints/create_booking#group-booking-completion-policy)
- [Payment and Ticketing](endpoints/payment_and_ticketing.md)
- [Read booking](endpoints/read_booking)
- [Modify booking](endpoints/modify-booking)
- [Modify booking for One-way trip](endpoints/modify-booking#change-passenger-in-one-way-booking)
- [Modify booking for Round trip](endpoints/modify-booking#change-passenger-in-round-trip-booking)
- [Cancel booking](endpoints/cancel_booking)
  - [Cancel Policy](endpoints/cancel_booking#cancel-policy)
    - [Cancel Duration Policy](endpoints/cancel_booking#cancel-duration-policy)
    - [Cancel Refund Policy](endpoints/cancel_booking#cancel-refund-policy)
  - [Cancellation email](endpoints/cancel_booking#cancellation-email)
  - [Resend cancellation email](endpoints/resend_cancellation_email)
- [Resend ticket confirmation email](endpoints/resend_ticket_confirmation_email)
- [Download tickets](endpoints/download_tickets)
