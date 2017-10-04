*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  Selenium2Library
*** Test cases ***
Register User Test
    Create Session  httpbin  http://localhost:8000/register.php
    &{data}=  Create Dictionary  first_name=kalle  last_name=testguy  username=email@email.com  password=123
    log to console  ${data}
    &{headers} =  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  httpbin  /  data=${data}  headers=${headers}
    log to console  ${resp.content}
    ${json}=  To Json   ${resp.content}
    log to console  ${json}
    ${status}=  Get From Dictionary  ${json}  status
    log to console  ${status}
    Should Be Equal As Strings  ${status}  Registered
    
Register test 2
    Create Session  api  http://localhost:8000
    ${response}=  Post Request  api  /register.php
    ${jsondata}=  To Json  ${response.content}
    ${keys}=  Create List  first_name=kalle  last_name=testguy  username=email@email.com  password=123
    ${checkKeys}=  Get Dictionary Keys  ${jsondata['status'][0]}
    log to console  ${checkKeys}
    Should Be Equal As Strings  ${response.status}  200
    Lists Should Be Equal  ${checkKeys}  ${keys}

Check Token Test
    Create Session  httpbin  http://auth.arcada.nitor.zone/userinfo.php 
    &{data}=  Create Dictionary  token=66518bf3692f2bc197138b394f0af50e
    log to console  ${data}
    &{headers} =  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  httpbin  /  data=${data}  headers=${headers}
    log to console  ${resp.json()}
    ${firstName}=  Get From Dictionary  ${resp.json()}  first_name
    log to console  ${firstName}
    Should Be Equal As Strings  ${firstName}  Niclas
    
Check Login Test
    Create Session  httpbin  http://auth.arcada.nitor.zone/login.php
    &{data}=  Create Dictionary  username=nicke  password=passwd
    log to console  ${data}
    &{headers} =  Create Dictionary  Content-Type=application/json
    ${resp}=  Post Request  httpbin  /  data=${data}  headers=${headers}
    log to console  ${resp.json()}
    ${status}=  Get From Dictionary  ${resp.json()}  status
    log to console  ${status}
    Should Be Equal As Strings  ${status}  OK
    

