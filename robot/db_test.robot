*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  requests
*** Test cases ***
Simple Test
    Create Session  google  http://www.google.com
    Create Session  github  https://api.github.com
    ${resp}=  Get Request  google  /
    Should Be Equal As Strings  ${resp.status_code}  200
    ${resp}=  Get Request  github  /users/bulkan
    Should Be Equal As Strings  ${resp.status_code}  200
    Dictionary Should Contain Value  ${resp.json()}  Bulkan Evcimen

Post Requests
    Create Session  httpbin  http://auth.arcada.nitor.zone/userinfo.php
    &{data}=  Create Dictionary  token=66518bf3692f2bc197138b394f0af50e
    &{headers}=  Create Dictionary  Content-Type=application/x-www-form-urlencoded
    ${resp}=  Post Request  httpbin  /post  data=${data}  headers=${headers}
    Dictionary Should Contain Value  ${resp.json()[FirstName]}  Niclas
    
