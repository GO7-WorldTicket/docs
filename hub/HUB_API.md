---
layout: default
title: GO7 HUB API
---

# GO7 HUB API

## Table of Contents

- [Introduction](#introduction)
- [Business Flow](#business-flow)
- [Insomnia Collection](#insomnia-collection)
- [GO7 HUB API](#go7-hub-api)

## Change Log

| Change Description                                   | Changed By | Change Date |
|------------------------------------------------------|------------|-------------|
| Initial creation of the document                     |            |             |

<br />

# Introduction

This document outlines the integration of the GO7 HUB API functionality

## Endpoints

### Test Endpoints

|                  | Test                                                  |
|------------------|-------------------------------------------------------|
| REST API         | https://go7-gateway.dev.go7.io/graphiql?path=/graphql |


### Production Endpoints

|                  | Production                                            |
|------------------|-------------------------------------------------------|
| REST API         |                                                       |

# Business Flow

This diagram illustrates the GO7 HUB API calls sequence for searching available routes, request list of calendar items, find flight offers and service offers, request seat-map and reserve/release seat.
Create order, update passenger information and pay for order.

![Alt text](diagrams/hub_basic_flow.svg "Business flow")

# Insomnia Collection
Please make separate request for Insomnia collection

# GO7 HUB API

|       | Production | Test                                    |
|-------|------------|-----------------------------------------|
| API   |            | https://go7-gateway.dev.go7.io/graphql  |

- [Sales Channel Properties](endpoints/sales_channel_properties.md)
- [Find Available Routes](endpoints/routes_availability.md)
- [Calendar Availability](endpoints/calendar_availability.md)
- [Flight Offers Search](endpoints/flight_offers_search.md)
- [Service Offers Search](endpoints/service_offers_search.md)
- [Seat availability search](endpoints/seat_availability.md)
- [Reserve and release seat](endpoints/reserve_release_seat.md)