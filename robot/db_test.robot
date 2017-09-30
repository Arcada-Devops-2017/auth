**Settings** 
Library  DatabaseLibrary
**Testcases**
TestCase

   Connect To Database Using Custom Params  pymssql  'auth', 'travis', '', 'localhost'
   @{S}  Execute Sql String  CREATE TABLE `UsersTest` (
    `ID` int(10) NOT NULL AUTO_INCREMENT,
    `Username` varchar(256) NOT NULL,
    `FirstName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LastName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `Password` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
