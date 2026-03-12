# Sales Channel Properties

## Find list of available properties by sales channel

#### Request
<pre>
<code class="language-bash">    URL: https://go7-gateway.dev.go7.io/graphql
    HTTP Method: POST
    Headers: - X-Tenant: {tenant}
             - X-SalesChannel: {sales channel}
</code>
</pre>

##### Lists all available properties by tenant and sales channel.

<details open>
  <summary><b>Request body</b></summary>

<h4>Request body</h4>
  <pre>
        query {
        getSalesChannelProperties {
            travelClassProperties {
                travelClass
            }
            paxTypeProperties {
                ageRange {
                    max
                    min
                }
                code
                description
                maxAllowedPerPnr
                name
                paxGroup
                canAccompanyChd
            }
            paxRulesProperties {
                applyAccompanyChdInfRule
                applyDontNeedUmnrFromAgeRule
                canAccompanyChdInfFromAge
                dontNeedUmnrFromAge
                maxPassengerPerReservation
                mixingPassengerTypesAllowed
                umnrMinAge
                umnrServiceProvided
            }
            languageProperties {
                isDefault
                locale
            }
            currencyProperties {
                code
                description
                fractionDigits
                isDefault
                lowestValue
            }
        }
    }
  </pre>
</details>


<details open>
  <summary><b>Response body</b></summary>
  <pre>
    {
    "data": {
        "getSalesChannelProperties": {
            "paxTypeProperties": [
                {
                    "code": "CHD",
                    "name": "Child",
                    "paxGroup": "CHILD",
                    "ageRange": {
                        "min": 2,
                        "max": 11
                    },
                    "maxAllowedPerPnr": 2,
                    "description": "2 - 11 years old",
                    "canAccompanyChd": false
                },
                {
                    "code": "ADT",
                    "name": "Adult",
                    "paxGroup": "ADULT",
                    "ageRange": {
                        "min": 12,
                        "max": 100
                    },
                    "maxAllowedPerPnr": 9,
                    "description": "16+ years old",
                    "canAccompanyChd": true
                },
                {
                    "code": "INF",
                    "name": "Infant",
                    "paxGroup": "INFANT",
                    "ageRange": {
                        "min": 0,
                        "max": 1
                    },
                    "maxAllowedPerPnr": 2,
                    "description": "Under 2 years old",
                    "canAccompanyChd": false
                }
            ],
            "currencyProperties": [
                {
                    "code": "USD",
                    "lowestValue": 0,
                    "fractionDigits": 2,
                    "description": null,
                    "isDefault": false
                },
                {
                    "code": "EUR",
                    "lowestValue": 0,
                    "fractionDigits": 2,
                    "description": null,
                    "isDefault": true
                },
                {
                    "code": "GBP",
                    "lowestValue": 0,
                    "fractionDigits": 2,
                    "description": null,
                    "isDefault": false
                }
            ],
            "languageProperties": [
                {
                    "locale": "en-US-x-lvariant-US",
                    "isDefault": true
                },
                {
                    "locale": "de-DE",
                    "isDefault": false
                }
            ],
            "travelClassProperties": [
                {
                    "travelClass": "PREMIUM_ECONOMY_CLASS"
                },
                {
                    "travelClass": "ECONOMY_CLASS"
                },
                {
                    "travelClass": "BUSINESS_CLASS"
                }
            ],
            "paxRulesProperties": {
                "maxPassengerPerReservation": 9,
                "umnrServiceProvided": true,
                "applyDontNeedUmnrFromAgeRule": false,
                "dontNeedUmnrFromAge": 14,
                "umnrMinAge": 5,
                "applyAccompanyChdInfRule": false,
                "canAccompanyChdInfFromAge": 16,
                "mixingPassengerTypesAllowed": false
            }
        }
    }
}
  </pre>
</details>