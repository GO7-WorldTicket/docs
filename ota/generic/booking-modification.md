---
layout: default
title: Booking Modification
---

# Modify Booking (AirBookModifyRQ)

The purpose is to modify existing bookings. Supported modifications include name changes, date changes, adding SSR, and cancelling segments or passengers.

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://{api-domain}/ota/v2015b/OTA |
| Test | https://{test-api-domain}/ota/v2015b/OTA |

## Request Parameters

| Parameter | Description | Example |
|-----------|-------------|----------|
| base_url | Base URL | https://{test-api-domain}/ota/v2015b/OTA |
| access_token | Access Token | Bearer {access_token} |
| local-name | Custom HTTP header | OTA_AirBookModifyRQ |

## Add SSR

Add Special Service Requests to an existing booking.

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <TravelerInfo>
            <AirTraveler>
                <TravelerRefNumber RPH="1"/>
                <SpecialServiceRequests>
                    <SpecialServiceRequest SSRCode="MEAL" ServiceQuantity="1" Status="Requested">
                        <Text>Vegetarian meal</Text>
                        <FlightRefNumber RPH="1"/>
                    </SpecialServiceRequest>
                    <SpecialServiceRequest SSRCode="SEAT" ServiceQuantity="1" Status="Requested">
                        <Text>Window seat preference</Text>
                        <FlightRefNumber RPH="1"/>
                    </SpecialServiceRequest>
                </SpecialServiceRequests>
            </AirTraveler>
        </TravelerInfo>
    </AirReservation>
</OTA_AirBookModifyRQ>
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
  "airReservation": {
    "bookingReferenceID": {
      "id": "{record_locator}",
      "type": "14",
      "companyName": {
        "code": "{airline_code}"
      }
    },
    "travelerInfo": [{
      "airTraveler": {
        "travelerRefNumber": {
          "rph": "1"
        },
        "specialServiceRequests": [
          {
            "ssrCode": "MEAL",
            "serviceQuantity": "1",
            "status": "Requested",
            "text": "Vegetarian meal",
            "flightRefNumber": {
              "rph": "1"
            }
          },
          {
            "ssrCode": "SEAT",
            "serviceQuantity": "1", 
            "status": "Requested",
            "text": "Window seat preference",
            "flightRefNumber": {
              "rph": "1"
            }
          }
        ]
      }
    }]
  }
}
```

## Change Name

Modify passenger name in existing booking.

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <TravelerInfo>
            <AirTraveler>
                <PersonName>
                    <GivenName>{new_first_name}</GivenName>
                    <Surname>{new_last_name}</Surname>
                </PersonName>
                <TravelerRefNumber RPH="1"/>
            </AirTraveler>
        </TravelerInfo>
    </AirReservation>
</OTA_AirBookModifyRQ>
```

## Change Date

### Request to Display Price Difference

First, get the price difference between old and new segments:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001" RepriceRequired="true">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <AirItinerary>
            <OriginDestinationOptions>
                <OriginDestinationOption>
                    <FlightSegment DepartureDateTime="{new_departure_datetime}" 
                                  ArrivalDateTime="{new_arrival_datetime}"
                                  FlightNumber="{new_flight_number}"
                                  ResBookDesigCode="{booking_class}">
                        <DepartureAirport LocationCode="{origin_code}"/>
                        <ArrivalAirport LocationCode="{destination_code}"/>
                        <MarketingAirline Code="{airline_code}"/>
                    </FlightSegment>
                </OriginDestinationOption>
            </OriginDestinationOptions>
        </AirItinerary>
    </AirReservation>
</OTA_AirBookModifyRQ>
```

### Response with Price Difference

```xml
<OTA_AirBookModifyRS>
    <Success/>
    <AirReservation>
        <PriceInfo>
            <ItinTotalFare>
                <TotalFare Amount="{new_total_fare}" CurrencyCode="{currency_code}"/>
            </ItinTotalFare>
            <PriceDifference>
                <Amount Amount="{price_difference}" CurrencyCode="{currency_code}"/>
                <Description>Additional charge for date change</Description>
            </PriceDifference>
        </PriceInfo>
    </AirReservation>
</OTA_AirBookModifyRS>
```

### Confirm Date Change

After reviewing price difference, confirm the change:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001" RepriceRequired="false">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <AirItinerary>
            <OriginDestinationOptions>
                <OriginDestinationOption>
                    <FlightSegment DepartureDateTime="{new_departure_datetime}" 
                                  ArrivalDateTime="{new_arrival_datetime}"
                                  FlightNumber="{new_flight_number}"
                                  ResBookDesigCode="{booking_class}">
                        <DepartureAirport LocationCode="{origin_code}"/>
                        <ArrivalAirport LocationCode="{destination_code}"/>
                        <MarketingAirline Code="{airline_code}"/>
                    </FlightSegment>
                </OriginDestinationOption>
            </OriginDestinationOptions>
        </AirItinerary>
        <PaymentInfo PaymentType="5">
            <PaymentCard CardType="VI" CardNumber="{card_number}" ExpireDate="{expiry_date}">
                <CardHolderName>{cardholder_name}</CardHolderName>
            </PaymentCard>
        </PaymentInfo>
    </AirReservation>
</OTA_AirBookModifyRQ>
```

