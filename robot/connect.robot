*** Settings ***
Library           Selenium2Library
Resource          resource.robot
Suite Setup       ${dbname}

*** Test Cases ***

Connect
    Connect To Database    ${dbname}
