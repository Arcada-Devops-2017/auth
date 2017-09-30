
*** Settings ***
Suite Setup       Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database
Library           DatabaseLibrary
Library           OperatingSystem

*** Variables ***
${DBHost}         127.0.0.1
${DBName}         travis
${DBPass}         ""
${DBPort}         3306
${DBUser}         travis

*** Test Cases ***
Create Users table
    ${output} =    Execute SQL String    CREATE TABLE `UsersTest` (
    `ID` int(10) NOT NULL AUTO_INCREMENT,
    `Username` varchar(256) NOT NULL,
    `FirstName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LastName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `Password` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
    
    Log    ${output}
    Should Be Equal As Strings    ${output}    None
    
Execute SQL Script - Insert User
Comment    ${output} =    Execute SQL Script    ./${DBName}_createUser.sql
${output} =    Execute SQL Script    ./auth_createUser.sql
Log    ${output}
Should Be Equal As Strings    ${output}    None
