*** Settings ***
Library     Selenium2Library

*** Variables ***
${URL}          localhost:8080

*** Keywords ***
Open Browser to application page
    Open Browser   ${URL}

Check for Hello World! in content
    Page Should Contain   Hello  