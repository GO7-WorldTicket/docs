---
layout: default
title: NDC API Generic Integration Guide
---

# NDC API Generic Integration Guide

## Table of Contents

- [NDC API Generic Integration Guide](#ndc-api-generic-integration-guide)
  - [Table of Contents](#table-of-contents)
  - [Change Log](#change-log)
- [Introduction](#introduction)
  - [Base URLs](#base-urls)
  - [HTTP Headers](#http-headers)
  - [Authentication](#authentication)
- [Business Flow](#business-flow)
  - [Phase 1 scenario summary](#phase-1-scenario-summary)
  - [NDC Gateway workflow (Phased 1)](#ndc-gateway-workflow-phased-1)
- [NDC XML (Offers & Orders)](#ndc-xml-offers--orders)
- [Postman Collection](#postman-collection)
- [Code Lists](#code-lists)
  - [Passenger Type (PTC)](#passenger-type-ptc)
  - [Cabin Type](#cabin-type)
  - [Document Type](#document-type)
- [NDC for Offers & Orders workflow](#ndc-for-offers--orders-workflow)
  - [Basic request format (API key)](#basic-request-format-api-key)

## Change Log

| Change Description                                                  | Changed By              | Change Date |
|---------------------------------------------------------------------|-------------------------|-------------|
| Prepared Postman collection and update API request/response example | Thotsaphorn Phonlabutr  | 2026-05-08  |
| Initial creation of the document                                    | Naphachara Rattanawilai | 2026-05-06  |

# Introduction

This document outlines generic integration with the Go7 **NDC Gateway** using **IATA NDC Offers & Orders** XML messages. Schema distribution **21.3** is exposed under the HTTP path **`/v21.3.5`**. Per-message field references also live under [`ndc/endpoints/`](endpoints/airshopping.md).

Requests use **XML bodies** with **`Content-Type: application/xml`** (or `application/xml;charset=UTF-8`). **[Authentication](#authentication)** describes tenant/channel headers and API key usage.

## Base URLs

Use these hosts with the paths documented per endpoint (for example `POST …/v21.3.5/AirShopping`).

| Environment               | Base URL |
|---------------------------|-----------|
| Production (platform API) | `https://api.go7.io` |
| Test (platform API)       | `https://go7-api-gateway.dev.go7.io/ndc-gateway` |

All Offers & Orders messages documented here are posted under:

`https://api.go7.io/v21.3.5/<MessageName>`

## HTTP Headers

Attach the following headers to NDC Gateway requests unless an endpoint page specifies otherwise.

| Header | Description | Example |
|--------|-------------|---------|
| `x-tenant` | Tenant identifier | `test-qa-rc` |
| `x-SalesChannel` | Sales channel (`NDC`, `IBE`, …) | `NDC` |
| `x-api-key` | API key authentication | `96d2bf5f-2740-4d64-80e9-3542cc44bbbb` |
| `Content-Type` | Request body type | `application/xml` |

Use `x-api-key` for authentication on NDC Gateway requests.

## Authentication

Every request must include **`x-tenant`** and **`x-SalesChannel`** (see [HTTP Headers](#http-headers)).

Use **`x-api-key`** for caller authentication on all NDC Gateway endpoints in this guide.

Order retrieve / view mapping (`OrderRetrieveRQ` → REST) uses the **order management** APIs documented in [Order Retrieve mapping](endpoints/orderretrieve.md); follow that service auth model.

# Business Flow

Phased 1 scenarios cover shopping and pricing offers, creating or confirming orders, reshop/requote paths, and order retrieve.

[//]: # (## Sequence diagram)

[//]: # ()
[//]: # (The diagram shows **Customer → Integrator Application → NDC Gateway** flows for each Phase 1 scenario &#40;messages under `/v21.3.5`&#41;.)

[//]: # ()
[//]: # (![NDC Gateway business flow — Phase 1 scenarios]&#40;../assets/ndc/ndc-business-flow.png "Phase 1 Customer → Application → Gateway flows"&#41;)

[//]: # ()
[//]: # (*Cancel flow omits `OrderQuote` when refunds are not supported.*)

## Phase 1 scenario summary

| Scenario                         | Message sequence                                                                                                                            |
|----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| Create & confirm on-hold booking | `AirShopping` → `OfferPrice` → `OrderCreate`(no payment) → `OrderRetrieve` → `OrderQuote` → `OrderChange` → `OrderRetrieve`.                |
| Create paid booking              | `AirShopping` → `OfferPrice` → `OrderCreate` (with payment) →`OrderRetrieve`.                                                               |
| Manage booking — rebook          | `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderRetrieve`.                                                           |
| Manage booking — cancel          | `OrderRetrieve` → `OrderReshop` (cancel); **`OrderQuote` not used in Phase 1** when refunds are unsupported → `OrderChange` → `OrderRetrieve`. |
| Retrieve booking                 | `OrderRetrieve` (view only).              |

## NDC Gateway workflow (Phased 1)

Official scenario grid (**NDC Gateway — NDC Workflow Process, Phased 1**):

![NDC Gateway NDC workflow — Phased 1 scenarios](../assets/ndc/ndc-workflow-phased1.jpg "Official phased 1 scenario grid")

IATA **`OrderRetrieveRQ`** is mapped to internal order REST reads (UUID vs record locator + traveler name): see [Order Retrieve mapping](endpoints/orderretrieve.md).

# NDC XML (Offers & Orders)

Use IATA **OffersAndOrders** message XML (`IATA_AirShoppingRQ`, `IATA_OrderCreateRQ`, etc.) as shown in each endpoint document. Official XSDs are published by IATA for distribution **21.3**; align payloads with the examples in [`ndc/endpoints/`](endpoints/airshopping.md).

# NDC XML Schema
[Download NDC XML Schema 21.3.5](/docs/assets/resources/ndc-xmlbeans-20.3.5.zip)

# Postman Collection
[Download Postman Collection](/docs/assets/resources/NDC_postman_collection.json)
Please update the variables in collection such as x-api-key, x-saleschannel, tenant, ndc-gateway-url.

# Code Lists

[//]: # (## Price Class)
[//]: # ()
[//]: # (| Class Id | Code    | Description   |)
[//]: # (|----------|---------| ------------- |)
[//]: # (| PC1      | Bedre   | Business class |)
[//]: # (| PC2      | Economy | Economy class |)

## Passenger Type (PTC)

| Code | Description |
|------|-------------|
| ADT | Adult |
| CHD | Child |
| INF | Infant |

## Cabin Type

| Code | Description |
|------|-------------|
| Y | Economy |
| C | Business |
| F | First |

## Document Type

| Code | Description |
|------|-------------|
| PP   | Passport |
| ID   | National ID |
| DL   | Driver’s License |
| FP   | Frequent Flyer |

# NDC for Offers & Orders workflow

Same pattern as **[OTA for Reservation workflow](../ota/OTA_API.md#ota-for-reservation-workflow)**: this section is an **index only**. Each **step** links to the endpoint `.md` file where requests, responses, and scenario anchors live. See **[Authentication](#authentication)**.

Typical Phased 1 chain: **AirShopping → OfferPrice → OrderCreate**, then **OrderRetrieve** / **OrderReshop** / **OrderQuote** / **OrderChange** as needed (see [Phase 1 scenario summary](#phase-1-scenario-summary)).

| | Production-style base | Message path pattern |
|--|------------------------|----------------------|
| Offers & Orders API | `https://api.go7.io` | `/v21.3.5/<MessageName>` |

- **1 — [Air Shopping](endpoints/airshopping.md)** — `POST …/AirShopping` · `IATA_AirShoppingRQ` / `RS`
  - [One-way trip](endpoints/airshopping.md#airshopping-one-way-trip)
  - [Round trip](endpoints/airshopping.md#airshopping-round-trip)
- **2 — [Offer Price](endpoints/offerprice.md)** — `POST …/OfferPrice` · priced offer for **OrderCreate**
  - [One-way](endpoints/offerprice.md#offerprice-one-way-trip)
  - [Round trip](endpoints/offerprice.md#offerprice-round-trip)
- **3 — [Order Create](endpoints/ordercreate.md)** — `POST …/OrderCreate` · accept priced offer; optional payment
  - [Pay later (on hold)](endpoints/ordercreate.md#ordercreate-pay-later)
  - [Instant pay](endpoints/ordercreate.md#ordercreate-instant-pay)
- **4 — [Order Retrieve mapping](endpoints/orderretrieve.md)** — `OrderRetrieveRQ` → **`GET /orders/…`** (no gateway `POST`)
  - [One-way, on hold (`DRAFT`)](endpoints/orderretrieve.md#orderretrieve-one-way-on-hold)
  - [One-way, instant pay (`OPEN`)](endpoints/orderretrieve.md#orderretrieve-one-way-instant)
  - [Round trip, on hold](endpoints/orderretrieve.md#orderretrieve-round-trip-on-hold)
  - [Round trip, instant pay](endpoints/orderretrieve.md#orderretrieve-round-trip-instant)
- **5 — [Order Reshop](endpoints/orderreshop.md)** — `POST …/OrderReshop` · alternatives for rebook or cancel
  - [Rebook](endpoints/orderreshop.md#orderreshop-rebook)
  - [Cancel order](endpoints/orderreshop.md#orderreshop-cancel-order)
- **6 — [Order Quote](endpoints/orderquote.md)** — `POST …/OrderQuote` · quote before **OrderChange**
  - [Rebook quote](endpoints/orderquote.md#orderquote-rebook)
  - [Cancel quote](endpoints/orderquote.md#orderquote-cancel)
  - [Booking (confirm on-hold quote)](endpoints/orderquote.md#orderquote-booking)
- **7 — [Order Change](endpoints/orderchange.md)** — `POST …/OrderChange` · pay **DRAFT**, or accept quoted / rebook offers
  - [Payment on hold booking](endpoints/orderchange.md#orderchange-payment-on-hold)
  - [Payment with debit](endpoints/orderchange.md#orderchange-payment-debit)
  - [Payment with credit](endpoints/orderchange.md#orderchange-payment-credit)
  - [Rebook with new offers](endpoints/orderchange.md#orderchange-rebook)

## Basic request format (API key)
{: #workflow-basic-curl}

```bash
curl -X POST "https://api.go7.io/v21.3.5/<MessageName>" \
  -H "x-tenant: {tenant}" \
  -H "x-SalesChannel: NDC" \
  -H "x-api-key: {api_key}" \
  -H "Content-Type: application/xml" \
  -d @request.xml
```

Replace `<MessageName>` with `AirShopping`, `OfferPrice`, `OrderCreate`, etc.
