---
layout: default
title: Group Booking (AirPriceRQ)
---

# Create a Group Booking (AirPriceRQ)

When making a group booking, passenger names are not known yet. In AirPriceRQ, passenger type quantities (not individual names as in AirBookRQ) should be specified along with contact details and travel itinerary.

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://api.worldticket.net/ota/v2015b/OTA |
| Test | https://test-api.worldticket.net/ota/v2015b/OTA |

## HTTP Headers (All Required)

| Header | Description | Example |
|--------|-------------|---------|
| Authorization | Bearer token for JWT authentication | Bearer {access_token} |
| X-API-Key | API key for key-based authentication | {api_key} |
| Local-Name | OTA operation identifier | OTA_AirPriceRQ |
| Content-Type | Request content type | application/xml |

**Note:** Use either `Authorization` (for JWT) OR `X-API-Key` (for API key authentication), not both.

## Request Parameters

| Parameter | Location | Required | Description | Example |
|-----------|----------|----------|-------------|---------|
| base_url | Endpoint | Yes | Base URL for the request | https://test-api.worldticket.net/ota/v2015b/OTA |

## Request Format

### With JWT Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA \
    -H 'Authorization: Bearer {access_token}' \
    -H 'Local-Name: OTA_AirPriceRQ' \
    -H 'Content-Type: application/xml' \
    -d @AirPriceRQ.xml
```

### With API Key Authentication
```bash
curl -X POST \
    https://test-api.worldticket.net/ota/v2015b/OTA \
    -H 'X-API-Key: {api_key}' \
    -H 'Local-Name: OTA_AirPriceRQ' \
    -H 'Content-Type: application/xml' \
    -d @AirPriceRQ.xml
```

## AirPriceRQ for One-way Trip

### XML Request Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirPriceRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirItinerary>
        <OriginDestinationOptions>
            <OriginDestinationOption>
                <FlightSegment DepartureDateTime="{departure_datetime}" 
                              ArrivalDateTime="{arrival_datetime}"
                              FlightNumber="{flight_number}"
                              ResBookDesigCode="{booking_class}"
                              NumberInParty="{total_passengers}">
                    <DepartureAirport LocationCode="{origin_code}"/>
                    <ArrivalAirport LocationCode="{destination_code}"/>
                    <MarketingAirline Code="{airline_code}"/>
                </FlightSegment>
            </OriginDestinationOption>
        </OriginDestinationOptions>
    </AirItinerary>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
            <PassengerTypeQuantity Code="CHD" Quantity="{child_count}"/>
            <PassengerTypeQuantity Code="INF" Quantity="{infant_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
    <PriceRequestInformation>
        <TPA_Extensions>
            <GroupBooking GroupName="{group_name}">
                <ContactInfo>
                    <PersonName>
                        <GivenName>{contact_first_name}</GivenName>
                        <Surname>{contact_last_name}</Surname>
                    </PersonName>
                    <Telephone PhoneNumber="{contact_phone}"/>
                    <Email>{contact_email}</Email>
                </ContactInfo>
            </GroupBooking>
        </TPA_Extensions>
    </PriceRequestInformation>
</OTA_AirPriceRQ>
```

### JSON Request Example

```json
{
  "version": "2.001",
  "pos": {
    "source": [
      {
        "requestorID": {
          "type": "5",
          "id": "{agent_id}",
          "name": "{agency_id}"
        }
      }
    ]
  },
  "airItinerary": {
    "originDestinationOptions": {
      "originDestinationOption": [
        {
          "flightSegment": [
            {
              "departureDateTime": "{departure_datetime}",
              "arrivalDateTime": "{arrival_datetime}",
              "flightNumber": "{flight_number}",
              "resBookDesigCode": "{booking_class}",
              "numberInParty": "{total_passengers}",
              "departureAirport": {
                "locationCode": "{origin_code}"
              },
              "arrivalAirport": {
                "locationCode": "{destination_code}"
              },
              "marketingAirline": {
                "code": "{airline_code}"
              }
            }
          ]
        }
      ]
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": [
      {
        "passengerTypeQuantity": [
          {
            "code": "ADT",
            "quantity": "{adult_count}"
          },
          {
            "code": "CHD",
            "quantity": "{child_count}"
          },
          {
            "code": "INF",
            "quantity": "{infant_count}"
          }
        ]
      }
    ]
  },
  "priceRequestInformation": {
    "tpa_Extensions": {
      "groupBooking": {
        "groupName": "{group_name}",
        "contactInfo": {
          "personName": {
            "givenName": "{contact_first_name}",
            "surname": "{contact_last_name}"
          },
          "telephone": {
            "phoneNumber": "{contact_phone}"
          },
          "email": "{contact_email}"
        }
      }
    }
  }
}
```

## AirPriceRQ for Round Trip

