
/*
*** Settings ***
Library     Selenium2Library

*** Variables ***
${SERVER}         http://localhost:8000
${dbname}         ${SERVER}/dbaccess.php.template



*** Keywords ***
Connect To Database
    [Arguments]         ${SERVER}
    Row Count           ${dbname} 
    
    */

