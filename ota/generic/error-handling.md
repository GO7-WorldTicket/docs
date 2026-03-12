---
layout: default
title: Error Handling
---

# Error Handling

Comprehensive guide to OTA API error responses, codes, and handling strategies.

## Error Response Format

### XML Error Format

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_ErrorRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Errors>
        <Error Type="{error_type}" Code="{error_code}" ShortText="{short_description}">
            {detailed_error_message}
        </Error>
    </Errors>
</OTA_ErrorRS>
```

### JSON Error Format

```json
{
  "errors": [
    {
      "type": "{error_type}",
      "code": "{error_code}",
      "message": "{detailed_error_message}",
      "field": "{field_name}",
      "timestamp": "{error_timestamp}"
    }
  ],
  "requestId": "{unique_request_id}"
}
```

## Error Types

### Authentication Errors

| HTTP Code | Error Code | Description | Solution |
|-----------|------------|-------------|----------|
| 401 | UNAUTHORIZED | Invalid or missing authentication | Verify API key or JWT token |
| 401 | TOKEN_EXPIRED | JWT token has expired | Refresh token using refresh_token |
| 403 | FORBIDDEN | Valid token but insufficient permissions | Check API access permissions |
| 401 | INVALID_API_KEY | API key is invalid or revoked | Contact support for new API key |

#### Example

```json
{
  "errors": [
    {
      "type": "authentication",
      "code": "TOKEN_EXPIRED",
      "message": "JWT token has expired. Please refresh your token.",
      "timestamp": "2023-04-09T10:30:00Z"
    }
  ]
}
```

### Validation Errors

| Error Code | Description | Common Causes |
|------------|-------------|---------------|
| MISSING_REQUIRED_FIELD | Required field is missing | Empty or null required parameters |
| INVALID_DATE_FORMAT | Date format is incorrect | Wrong date format, use ISO 8601 |
| INVALID_AIRPORT_CODE | Airport code not recognized | Typo in IATA code or unsupported airport |
| INVALID_PASSENGER_COUNT | Passenger count exceeds limits | Too many passengers for single booking |
| INVALID_CURRENCY_CODE | Currency code not supported | Use ISO 4217 currency codes |

#### Example

```xml
<OTA_ErrorRS>
    <Errors>
        <Error Type="validation" Code="MISSING_REQUIRED_FIELD" ShortText="Required field missing">
            The field 'departureDateTime' is required but was not provided.
        </Error>
        <Error Type="validation" Code="INVALID_DATE_FORMAT" ShortText="Invalid date format">
            Date must be in ISO 8601 format (YYYY-MM-DDTHH:MM:SS).
        </Error>
    </Errors>
</OTA_ErrorRS>
```

### Business Logic Errors

| Error Code | Description | Resolution |
|------------|-------------|------------|
| NO_FLIGHTS_AVAILABLE | No flights found for criteria | Adjust search parameters |
| SEAT_NOT_AVAILABLE | Requested seat is unavailable | Select different seat or booking class |
| BOOKING_NOT_FOUND | Booking record not found | Verify record locator |
| FARE_NO_LONGER_AVAILABLE | Selected fare is no longer valid | Re-search for current fares |
| PAYMENT_DECLINED | Payment processing failed | Try different payment method |
| MODIFICATION_NOT_ALLOWED | Booking cannot be modified | Check fare rules and restrictions |

#### Example

```json
{
  "errors": [
    {
      "type": "business_logic",
      "code": "NO_FLIGHTS_AVAILABLE",
      "message": "No flights available for the selected route and date",
      "details": {
        "route": "JFK-LAX",
        "date": "2023-12-25",
        "suggestions": [
          "Try different dates",
          "Check nearby airports"
        ]
      }
    }
  ]
}
```

### System Errors

| Error Code | Description | Action |
|------------|-------------|--------|
| INTERNAL_SERVER_ERROR | System malfunction | Retry request, contact support if persistent |
| SERVICE_UNAVAILABLE | Service temporarily down | Wait and retry with exponential backoff |
| TIMEOUT | Request processing timeout | Retry with shorter request or contact support |
| RATE_LIMIT_EXCEEDED | Too many requests | Implement rate limiting, retry after delay |

#### Example

```xml
<OTA_ErrorRS>
    <Errors>
        <Error Type="system" Code="SERVICE_UNAVAILABLE" ShortText="Service temporarily unavailable">
            The booking service is temporarily unavailable. Please try again in a few minutes.
        </Error>
    </Errors>
</OTA_ErrorRS>
```

## Common Error Scenarios

### Flight Search Errors

#### No Availability

```json
{
  "errors": [
    {
      "code": "NO_AVAILABILITY",
      "message": "No flights available for the requested criteria",
      "searchCriteria": {
        "origin": "JFK",
        "destination": "LAX",
        "departureDate": "2023-12-25",
        "passengers": 2
      },
      "suggestions": [
        "Try flexible dates",
        "Consider nearby airports",
        "Reduce passenger count"
      ]
    }
  ]
}
```

#### Invalid Route

```xml
<Error Code="INVALID_ROUTE" ShortText="Route not served">
    The route from {origin} to {destination} is not served by this airline.
    <AlternativeRoutes>
        <Route>JFK-ORD-LAX</Route>
        <Route>JFK-DFW-LAX</Route>
    </AlternativeRoutes>