### XML Request Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirPriceRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <AirItinerary>
        <OriginDestinationOptions>
            <!-- Outbound Flight -->
            <OriginDestinationOption>
                <FlightSegment DepartureDateTime="{outbound_departure_datetime}" 
                              ArrivalDateTime="{outbound_arrival_datetime}"
                              FlightNumber="{outbound_flight_number}"
                              ResBookDesigCode="{booking_class}"
                              NumberInParty="{total_passengers}">
                    <DepartureAirport LocationCode="{origin_code}"/>
                    <ArrivalAirport LocationCode="{destination_code}"/>
                    <MarketingAirline Code="{airline_code}"/>
                </FlightSegment>
            </OriginDestinationOption>
            <!-- Inbound Flight -->
            <OriginDestinationOption>
                <FlightSegment DepartureDateTime="{inbound_departure_datetime}" 
                              ArrivalDateTime="{inbound_arrival_datetime}"
                              FlightNumber="{inbound_flight_number}"
                              ResBookDesigCode="{booking_class}"
                              NumberInParty="{total_passengers}">
                    <DepartureAirport LocationCode="{destination_code}"/>
                    <ArrivalAirport LocationCode="{origin_code}"/>
                    <MarketingAirline Code="{airline_code}"/>
                </FlightSegment>
            </OriginDestinationOption>
        </OriginDestinationOptions>
    </AirItinerary>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
            <PassengerTypeQuantity Code="CHD" Quantity="{child_count}"/>
            <PassengerTypeQuantity Code="INF" Quantity="{infant_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
    <PriceRequestInformation>
        <TPA_Extensions>
            <GroupBooking GroupName="{group_name}">
                <ContactInfo>
                    <PersonName>
                        <GivenName>{contact_first_name}</GivenName>
                        <Surname>{contact_last_name}</Surname>
                    </PersonName>
                    <Telephone PhoneNumber="{contact_phone}"/>
                    <Email>{contact_email}</Email>
                </ContactInfo>
            </GroupBooking>
        </TPA_Extensions>
    </PriceRequestInformation>
</OTA_AirPriceRQ>
```

## Response Structure

AirPriceRS response contains a record locator in "quoteID" field.

### XML Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirPriceRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Success/>
    <PricedItinerary QuoteID="{quote_id}">
        <AirItinerary>
            <OriginDestinationOptions>
                <OriginDestinationOption>
                    <FlightSegment DepartureDateTime="{departure_datetime}" 
                                  ArrivalDateTime="{arrival_datetime}"
                                  FlightNumber="{flight_number}"
                                  ResBookDesigCode="{booking_class}">
                        <DepartureAirport LocationCode="{origin_code}"/>
                        <ArrivalAirport LocationCode="{destination_code}"/>
                        <MarketingAirline Code="{airline_code}"/>
                    </FlightSegment>
                </OriginDestinationOption>
            </OriginDestinationOptions>
        </AirItinerary>
        <AirItineraryPricingInfo>
            <ItinTotalFare>
                <BaseFare Amount="{base_fare}" CurrencyCode="{currency_code}"/>
                <Taxes>
                    <Tax Amount="{tax_amount}" CurrencyCode="{currency_code}"/>
                </Taxes>
                <TotalFare Amount="{total_fare}" CurrencyCode="{currency_code}"/>
            </ItinTotalFare>
            <PTC_FareBreakdowns>
                <PTC_FareBreakdown>
                    <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
                    <PassengerFare>
                        <BaseFare Amount="{adult_base_fare}" CurrencyCode="{currency_code}"/>
                        <Taxes>
                            <Tax Amount="{adult_tax}" CurrencyCode="{currency_code}"/>
                        </Taxes>
                        <TotalFare Amount="{adult_total_fare}" CurrencyCode="{currency_code}"/>
                    </PassengerFare>
                </PTC_FareBreakdown>
            </PTC_FareBreakdowns>
        </AirItineraryPricingInfo>
        <TicketingInfo TicketTimeLimit="{ticket_time_limit}"/>
    </PricedItinerary>
</OTA_AirPriceRS>
```

### JSON Response

```json
{
  "version": "2.001",
  "success": {},
  "pricedItinerary": {
    "quoteID": "{quote_id}",
    "airItinerary": {
      "originDestinationOptions": {
        "originDestinationOption": [
          {
            "flightSegment": [
              {
                "departureDateTime": "{departure_datetime}",
                "arrivalDateTime": "{arrival_datetime}",
                "flightNumber": "{flight_number}",
                "resBookDesigCode": "{booking_class}",
                "departureAirport": {
                  "locationCode": "{origin_code}"
                },
                "arrivalAirport": {
                  "locationCode": "{destination_code}"
                },
                "marketingAirline": {
                  "code": "{airline_code}"
                }
              }
            ]
          }
        ]
      }
    },
    "airItineraryPricingInfo": {
      "itinTotalFare": {
        "baseFare": {
          "amount": "{base_fare}",
          "currencyCode": "{currency_code}"
        },
        "taxes": [
          {
            "amount": "{tax_amount}",
            "currencyCode": "{currency_code}"
          }
        ],
        "totalFare": {
          "amount": "{total_fare}",
          "currencyCode": "{currency_code}"
        }
      },
      "ptc_FareBreakdowns": [
        {
          "passengerTypeQuantity": {
            "code": "ADT",
            "quantity": "{adult_count}"
          },
          "passengerFare": {
            "baseFare": {
              "amount": "{adult_base_fare}",
              "currencyCode": "{currency_code}"
            },
            "taxes": [
              {
                "amount": "{adult_tax}",
                "currencyCode": "{currency_code}"
              }
            ],
            "totalFare": {
              "amount": "{adult_total_fare}",
              "currencyCode": "{currency_code}"
            }
          }
        }
      ]
    },
    "ticketingInfo": {
      "ticketTimeLimit": "{ticket_time_limit}"
    }
  }
}
```

## Group Booking Completion Policy

Group bookings typically have specific policies for completion:

1. **Time Limits**: Group bookings must be completed within specified timeframes
2. **Passenger Lists**: Final passenger names must be provided before the deadline
3. **Payment Terms**: Special payment arrangements may apply for group bookings
4. **Cancellation Policies**: Different cancellation rules may apply compared to individual bookings

### Group Booking Workflow

1. **Initial Quote**: Create group booking with passenger quantities using AirPriceRQ
2. **Quote Response**: Receive quote ID and pricing information
3. **Name Collection**: Gather individual passenger names and details
4. **Final Booking**: Convert group quote to individual bookings with passenger names
5. **Payment**: Process payment according to group terms
6. **Ticketing**: Issue tickets within the specified time limit

