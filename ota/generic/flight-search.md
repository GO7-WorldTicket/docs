---
layout: default
title: Flight Search (Low Fare Search)
---

# Low Fare Search (AirLowFareSearchRQ)

The purpose is to list all the fares and display them to the user. AirLowFareSearch is used to get flight availability with the lowest fare options for the whole journey, or separately per direction (outbound or inbound).

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | https://{api-domain}/ota/v2015b/OTA |
| Test | https://{test-api-domain}/ota/v2015b/OTA |

## Request Parameters (All Required)

| Parameter | Description | Example |
|-----------|-------------|---------|
| base_url | Base URL | https://{test-api-domain}/ota/v2015b/OTA |
| access_token | Access Token | Bearer {access_token} or X-API-Key: {api_key} |
| local-name | Custom HTTP header | OTA_AirLowFareSearchRQ |

## Basic Request Format

```bash
curl -X POST \
    {base_url} \
    -H 'Authorization: Bearer {access_token}' \
    -H 'local-name: {local_name}' \
    -H 'Content-Type: application/xml' \
    -d @AirLowFareSearchRQ.xml
```

## AirLowFareSearchRQ for One-way Trip

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{departure_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <CabinPref Cabin="{cabin_preference}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
            <PassengerTypeQuantity Code="CHD" Quantity="{child_count}"/>
            <PassengerTypeQuantity Code="INF" Quantity="{infant_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
</OTA_AirLowFareSearchRQ>
```

### JSON Request

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
  "originDestinationInformation": [
    {
      "departureDateTime": "{departure_date}",
      "originLocation": {
        "locationCode": "{origin_code}"
      },
      "destinationLocation": {
        "locationCode": "{destination_code}"
      }
    }
  ],
  "travelPreferences": {
    "cabinPref": {
      "cabin": "{cabin_preference}"
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": {
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
  }
}
```

## AirLowFareSearchRQ for One-way Trip with Booking Class Preference

To receive outbound and inbound fares separately, specify FareRestriction "OUT" or "IN" before TravelerInfoSummary element.

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{departure_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <FareRestrictPref FareRestriction="OUT"/>
        <CabinPref Cabin="{cabin_preference}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
</OTA_AirLowFareSearchRQ>
```

## AirLowFareSearchRQ for Round Trip

### XML Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{outbound_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <OriginDestinationInformation>
        <DepartureDateTime>{inbound_date}</DepartureDateTime>
        <OriginLocation LocationCode="{destination_code}"/>
        <DestinationLocation LocationCode="{origin_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <CabinPref Cabin="{cabin_preference}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
            <PassengerTypeQuantity Code="CHD" Quantity="{child_count}"/>
            <PassengerTypeQuantity Code="INF" Quantity="{infant_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
</OTA_AirLowFareSearchRQ>
```

### JSON Request

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
  "originDestinationInformation": [
    {
      "departureDateTime": "{outbound_date}",
      "originLocation": {
        "locationCode": "{origin_code}"
      },
      "destinationLocation": {
        "locationCode": "{destination_code}"
      }
    },
    {
      "departureDateTime": "{inbound_date}",
      "originLocation": {
        "locationCode": "{destination_code}"
      },
      "destinationLocation": {
        "locationCode": "{origin_code}"
      }
    }
  ],
  "travelPreferences": {
    "cabinPref": {
      "cabin": "{cabin_preference}"
    }
  },
  "travelerInfoSummary": {
    "airTravelerAvail": {
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
  }
}
```

## AirLowFareSearchRQ for Round Trip with Booking Class Preference

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{outbound_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <OriginDestinationInformation>
        <DepartureDateTime>{inbound_date}</DepartureDateTime>
        <OriginLocation LocationCode="{destination_code}"/>
        <DestinationLocation LocationCode="{origin_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <FareRestrictPref FareRestriction="OUT"/>
        <CabinPref Cabin="{cabin_preference}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
        </AirTravelerAvail>
    </TravelerInfoSummary>
</OTA_AirLowFareSearchRQ>
```

## Response Structure

### XML Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRS xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <Success/>
    <PricedItineraries>
        <PricedItinerary SequenceNumber="1">
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
                        <FareBasisCodes>
                            <FareBasisCode>{fare_basis_code}</FareBasisCode>
                        </FareBasisCodes>
                        <PassengerFare>
                            <BaseFare Amount="{passenger_base_fare}" CurrencyCode="{currency_code}"/>
                            <Taxes>
                                <Tax Amount="{passenger_tax}" CurrencyCode="{currency_code}"/>
                            </Taxes>
                            <TotalFare Amount="{passenger_total_fare}" CurrencyCode="{currency_code}"/>
                        </PassengerFare>
                    </PTC_FareBreakdown>
                </PTC_FareBreakdowns>
            </AirItineraryPricingInfo>
        </PricedItinerary>
    </PricedItineraries>
</OTA_AirLowFareSearchRS>
```

### JSON Response

```json
{
  "version": "2.001",
  "success": {},
  "pricedItineraries": [
    {
      "sequenceNumber": "1",
      "airItinerary": {
        "originDestinationOptions": [
          {
            "flightSegments": [
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
            "fareBasisCodes": [
              "{fare_basis_code}"
            ],
            "passengerFare": {
              "baseFare": {
                "amount": "{passenger_base_fare}",
                "currencyCode": "{currency_code}"
              },
              "taxes": [
                {
                  "amount": "{passenger_tax}",
                  "currencyCode": "{currency_code}"
                }
              ],
              "totalFare": {
                "amount": "{passenger_total_fare}",
                "currencyCode": "{currency_code}"
              }
            }
          }
        ]
      }
    }
  ]
}
```

## Discount Functionality

LowFareSearch supports discount functionality. When a discount is applied, the response will include both discounted amount and original fare amount.

### Request with Discount (XML)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<OTA_AirLowFareSearchRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="2.001">
    <POS>
        <Source>
            <RequestorID Type="5" ID="{agent_id}" ID_Context="{agency_id}"/>
        </Source>
    </POS>
    <OriginDestinationInformation>
        <DepartureDateTime>{departure_date}</DepartureDateTime>
        <OriginLocation LocationCode="{origin_code}"/>
        <DestinationLocation LocationCode="{destination_code}"/>
    </OriginDestinationInformation>
    <TravelPreferences>
        <CabinPref Cabin="{cabin_preference}"/>
    </TravelPreferences>
    <TravelerInfoSummary>
        <AirTravelerAvail>
            <PassengerTypeQuantity Code="ADT" Quantity="{adult_count}"/>
        </AirTravelerAvail>
        <PriceRequestInformation>
            <TPA_Extensions>
                <DiscountPricing DiscountCode="{discount_code}" DiscountPercent="{discount_percent}"/>
            </TPA_Extensions>
        </PriceRequestInformation>
    </TravelerInfoSummary>
</OTA_AirLowFareSearchRQ>
```

### Response with Discount (XML)

```xml
<PricedItinerary SequenceNumber="1">
    <AirItineraryPricingInfo>
        <ItinTotalFare>
            <BaseFare Amount="{discounted_base_fare}" CurrencyCode="{currency_code}"/>
            <TotalFare Amount="{discounted_total_fare}" CurrencyCode="{currency_code}"/>
        </ItinTotalFare>
        <ItinTotalFareOriginal>
            <BaseFare Amount="{original_base_fare}" CurrencyCode="{currency_code}"/>
            <TotalFare Amount="{original_total_fare}" CurrencyCode="{currency_code}"/>
        </ItinTotalFareOriginal>
    </AirItineraryPricingInfo>
</PricedItinerary>
```

## Low Fare Search Error Messages

### No Flights Available

```xml
<OTA_AirLowFareSearchRS>
    <Errors>
        <Error Code="NO_FLIGHTS" ShortText="No flights available">
            No flights available for the requested criteria.
        </Error>
    </Errors>
</OTA_AirLowFareSearchRS>
```

### Invalid Date Range

```json
{
  "errors": [
    {
      "code": "INVALID_DATE",
      "message": "Departure date must be in the future",
      "field": "departureDateTime"
    }
  ]
}
```

### Sold Out Segments

When flights are sold out, they may still appear in search results with appropriate indicators:

```xml
<FlightSegment DepartureDateTime="{departure_datetime}" 
               ArrivalDateTime="{arrival_datetime}"
               FlightNumber="{flight_number}"
               ResBookDesigCode="{booking_class}"
               Status="SoldOut">
    <DepartureAirport LocationCode="{origin_code}"/>
    <ArrivalAirport LocationCode="{destination_code}"/>
    <MarketingAirline Code="{airline_code}"/>
    <TPA_Extensions>
        <SoldOutIndicator>true</SoldOutIndicator>
    </TPA_Extensions>
</FlightSegment>
```