</Error>
```

### Booking Errors

#### Sold Out

```json
{
  "errors": [
    {
      "code": "FLIGHT_SOLD_OUT",
      "message": "The selected flight is sold out",
      "flight": {
        "flightNumber": "FL123",
        "date": "2023-12-25"
      },
      "alternatives": [
        {
          "flightNumber": "FL125",
          "departureTime": "14:30",
          "availableSeats": 15
        }
      ]
    }
  ]
}
```

#### Invalid Passenger Data

```xml
<Errors>
    <Error Code="INVALID_PASSENGER_DATA" Field="document.expireDate">
        Document expiry date must be at least 6 months from departure date.
    </Error>
    <Error Code="INVALID_PASSENGER_DATA" Field="personName.surname">
        Passenger surname cannot be empty.
    </Error>
</Errors>
```

### Payment Errors

#### Card Declined

```json
{
  "errors": [
    {
      "code": "PAYMENT_DECLINED",
      "message": "Payment was declined by the card issuer",
      "paymentDetails": {
        "cardType": "VISA",
        "lastFourDigits": "1234"
      },
      "declineReason": "Insufficient funds",
      "suggestions": [
        "Try a different card",
        "Contact your bank",
        "Use alternative payment method"
      ]
    }
  ]
}
```

#### Invalid CVV

```xml
<Error Code="INVALID_CVV" ShortText="Invalid security code">
    The card security code (CVV) is incorrect. Please verify and try again.
</Error>
```

## Error Handling Best Practices

### 1. Exponential Backoff

For transient errors, implement exponential backoff:

```javascript
const maxRetries = 3;
let delay = 1000; // Start with 1 second

for (let attempt = 0; attempt < maxRetries; attempt++) {
  try {
    const response = await apiCall();
    return response;
  } catch (error) {
    if (isRetryableError(error) && attempt < maxRetries - 1) {
      await sleep(delay);
      delay *= 2; // Double the delay
    } else {
      throw error;
    }
  }
}
```

### 2. Error Classification

```javascript
function isRetryableError(error) {
  const retryableCodes = [
    'SERVICE_UNAVAILABLE',
    'TIMEOUT',
    'INTERNAL_SERVER_ERROR',
    'RATE_LIMIT_EXCEEDED'
  ];
  return retryableCodes.includes(error.code);
}

function isUserError(error) {
  const userErrorTypes = ['validation', 'authentication'];
  return userErrorTypes.includes(error.type);
}
```

### 3. User-Friendly Messages

```javascript
function getUserMessage(error) {
  const messageMap = {
    'NO_FLIGHTS_AVAILABLE': 'No flights found for your search. Try different dates or destinations.',
    'PAYMENT_DECLINED': 'Payment failed. Please check your card details or try a different payment method.',
    'BOOKING_NOT_FOUND': 'We couldn\'t find your booking. Please check your confirmation number.',
    'SERVICE_UNAVAILABLE': 'Service is temporarily unavailable. Please try again in a few minutes.'
  };
  
  return messageMap[error.code] || 'An unexpected error occurred. Please try again.';
}
```

### 4. Logging and Monitoring

```javascript
function logError(error, context) {
  const logData = {
    timestamp: new Date().toISOString(),
    errorCode: error.code,
    errorMessage: error.message,
    requestId: error.requestId,
    userId: context.userId,
    endpoint: context.endpoint,
    requestData: context.requestData
  };
  
  // Send to logging service
  logger.error('OTA API Error', logData);
  
  // Send to monitoring service for alerts
  if (isCriticalError(error)) {
    monitoring.alert('Critical OTA API Error', logData);
  }
}
```

## Error Prevention

### Input Validation

```javascript
function validateSearchRequest(request) {
  const errors = [];
  
  if (!request.origin || !/^[A-Z]{3}$/.test(request.origin)) {
    errors.push('Origin must be a valid 3-letter airport code');
  }
  
  if (!request.departureDate || !isValidDate(request.departureDate)) {
    errors.push('Departure date must be a valid ISO 8601 date');
  }
  
  if (request.passengers < 1 || request.passengers > 9) {
    errors.push('Passenger count must be between 1 and 9');
  }
  
  return errors;
}
```

### Rate Limiting

```javascript
class RateLimiter {
  constructor(maxRequests, timeWindow) {
    this.maxRequests = maxRequests;
    this.timeWindow = timeWindow;
    this.requests = [];
  }
  
  canMakeRequest() {
    const now = Date.now();
    this.requests = this.requests.filter(
      time => now - time < this.timeWindow
    );
    
    if (this.requests.length >= this.maxRequests) {
      return false;
    }
    
    this.requests.push(now);
    return true;
  }
}
```

## Debugging Tips

1. **Include Request ID**: Always log the request ID for correlation
2. **Check API Version**: Ensure you're using the correct API version
3. **Validate Test Data**: Use known good test data for debugging
4. **Monitor Rate Limits**: Track API usage to avoid rate limiting
5. **Check Service Status**: Verify service health before debugging code
6. **Review Documentation**: Ensure parameter formats match specifications

## Support and Escalation

When errors persist:

1. **Collect Information**:
   - Error message and code
   - Request ID
   - Timestamp
   - Request payload (sanitized)
   - Steps to reproduce

2. **Check Known Issues**:
   - Service status page
   - Documentation updates
   - Community forums

3. **Contact Support**:
   - Include all collected information
   - Specify urgency level
   - Provide business impact assessment