## Cancel Specific Segment

Cancel individual flight segments from a multi-segment booking.

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <AirItinerary>
            <OriginDestinationOptions>
                <OriginDestinationOption>
                    <FlightSegment DepartureDateTime="{departure_datetime}" 
                                  FlightNumber="{flight_number}"
                                  Status="Cancel">
                        <DepartureAirport LocationCode="{origin_code}"/>
                        <ArrivalAirport LocationCode="{destination_code}"/>
                        <MarketingAirline Code="{airline_code}"/>
                    </FlightSegment>
                </OriginDestinationOption>
            </OriginDestinationOptions>
        </AirItinerary>
        <CancellationInfo>
            <CancellationReason>Passenger request</CancellationReason>
        </CancellationInfo>
    </AirReservation>
</OTA_AirBookModifyRQ>
```

## Cancel Specific Passenger

Remove individual passengers from booking.

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <TravelerInfo>
            <AirTraveler Status="Cancel">
                <PersonName>
                    <GivenName>{first_name}</GivenName>
                    <Surname>{last_name}</Surname>
                </PersonName>
                <TravelerRefNumber RPH="2"/>
            </AirTraveler>
        </TravelerInfo>
        <CancellationInfo>
            <CancellationReason>Passenger unable to travel</CancellationReason>
        </CancellationInfo>
    </AirReservation>
</OTA_AirBookModifyRQ>
```

## Modification Response

### Successful Modification

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirBookModifyRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Success/>
    <AirReservation>
        <BookingReferenceID ID="{record_locator}" Type="14">
            <CompanyName Code="{airline_code}"/>
        </BookingReferenceID>
        <ModificationSummary>
            <ModifiedItems>
                <ModifiedItem Type="SSR" Status="Added">
                    <Description>Special meal request added</Description>
                </ModifiedItem>
                <ModifiedItem Type="Name" Status="Changed">
                    <Description>Passenger name updated</Description>
                </ModifiedItem>
            </ModifiedItems>
        </ModificationSummary>
        <PriceInfo>
            <ItinTotalFare>
                <TotalFare Amount="{updated_total_fare}" CurrencyCode="{currency_code}"/>
            </ItinTotalFare>
            <ServiceFees>
                <ServiceFee Type="NameChange" Amount="{name_change_fee}" CurrencyCode="{currency_code}"/>
                <ServiceFee Type="DateChange" Amount="{date_change_fee}" CurrencyCode="{currency_code}"/>
            </ServiceFees>
        </PriceInfo>
        <TicketingInfo TicketTimeLimit="{updated_time_limit}"/>
    </AirReservation>
</OTA_AirBookModifyRS>
```

### JSON Response

```json
{
  "version": "2.001",
  "success": {},
  "airReservation": {
    "bookingReferenceID": {
      "id": "{record_locator}",
      "type": "14",
      "companyName": {
        "code": "{airline_code}"
      }
    },
    "modificationSummary": {
      "modifiedItems": [
        {
          "type": "SSR",
          "status": "Added",
          "description": "Special meal request added"
        },
        {
          "type": "Name",
          "status": "Changed",
          "description": "Passenger name updated"
        }
      ]
    },
    "priceInfo": {
      "itinTotalFare": {
        "totalFare": {
          "amount": "{updated_total_fare}",
          "currencyCode": "{currency_code}"
        }
      },
      "serviceFees": [
        {
          "type": "NameChange",
          "amount": "{name_change_fee}",
          "currencyCode": "{currency_code}"
        }
      ]
    },
    "ticketingInfo": {
      "ticketTimeLimit": "{updated_time_limit}"
    }
  }
}
```

## Modification Policies

### Name Change Policy
- Minor spelling corrections usually allowed
- Complete name changes may require documentation
- Fees may apply based on fare rules

### Date Change Policy  
- Subject to seat availability on new flight
- Price difference may apply
- Change fees based on fare conditions
- Some fares may not allow changes

### SSR Policy
- Most SSRs can be added post-booking
- Some services may have availability limitations
- Additional fees may apply for premium services

## Error Responses

### Modification Not Allowed

```xml
<OTA_AirBookModifyRS>
    <Errors>
        <Error Code="MODIFICATION_NOT_ALLOWED" ShortText="Modification not allowed">
            The selected fare does not allow modifications.
        </Error>
    </Errors>
</OTA_AirBookModifyRS>
```

### Flight Not Available

```json
{
  "errors": [
    {
      "code": "FLIGHT_NOT_AVAILABLE",
      "message": "The requested flight is not available for the selected date",
      "flightNumber": "{flight_number}"
    }
  ]
}
```