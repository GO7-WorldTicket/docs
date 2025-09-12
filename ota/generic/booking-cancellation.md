---
layout: default
title: Booking Cancellation
---

# Cancel Booking

The purpose is to cancel entire bookings or specific segments/passengers.

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://api.worldticket.net/ota/v2015b/OTA |
| Test | https://test-api.worldticket.net/ota/v2015b/OTA |

## Full Booking Cancellation

Cancel the entire booking and all associated passengers.

### HTTP Headers (All Required)

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| Local-Name | OTA operation identifier | OTA_CancelRQ |
| Content-Type | Request content type | application/xml |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

### Request Parameters

| Parameter | Location | Required | Description | Example |
|-----------|----------|----------|-------------|---------|
| base_url | Endpoint | Yes | Base URL for the request | https://test-api.worldticket.net/ota/v2015b/OTA |

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_CancelRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <UniqueID Type="14" ID="{record_locator}">
        <CompanyName Code="{airline_code}"/>
    </UniqueID>
    <Verification>
        <PersonName>
            <GivenName>{lead_passenger_first_name}</GivenName>
            <Surname>{lead_passenger_last_name}</Surname>
        </PersonName>
    </Verification>
    <CancellationOverrides>
        <CancellationOverride Type="FullCancellation">
            <Description>Complete booking cancellation</Description>
        </CancellationOverride>
    </CancellationOverrides>
</OTA_CancelRQ>
```

### JSON Request

```json
{
  "version": "2.001",
  "pos": {
    "source": [{
      "requestorID": {
        "type": "5",
        "id": "{agent_id}",
        "name": "{agency_id}"
      }
    }]
  },
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "companyName": {
      "code": "{airline_code}"
    }
  },
  "verification": {
    "personName": {
      "givenName": "{lead_passenger_first_name}",
      "surname": "{lead_passenger_last_name}"
    }
  },
  "cancellationOverrides": {
    "cancellationOverride": {
      "type": "FullCancellation",
      "description": "Complete booking cancellation"
    }
  }
}
```

## Cancel Policy

### Cancel Duration Policy

Cancellation policies vary by fare type and timing:

- **Free Cancellation Period**: Usually 24 hours from booking
- **Standard Cancellation**: Fees apply based on fare rules
- **Non-refundable Fares**: May only allow cancellation with penalties
- **Last Minute Cancellation**: Higher fees or restrictions

### Cancel Refund Policy

Refund amounts depend on several factors:

1. **Fare Conditions**: Each fare has specific refund rules
2. **Timing**: When cancellation occurs relative to departure
3. **Reason**: Voluntary vs involuntary cancellations
4. **Taxes and Fees**: Usually refundable minus processing fees

### Policy Examples

```xml
<CancellationPolicy>
    <PolicyInfo Type="Refundable">
        <Description>Full refund available minus cancellation fee</Description>
        <CancellationFee Amount="{cancellation_fee}" CurrencyCode="{currency_code}"/>
        <RefundableAmount Amount="{refundable_amount}" CurrencyCode="{currency_code}"/>
    </PolicyInfo>
    <PolicyInfo Type="NonRefundable">
        <Description>Taxes and fees refundable only</Description>
        <RefundableAmount Amount="{tax_refund}" CurrencyCode="{currency_code}"/>
    </PolicyInfo>
</CancellationPolicy>
```

## Response Structure

### XML Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_CancelRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Success/>
    <UniqueID Type="14" ID="{record_locator}">
        <CompanyName Code="{airline_code}"/>
    </UniqueID>
    <CancellationStatus Status="Confirmed" DateTime="{cancellation_datetime}">
        <Text>Booking successfully cancelled</Text>
    </CancellationStatus>
    <RefundInfo>
        <RefundAmount Amount="{refund_amount}" CurrencyCode="{currency_code}">
            <Description>Refund amount after cancellation fees</Description>
        </RefundAmount>
        <RefundMethod>Original payment method</RefundMethod>
        <ProcessingTime>5-10 business days</ProcessingTime>
    </RefundInfo>
    <CancellationConfirmation>
        <ConfirmationNumber>{cancellation_confirmation}</ConfirmationNumber>
        <EmailSent>true</EmailSent>
    </CancellationConfirmation>
</OTA_CancelRS>
```

### JSON Response

