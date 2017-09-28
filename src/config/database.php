<?php
class database
{
 
    private $pdo;
    
    public function __construct() {

        include_once 'dbaccess.php';
                
        $pdo = new PDO('mysql:host='.$host.';dbname='.$dbname.';charset=utf8', $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->pdo = $pdo;
    }

    public function query($query, $params = array()) {
        $statement = $this->pdo->prepare($query);
        $statement->execute($params);

        if (explode(' ', $query)[0] == 'SELECT') {
        $data = $statement->fetchAll();
        return $data;
        }
    }

    public function createDB() {    
        $statement = $this->pdo->prepare("CREATE TABLE IF NOT EXISTS `Users` (
            `ID` int(10) NOT NULL AUTO_INCREMENT,
            `Username` varchar(256) NOT NULL,
            `FirstName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
            `LastName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
            `Password` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
            PRIMARY KEY (`ID`)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1");
        $statement->execute();
        
        $statement2 = $this->pdo->prepare("CREATE TABLE IF NOT EXISTS `Tokens` (
            `ID` int(10) NOT NULL AUTO_INCREMENT,
            `UserID` int(10) NOT NULL,
            `Token` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
            PRIMARY KEY (`ID`)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1");
        $statement2->execute();
    }

    public function checkIfUserAlreadyExists($username) {
        $statement = $this->pdo->prepare("SELECT * FROM Users WHERE Username = :username");
        $statement->bindValue('username', $username);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        if(isset($result['Username'])) {
            return true;
        } else {
            return false;
        }                
    }

    public function addUser($username, $first_name, $last_name, $password) {
        $statement = $this->pdo->prepare("INSERT INTO Users (Username, FirstName, LastName, Password) VALUES (:username, :first_name, :last_name, :password)");
        $statement->execute(array('username' => $username, 'first_name' => $first_name, 'last_name' => $last_name, 'password' => $password));
    }

    public function getUserID($username) {
        $statement = $this->pdo->prepare("SELECT ID FROM Users WHERE Username = :username");
        $statement->bindValue('username', $username);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if(isset($result['ID'])) {
            return $result['ID'];
        }
    }

    public function addToken($userID) {
        $token = md5(uniqid(rand(), true));

        $statement = $this->pdo->prepare("INSERT INTO Tokens (UserID, Token) VALUES (:userID, :token)");
        $statement->execute(array('userID' => $userID, 'token' => $token));

        if ($statement) {
            return $token;
        }
    }

    public function checkLogin($username, $password) {           
        $statement = $this->pdo->prepare("SELECT * FROM Users WHERE Username = :username AND Password = :password");
        $statement->execute(array('username' => $username, 'password' => $password));

        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if(!empty($result)) {
            return true;
        } else {
            return false;
        }
    }
    
    public function checkToken($token) {           
        $statement = $this->pdo->prepare("SELECT Token FROM Tokens WHERE Token = :token");
        $statement->bindValue('token', $token);
        $statement->execute();

        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if(!empty($result)) {
            return true;
        } else {
            return false;
        }
    }
    
    public function getUserIDTokens($token) {
        $statement = $this->pdo->prepare("SELECT UserID FROM Tokens WHERE Token = :token");
        $statement->bindValue('token', $token);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if(isset($result['UserID'])) {
            return $result['UserID'];
        }
    }

    public function getUserInfo($userID) {           
        $statement = $this->pdo->prepare("SELECT FirstName, LastName, Username FROM Users WHERE ID = :userid");
        $statement->bindValue('userid', $userID);
        $statement->execute();

        $result = $statement->fetch(PDO::FETCH_ASSOC);
        if(!empty($result)) {            
            return $result;
        }
    }
}
?>
