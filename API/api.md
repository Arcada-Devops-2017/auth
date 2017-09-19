# Authentication API


This document describes the REST endpoints provided by the authentication component



## Login

Url: `/login`

### Request

```
{
    "username": "user",
    "password": "password"
}
```

### Responses


#### All good

HTTP Status code: `200`
```
{
    "status": "OK",
    "token": "<token>"
}
```

#### Invalid credentials

HTTP Status code: `404`
```
{
    "status": "INVALID_CREDENTIALS"
}
```
