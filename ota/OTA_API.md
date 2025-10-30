---
layout: default
title: OTA API Generic Integration Guide
---

# OTA API Generic Integration Guide

## Table of Contents

- [Change Log](#change-log)
- [Introduction](#introduction)
  - [Base URLs](#base-urls)
  - [HTTP Headers](#http-headers)
- [Business Flow](#business-flow)
- [OTA XML Schema 2015](#ota-xml-schema-2015)
- [Postman Collection](#postman-collection)
- [Code Lists](#code-lists)
  - [Booking Class](#booking-class)
  - [Passenger Type](#passenger-type)
  - [Document Type](#document-type)
- [OTA for Reservation workflow](#ota-for-reservation-workflow)

## Change Log

| Change Description | Changed By | Change Date |
|-------------------|------------|-------------|
| Initial creation of generic OTA documentation | Sittiwet Mahapratoom | 2025-01-15 |

For detailed changelog see: [Generic Changelog](generic-changelog.md)

<br />

# Introduction

This document outlines the generic integration of Booking API with airline systems, leveraging OTA API standards. This guide provides airline-agnostic documentation that can be adapted for any airline implementation.

## Base URLs

Use these hosts with the OTA paths documented per endpoint (for example `/ota/v2015b/AirLowFareSearch`).

| Environment | Base URL                      |
|-------------|-------------------------------|
| Production  | https://api.worldticket.net   |
| Test        | https://test-api.worldticket.net |

## HTTP Headers

Attach the following headers to OTA requests.

| Header        | Description                         | Example                   |
|---------------|-------------------------------------|---------------------------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token}     |
| X-API-Key     | API key for key-based authentication| {api_key}                 |
| Content-Type  | Request content type                | application/json          |

Note: Use either `Authorization` (JWT) OR `X-API-Key` (API key), not both.

# Business Flow

This diagram illustrates the API call sequence for searching available flights, creating a reservation, and the intermediate steps required to issue tickets.

```mermaid
sequenceDiagram
    autonumber
    participant Customer as End Customer
    participant Application as Airline Application
    participant OTA
    participant SMS5

    rect rgba(255, 221, 221, 0.3)
        Note over Application: 3rd party
    end
    rect rgba(173, 216, 230, 0.3)
        Note over OTA, SMS5: Worldticket
    end

    Note over Customer, SMS5: Use Case: landing page
    Note over Application: Show the route options.<br/>Departure and Arrival airport
    Customer->>+Application: open web/app
    Application->>+SMS5: GET /routes
    SMS5-->>-Application: airport list
    Application-->>-Customer: show origin/destination list

    Note over Customer, SMS5: Use case: show flight availability on calendar
    Customer->>+Application: select origin/destination
    Note right of Application: (origin, destination,<br/>number of pax, pax type)
    Application->>+OTA: OTA_AirAvailRQ
    OTA-->>-Application: OTA_AirAvailRS
    Note right of Application: flight availability<br/>on each RBD
    Application-->>-Customer: show calendar with availability

    Note over Customer, SMS5: Use case: Flight search
    Customer->>+Application: (origin, destination,<br/>number of pax, pax type)
    Application->>+OTA: OTA_AirLowFareSearchRQ
    OTA-->>-Application: OTA_AirLowFareSearchRS
    Application-->>-Customer: flight list with lowest price

    Note over Customer, SMS5: Use case: User select flight and fare
    Customer->>+Application: select fare
    Application->>+OTA: OTA_AirPriceRQ
    OTA-->>-Application: OTA_AirPriceRS
    Note right of Application: Price break down<br/>and Fare rules
    Application-->>-Customer: show fare break down<br/>and price detail

    Note over Customer, SMS5: Use case: Make reservation
    Customer->>+Application: Booking information
    Note right of Application: Pax name, addr,<br/>phone no., CTC, etc.
    Application->>+OTA: OTA_AirBookRQ
    OTA-->>-Application: OTA_AirBookRS
    Note right of Application: Success: Booking information<br/>PNR Record Locator
    Application-->>-Customer: show booking detail

    alt modify booking
        Customer->>+Application: RepriceRequired="true"
        Note right of Customer: Modification can be<br/>- change name<br/>- SSR<br/>- rebook<br/>- etc
        Note right of Application: RepriceRequired="true"<br/>get price not modify
        Application->>+OTA: OTA_AirBookModifyRQ
        OTA-->>-Application: OTA_AirBookModifyRS
        Note right of Application: Service fee/charge<br/>for booking modification
        Application-->>-Customer: show fee/charge<br/>for booking modify
        Customer->>+Application: default or RepriceRequired="false"
        Application->>+OTA: OTA_AirBookModifyRQ
        Note right of OTA: modify booking
        OTA-->>-Application: OTA_AirBookModifyRS
        Application-->>-Customer: show booking modify
    end

    Note over Customer, SMS5: Use case: issue e ticket
    Customer->>+Application: Pay
    Application->>Application: Process payment
    Application->>+OTA: OTA_AirDemandTicketRQ
    OTA-->>-Application: OTA_AirDemandTicketRS
    Note right of Application: Success: ticket information
    Application-->>-Customer: booking confirmed
```

# OTA XML Schema 2015
[Download OTA XML Schema 2015](/docs/assets/resources/ota-xmlbeans-2015B.zip)
<br />

# Postman Collection
[Download Postman Collection](/docs/assets/resources/OTA_postman_collection.json)
Please update the variables in collection such as apiKey, agent_id, agent_name and tenant.
<br /><br />

# Code Lists

## Booking Class

| Class | Description    |
| ----- | -------------- |
| Y     | Economy class  |
| C     | Business class |

## Passenger Type

| Code   | Description |
| ------ | ----------- |
| ADULT  | Adult       |
| CHILD  | Child       |
| INFANT | Infant      |

## Document Type

| Code | Description |
| ---- | ----------- |
| 2    | Passport    |
| 5    | National ID |

<br /><br />

# OTA for Reservation workflow

|         | Production                                     | Test                                           |
| ------- | ---------------------------------------------- | ---------------------------------------------- |
| OTA API | https://api.worldticket.net/ota/v2015b/OTA     | https://test-api.worldticket.net/ota/v2015b/OTA |

- [Flight Availability](generic/flight-availability)
- [Flight Search](generic/flight-search)
  - [One-way trip](generic/flight-search#airlowfaresearchrq-for-oneway-trip)
  - [One-way trip with booking class](generic/flight-search#airlowfaresearchrq-for-oneway-trip-with-booking-class-preference)
  - [Round trip](generic/flight-search#airlowfaresearchrq-for-round-trip)
  - [Round trip with booking class](generic/flight-search#airlowfaresearchrq-for-round-trip-with-booking-class-preference)
  - [Discount functionality](generic/flight-search#discount-functionality)
- [Price Check](generic/price-check.md)
- [Regular Booking](generic/booking-regular)
  - [Regular booking for One-way trip](generic/booking-regular#airbookrq-for-oneway-trip)
  - [Regular booking for Round trip](generic/booking-regular#airbookrq-for-round-trip)
<!-- - [Group Booking](generic/booking-group) -->
  <!-- - [Group booking for One-way trip](generic/booking-group#airpricerq-for-oneway-trip) -->
  <!-- - [Group booking for Round trip](generic/booking-group#airpricerq-for-round-trip) -->
  <!-- - [Group booking completion policy](generic/booking-group#group-booking-completion-policy) -->
- [Read Booking](generic/read-booking.md)
- [Payment and Ticketing](generic/payment-ticketing)
  - [External Payment](generic/payment-ticketing#external-payment)
  - [Credit Card Payment](generic/payment-ticketing#credit-card-payment)
  - [Debit-Credit Payment](generic/payment-ticketing#debit-credit-payment)
  - [Payment with Redirect](generic/payment-ticketing#payment-with-redirect)
  - [Currency Conversion](generic/payment-ticketing#currency-conversion)
- [Booking Modification](generic/booking-modification)
  - [Add SSR](generic/booking-modification#add-ssr)
  - [Change Name](generic/booking-modification#change-name)
  - [Change Date](generic/booking-modification#change-date)
  - [Cancel Segment](generic/booking-modification#cancel-segment)
  - [Cancel Passenger](generic/booking-modification#cancel-passenger)
- [Booking Cancellation](generic/booking-cancellation)
  - [Full Booking Cancellation](generic/booking-cancellation#full-booking-cancellation)
- [Refund Process](generic/refund-process)
  - [Refund Request APIs](generic/refund-process#refund-request-apis)
  - [Refund Reasons](generic/refund-process#refund-reasons)
  - [Upload Attachments](generic/refund-process#upload-attachments)
- [Error Handling](generic/error-handling)
  - [Common Error Codes](generic/error-handling#common-error-codes)
  - [Error Response Format](generic/error-handling#error-response-format)
