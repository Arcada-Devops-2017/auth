*** Settings ***
Library  Collections
Library  RequestsLibrary
*** Test cases ***
Register User Test
Create Session  httpbin  http://localhost:8000
    &{data}=  Create Dictionary  firstName=kalle
    log to console  ${data}
    &{headers} =  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  httpbin  /register.php  data=${data}  headers=${headers}
    log to console  ${resp.json()}
    ${firstName}=  Get From Dictionary  ${resp.json()}  FirstName
    log to console  ${firstName}
    Should Be Equal As Strings  ${firstName}  Niclas

Check Token Test
    Create Session  httpbin  http://auth.arcada.nitor.zone/userinfo.php
    &{data}=  Create Dictionary  token=66518bf3692f2bc197138b394f0af50e
    log to console  ${data}
    &{headers} =  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  httpbin  /  data=${data}  headers=${headers}
    log to console  ${resp.json()}
    ${firstName}=  Get From Dictionary  ${resp.json()}  FirstName
    log to console  ${firstName}
    Should Be Equal As Strings  ${firstName}  Niclas
    

