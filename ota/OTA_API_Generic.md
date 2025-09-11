---
layout: default
title: OTA API Generic Integration Guide
---

# OTA API Generic Integration Guide

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
  - [Passenger Type](#passenger-type)
  - [Document Type](#document-type)
- [Available Routes and Flights](#available-routes-and-flights)
- [OTA for Reservation workflow](#ota-for-reservation-workflow)

## Change Log

| Change Description | Changed By | Change Date |
|-------------------|------------|-------------|
| Initial creation of generic OTA documentation | Claude | 2025-01-15 |

For detailed changelog see: [Generic Changelog](generic-changelog.md)

<br />

# Introduction

This document outlines the generic integration of Booking API with airline systems, leveraging OTA API standards. This guide provides airline-agnostic documentation that can be adapted for any airline implementation.

## Endpoints

### Test Endpoints

|                  | Test                                            |
|------------------|-------------------------------------------------|
| Auth API         | https://{test-auth-domain}/auth                 |
| OTA API          | https://{test-api-domain}/ota/v2015b/OTA        |
| REST API         | https://{test-api-domain}/{service-name}       |

### Production Endpoints

|                  | Production                                      |
|------------------|-------------------------------------------------|
| Auth API         | https://{auth-domain}/auth                      |
| OTA API          | https://{api-domain}/ota/v2015b/OTA             |
| REST API         | https://{api-domain}/{service-name}             |

# Business Flow

This diagram illustrates the API call sequence for searching available flights, creating a reservation, and the intermediate steps required to issue tickets.

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
| {your-api-key}                 |

#### Request

```
curl -X POST \
    {base_url} \
    -H 'x-api-key: {api_key}' \
    -H 'local-name: {local_name}'
```

## JWT

|                   | Production                    | Test                          |
| ----------------- | ----------------------------- | ----------------------------- |
| Identity Provider | https://{auth-domain}/auth    | https://{test-auth-domain}/auth |

Before calling any OTA method it's mandatory to get access and refresh tokens from the Identity Provider.

Replace all variables in curly braces with the actual values.

| Variable      | Description                         | Example                        |
| ------------- | ----------------------------------- | ------------------------------ |
| base_url      | Identity provider URL               | https://{test-auth-domain}/auth |
| tenant        | Short airline name stands for realm | {tenant-name}                  |
| client_id     | Application ID                      | {client-id}                    |
| client_secret | Application secret                  | {client-secret}                |
| username      | User login                          | {username}                     |
| password      | User password                       | {password}                     |

<details>
  <summary><b>Authentication Request and Response</b></summary>
  <h4>Request</h4>
  <pre>
    curl -X POST \
    {base_url}/realms/{tenant}/protocol/openid-connect/token \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d 'grant_type=password&client_id={client_id}&client_secret={client_secret}&username={username}&password={password}'
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

# Available Routes and Flights

|                  | Production                                | Test                                    |
| ---------------- | ----------------------------------------- | --------------------------------------- |
| Routes & Flights | https://{api-domain}/{service-name}      | https://{test-api-domain}/{service-name} |

- [Routes](generic/flight-availability#routes)
- [Calendar Availability](generic/flight-availability#calendar-availability)
<br /><br />

# OTA for Reservation workflow

|         | Production                              | Test                                    |
| ------- | --------------------------------------- | --------------------------------------- |
| OTA API | https://{api-domain}/ota/v2015b/OTA     | https://{test-api-domain}/ota/v2015b/OTA |

- [Authentication](generic/authentication)
- [Flight Availability](generic/flight-availability)
- [Flight Search](generic/flight-search)
  - [One-way trip](generic/flight-search#airlowfaresearchrq-for-oneway-trip)
  - [One-way trip with booking class](generic/flight-search#airlowfaresearchrq-for-oneway-trip-with-booking-class-preference)
  - [Round trip](generic/flight-search#airlowfaresearchrq-for-round-trip)
  - [Round trip with booking class](generic/flight-search#airlowfaresearchrq-for-round-trip-with-booking-class-preference)
  - [Discount functionality](generic/flight-search#discount-functionality)
- [Regular Booking](generic/booking-regular)
  - [Regular booking for One-way trip](generic/booking-regular#airbookrq-for-oneway-trip)
  - [Regular booking for Round trip](generic/booking-regular#airbookrq-for-round-trip)
- [Group Booking](generic/booking-group)
  - [Group booking for One-way trip](generic/booking-group#airpricerq-for-oneway-trip)
  - [Group booking for Round trip](generic/booking-group#airpricerq-for-round-trip)
  - [Group booking completion policy](generic/booking-group#group-booking-completion-policy)
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