---
layout: default
title: Order Retrieve (OrderRetrieveRQ mapping)
---

# Order Retrieve / View Mapping

This note explains how the platform maps an IATA `OrderRetrieveRQ` (request) and `OrderViewRS` (response) exchange onto
the REST endpoints implemented in `order-management-service`.

## Relevant REST endpoints

| Use case                                                | HTTP contract                                                                            | Implementation                                                        | Notes                                                                                                      |
|---------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Retrieve a specific order by UUID                       | `GET /orders/{id}` → `GetOrderResponse`                                                  | `OrderResource#findById` (`order-rest-server/.../OrderResource.java`) | Requires the caller to know the internal UUID of the order.                                                |
| Retrieve an order using record locator + passenger name | `GET /orders?record_locator=XY1234&last_name=Doe[&first_name=Jane]` → `GetOrderResponse` | `OrderResource#getOrderByParams`                                      | Mirrors the IATA “record locator + traveler name” search. `last_name` is mandatory, `first_name` optional. |

Both endpoints ultimately return the same DTO (`io.go7.order.transfer.order.GetOrderResponse`), which is the JSON
representation delivered to clients (and can be adapted into an `OrderViewRS` payload if XML is needed downstream).

## Workflow (NDC API guide)

**Step 4** ([workflow index](../NDC_API.md#ndc-for-offers--orders-workflow)). There is **no** `POST …/OrderRetrieve` URL on the gateway; **`OrderRetrieveRQ`** maps to order-management **REST**: **`GET /orders/{id}`** when **`OrderID`** is a UUID, or **`GET /orders?record_locator=…&last_name=…`** for PNR lookup (details below). Scenario JSON shapes: **`#orderretrieve-one-way-on-hold`**, **`#orderretrieve-one-way-instant`**, **`#orderretrieve-round-trip-on-hold`**, **`#orderretrieve-round-trip-instant`**.

For programmatic access, `order-rest-client` offers matching methods `OrderRestClient#getOrder(UUID)` and
`OrderRestClient#getOrderByRecordLocator(OrderQuery)`.

## Scenario samples (`GET` order)

Illustrative **`GetOrderResponse`** JSON shapes after **`GET /orders/{uuid}`**. Replace `{order_api_base}` with your deployed order-management host.

### One-way, on hold (`DRAFT`)
{: #orderretrieve-one-way-on-hold}

```http
GET {order_api_base}/orders/5f9312c6-87b5-4aef-ac04-8ada74e1562f
```

```json
{
  "orderId": "5f9312c6-87b5-4aef-ac04-8ada74e1562f",
  "status": "DRAFT",
  "tripType": "ONE_WAY",
  "recordLocator": null,
  "segments": [{ "direction": "OUTBOUND", "origin": "BKK", "destination": "SIN" }]
}
```

### One-way, instant pay (`OPEN`)
{: #orderretrieve-one-way-instant}

Same **`GET`** by UUID; **`status`** is **`OPEN`** and ticket/segment detail is populated.

```json
{
  "orderId": "5f9312c6-87b5-4aef-ac04-8ada74e1562f",
  "status": "OPEN",
  "tripType": "ONE_WAY",
  "recordLocator": "ABC123"
}
```

### Round trip, on hold
{: #orderretrieve-round-trip-on-hold}

```json
{
  "orderId": "e9b2c4d1-1111-2222-3333-444455556666",
  "status": "DRAFT",
  "tripType": "ROUND_TRIP",
  "segments": [
    { "direction": "OUTBOUND", "origin": "BKK", "destination": "SIN" },
    { "direction": "INBOUND", "origin": "SIN", "destination": "BKK" }
  ]
}
```

### Round trip, instant pay
{: #orderretrieve-round-trip-instant}

```json
{
  "orderId": "e9b2c4d1-1111-2222-3333-444455556666",
  "status": "OPEN",
  "tripType": "ROUND_TRIP",
  "recordLocator": "XYZ789"
}
```

## Mapping OrderRetrieveRQ → REST calls

### 1. Decide whether to call by UUID or by record locator

1. Inspect `Request.OrderCriteria.OrderID.Value` inside `OrderRetrieveRQ`.
2. If the value is present **and** parses as a UUID, call `GET /orders/{id}` directly. This guarantees an exact match
   and bypasses passenger-name requirements.
3. If `OrderID` is missing or not a UUID, fall back to the record locator search (step 2).
4. When both are present, prefer the UUID path; use the record locator path only as a fallback.

### 2. Map XML fields to `OrderQuery`

`OrderResource#getOrderByParams` builds an `OrderQuery` with only three fields:

```java
// Built by OrderResource#getOrderByParams → OrderQuery
recordLocator  io.go7.commons.flight.RecordLocator
firstName      java.lang.String // optional
lastName       java.lang.String // required
```

Populate those fields from the XML as follows:

| OrderRetrieveRQ XPath                                                                            | OrderQuery field | Comments                                                                                     |
|--------------------------------------------------------------------------------------------------|------------------|----------------------------------------------------------------------------------------------|
| `Request/OrderValidationFilterCriteriaType/BookingReferences/BookingRefFilterCriteria/BookingID` | `recordLocator`  | Our BookingID is PNR.                                                                        |
| `Request/OrderValidationFilterCriteriaType/PaxFilterCriteriaType[0]/Individual/GivenName`        | `firstName`      | Optional for the API but improves disambiguation; pass it whenever the request supplies one. |
| `Request/OrderValidationFilterCriteriaType/PaxFilterCriteriaType[0]/Individual/Surname`          | `lastName`       | Mandatory. The REST controller validates that this is not blank.                             |

> If the incoming request lacks a surname, mimic `OrderResource` behavior and reject the request (HTTP 400 / validation
> error).

### 3. Sample adapter logic

```java
GetOrderResponse mapAndFetch(OrderRetrieveRQ request) {
    Optional<String> orderIdValue = Optional.ofNullable(request.getRequest())
            .map(OrderRetrieveRequestType::getOrderValidationFilterCriteria)
            .map(OrderValidationFilterCriteriaType::getOrderFilterCriteria)
            .map(OrderCriteriaType::getOrderID)
            .map(UniqueIDType::getValue);

    if (orderIdValue.isPresent()) {
        UUID uuid = UUID.fromString(orderIdValue.get());
        return orderRestClient.getOrder(uuid);
    }

    OrderQuery query = buildOrderQuery(request); // populate record locator + names per table above
    return orderRestClient.getOrderByRecordLocator(query);
}
```

### 4. Mapping the response

`GetOrderResponse` already contains the complete JSON view of the order (passengers, services, payments, etc.). To
produce an XML `OrderViewRS`, wrap that data into the schema’s `Response` element (type `OrderViewResponseType`) or, if
operating purely in JSON, reuse `GetOrderResponse` directly.

## Unsupported OrderRetrieveRQ filters

The IATA schema allows additional search keys (ticket numbers, coupons, filters by itinerary segments, etc.). The
current REST surface **only** supports:

- A UUID lookup (`/orders/{id}`)
- A PNR/record-locator lookup combined with traveler surname (and optional given name)

Any other filter supplied in the XML must either be ignored (with clear logging) or rejected upstream until the REST API
is extended.

## Testing checklist

- UUID path: craft a request containing `OrderID.Value` set to a known UUID, expect `GET /orders/{id}` to return 200
  with the order payload.
- Record locator path: supply booking reference + traveler names, expect `GET /orders` with the corresponding query
  parameters.
- Validation edge cases: omit surname → expect 400; provide malformed UUID → expect validation failure before hitting
  the REST endpoint.

