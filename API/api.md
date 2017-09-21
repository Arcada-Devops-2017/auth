# Authentication API


This document describes the REST endpoints provided by the authentication component



## Login

Url: `/login.php`



### Request for login

```
{
    "username": "email",
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

## Register

Url: `/register.php`

### Request for reqister

```
{   
    "first_name" : "firstname"
    "last_name" : "lastname"
    "username": "email",
    "password": "password"
}
```

### Responses


#### All good

HTTP Status code: `200`
```
{
    "status": "Registered",
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

## Get user info

Url: `/userinfo.php`



### Request for user info

```
{
    "token": "token"
}
```

### Responses


#### All good

HTTP Status code: `200`
```
{
    "status": "OK",
    "first_name : "firstname",
    "lastname" : "lastname",
    "username" : "email"
}
```

#### Invalid credentials

HTTP Status code: `404`
```
{
    "status": "INVALID_CREDENTIALS"
}
```
