*** settings ***
Library  Collections
Library  requests
*** test cases ***
simpleRequest
    ${result} =  get  https://httpbin.org/get
    Should Be Equal  ${headers.Host}  ${"httpbin.org"}
    ${json} =  Set Variable  ${result.json()}
    ${framework} =  Get From Dictionary  ${json}  framework
    Should Be Equal  ${framework}  robot-framework
    ${api} =  Get From Dictionary  ${json}  api
    Should Be Equal  ${api}  rest
