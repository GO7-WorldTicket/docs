
# Update OTA endpoints to avoid passing "local-name" header and using path parameter instead

## Goals
- Read `./trees/ota-service` folder and finding OtaAirResource2015b`, then read and understand all its endpoints
- Update all endpoints to avoid passing "local-name" header and using path parameter instead
- Keep the existing functionality but supported only JSON format
