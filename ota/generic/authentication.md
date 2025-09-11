---
layout: default
title: Authentication
---

# Authentication

This section provides the procedures necessary for authorized access to the OTA API. There are two authentication types supported:

- [JWT Authentication](#jwt-authentication)
- [API Key Authentication](#api-key-authentication)

## JWT Authentication

|                   | Production                    | Test                          |
| ----------------- | ----------------------------- | ----------------------------- |
| Identity Provider | https://{auth-domain}/auth    | https://{test-auth-domain}/auth |

Before calling any OTA method, it's mandatory to get access and refresh tokens from the Identity Provider.

### Authentication Variables

Replace all variables in curly braces with the actual values provided by your airline integration.

| Variable      | Description                         | Example                        |
| ------------- | ----------------------------------- | ------------------------------ |
| base_url      | Identity provider URL               | https://{test-auth-domain}/auth |
| tenant        | Short airline name (realm)          | {tenant-name}                  |
| client_id     | Application ID                      | {client-id}                    |
| client_secret | Application secret                  | {client-secret}                |
| username      | User login                          | {username}                     |
| password      | User password                       | {password}                     |

### JWT Token Request

#### Request

```bash
curl -X POST \
    {base_url}/realms/{tenant}/protocol/openid-connect/token \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d 'grant_type=password&client_id={client_id}&client_secret={client_secret}&username={username}&password={password}'
```

#### Response

```json
{
  "access_token": "eyJhbGciOiJSU...",
  "expires_in": 7200,
  "refresh_expires_in": 14400,
  "refresh_token": "eyJhbGciOiJ...",
  "token_type": "bearer",
  "id_token": "eyJhbGciOiJ...",
  "not-before-policy": 1565113348,
  "session_state": "89fde8f3-39ff-436e-9dce-99387c591fda"
}
```

### Using JWT Token

In the response, you will get `access_token` and `refresh_token` to be sent along with any further requests as HTTP headers `Authorization` and `X-Refresh-Token` correspondingly.

#### Example OTA Request with JWT

```bash
curl -X POST \
    {base_url}/ota/v2015b/OTA \
    -H 'Authorization: Bearer {access_token}' \
    -H 'X-Refresh-Token: {refresh_token}' \
    -H 'Content-Type: application/xml' \
    -H 'local-name: OTA_AirLowFareSearchRQ' \
    -d @request.xml
```

## API Key Authentication

The API key should be attached to the HTTP request as `X-API-Key` HTTP header.

⚠️ **Security Warning**: Never deploy your key in client-side applications like browsers or mobile apps as it allows malicious users to take that key and make requests on your behalf.

### API Key Format

| API KEY                        |
| ------------------------------ |
| {your-api-key}                 |

### API Key Request Example

```bash
curl -X POST \
    {base_url}/ota/v2015b/OTA \
    -H 'X-API-Key: {api_key}' \
    -H 'Content-Type: application/xml' \
    -H 'local-name: OTA_AirLowFareSearchRQ' \
    -d @request.xml
```

## HTTP Headers

When using OTA API, the following headers are required:

### JSON Format
```
Content-Type: application/json
local-name: {ota-method}
```

Example: `local-name: OTA_AirLowFareSearchRQ`

### XML Format
```
Content-Type: application/xml
```

## Credential Provisioning

- **JWT Credentials**: To be provided by the airline upon request to Customer Support
- **API Key**: To be provided by the airline upon request to Customer Support

## Authentication Best Practices

1. **Token Refresh**: JWT tokens have limited lifetime (typically 2 hours). Implement token refresh logic using the `refresh_token`.
2. **Secure Storage**: Store credentials securely and never expose them in client-side code.
3. **Error Handling**: Implement proper error handling for authentication failures (401 Unauthorized).
4. **Token Validation**: Validate token expiration before making API calls to avoid unnecessary 401 errors.

## Common Authentication Errors

| Error Code | Description | Solution |
|------------|-------------|----------|
| 401 | Unauthorized - Invalid or expired token | Refresh token or re-authenticate |
| 403 | Forbidden - Valid token but insufficient permissions | Check API access permissions |
| 400 | Bad Request - Invalid authentication format | Verify header format and values |