```json
{
  "version": "2.001",
  "success": {},
  "uniqueID": {
    "type": "14",
    "id": "{record_locator}",
    "companyName": {
      "code": "{airline_code}"
    }
  },
  "cancellationStatus": {
    "status": "Confirmed",
    "dateTime": "{cancellation_datetime}",
    "text": "Booking successfully cancelled"
  },
  "refundInfo": {
    "refundAmount": {
      "amount": "{refund_amount}",
      "currencyCode": "{currency_code}",
      "description": "Refund amount after cancellation fees"
    },
    "refundMethod": "Original payment method",
    "processingTime": "5-10 business days"
  },
  "cancellationConfirmation": {
    "confirmationNumber": "{cancellation_confirmation}",
    "emailSent": true
  }
}
```

## Cancellation Email

Automatic email notifications are sent upon successful cancellation.

### Email Content Includes:
- Cancellation confirmation number
- Original booking details
- Cancelled flight information
- Refund information and timeline
- Contact information for questions

### Resend Cancellation Email

If the cancellation email needs to be resent:

```bash
POST https://{api-domain}/{service-name}/resend-cancellation-email
```

#### Request Body

```json
{
  "recordLocator": "{record_locator}",
  "emailAddress": "{recipient_email}",
  "cancellationConfirmation": "{cancellation_confirmation}"
}
```

#### Response

```json
{
  "success": true,
  "message": "Cancellation email resent successfully",
  "emailSentTo": "{recipient_email}",
  "sentDateTime": "{sent_datetime}"
}
```

## Partial Cancellations

### Cancel Specific Segments

For multi-segment bookings, cancel individual flights:

```xml
<OTA_CancelRQ>
    <UniqueID Type="14" ID="{record_locator}"/>
    <CancellationOverrides>
        <CancellationOverride Type="SegmentCancellation">
            <FlightSegment FlightNumber="{flight_number}" 
                          DepartureDateTime="{departure_datetime}">
                <DepartureAirport LocationCode="{origin_code}"/>
                <ArrivalAirport LocationCode="{destination_code}"/>
            </FlightSegment>
        </CancellationOverride>
    </CancellationOverrides>
</OTA_CancelRQ>
```

### Cancel Specific Passengers

Remove individual passengers from group bookings:

```xml
<OTA_CancelRQ>
    <UniqueID Type="14" ID="{record_locator}"/>
    <CancellationOverrides>
        <CancellationOverride Type="PassengerCancellation">
            <PassengerInfo>
                <PersonName>
                    <GivenName>{passenger_first_name}</GivenName>
                    <Surname>{passenger_last_name}</Surname>
                </PersonName>
                <TravelerRefNumber RPH="{passenger_reference}"/>
            </PassengerInfo>
        </CancellationOverride>
    </CancellationOverrides>
</OTA_CancelRQ>
```

## Automatic Refund Process

For eligible cancellations, refunds can be processed automatically:

### Segments Cancellation with Automatic Refund

```xml
<CancellationOverrides>
    <CancellationOverride Type="SegmentCancellationWithRefund">
        <FlightSegment FlightNumber="{flight_number}"/>
        <RefundOptions>
            <AutoRefund>true</AutoRefund>
            <RefundToOriginalPayment>true</RefundToOriginalPayment>
        </RefundOptions>
    </CancellationOverride>
</CancellationOverrides>
```

### Refund Processing

1. **Immediate**: Service fees and taxes
2. **3-5 Business Days**: Credit card refunds
3. **5-10 Business Days**: Bank transfer refunds
4. **Manual Processing**: Complex refund cases

## Error Responses

### Booking Not Found

```xml
<OTA_CancelRS>
    <Errors>
        <Error Code="BOOKING_NOT_FOUND" ShortText="Booking not found">
            No booking found with the provided record locator.
        </Error>
    </Errors>
</OTA_CancelRS>
```

### Cancellation Not Allowed

```json
{
  "errors": [
    {
      "code": "CANCELLATION_NOT_ALLOWED",
      "message": "This booking cannot be cancelled due to fare restrictions",
      "fareType": "Non-refundable"
    }
  ]
}
```

### Already Cancelled

```json
{
  "errors": [
    {
      "code": "ALREADY_CANCELLED",
      "message": "This booking has already been cancelled",
      "cancellationDate": "{original_cancellation_date}"
    }
  ]
}
```

### Too Late to Cancel

```xml
<OTA_CancelRS>
    <Errors>
        <Error Code="CANCELLATION_CUTOFF_PASSED" ShortText="Cancellation cutoff passed">
            Cancellation is not allowed within {hours} hours of departure.
        </Error>
    </Errors>
</OTA_CancelRS>
```