
*** Settings ***
Resource          resource.robot


Test Setup      Open Browser to application page
Test Teardown   Close Browser
*** Test Cases ***

Test string
    Check for PHP Version in content