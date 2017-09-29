*** Settings ***
Library           Selenium2Library
Resource          resource.robot
Suite Setup       Connect To Database    ${dbname}

*** Test Cases ***

Count rows
    Row Count         select * from ${dbname}
