*** Settings ***
Library  Collections
Library  RequestsLibrary
*** Test cases ***
Simple Test
    Create Session  google  http://www.google.com
    ${resp}=  Get Request  google  /
    Should Be Equal As Strings  ${resp.status_code}  200
    
Post Requests
    Create Session  httpbin  http://auth.arcada.nitor.zone/userinfo.php
    &{data}=  Create Dictionary  token=66518bf3692f2bc197138b394f0af50e
    &{headers}=  Create Dictionary  Content-Type: application/json
    ${resp}=  Post Request  httpbin  /  data=${data}  headers=${headers}
    Dictionary Should Contain Value  ${resp.json()['FirstName']}  Niclas
    

