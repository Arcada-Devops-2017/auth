*** Settings ***
Library  Collections
Library  requests
*** Test cases ***
simpleRequest
    ${result} =  get  http://echo.jsontest.com/framework/robot-framework/api/rest
    Should Be Equal  ${result.status_code}  ${200}
    ${json} =  Set Variable  ${result.json()}
    ${framework} =  Get From Dictionary  ${json}  framework
    Should Be Equal  ${framework}  robot-framework
    ${api} =  Get From Dictionary  ${json}  api
    Should Be Equal  ${api}  rest

Post Requests
    Create Session  httpbin  http://auth.arcada.nitor.zone/userinfo.php
    &{data}=  Create Dictionary  token=66518bf3692f2bc197138b394f0af50e
    &{headers}=  Create Dictionary  Content-Type=application/x-www-form-urlencoded
    ${resp}=  Post Request  httpbin  /post  data=${data}  headers=${headers}
    Dictionary Should Contain Value  ${resp.json()['FirstName']}  Niclas
    
