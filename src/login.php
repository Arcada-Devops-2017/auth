<?php
include_once 'config/database.php';

$db = new Database();
//Create databses if not exist
$db->createDB();

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $postBody = file_get_contents("php://input");
    $postBody = json_decode($postBody);
    
    $username = $postBody->username;
    $password = hash('sha256',$postBody->password);

    if ($username != '' && $password != '') {
        
        if($db->checkLogin($username, $password)) {
            
            //Get userID
            $userID = $db->getUserID($username);
            
            //Add token
            $token = $db->addToken($userID);

            $response->status = "OK";
            $response->token = $token;
            echo json_encode($response);
            http_response_code(200);
            
        } else {
            $response->status = "INVALID_CREDENTIALS";
            echo json_encode($response);
            http_response_code(404);
        }
    } else {
        $response->status = "INVALID_CREDENTIALS";
        echo json_encode($response);
        http_response_code(404);
    }
} else {
    $response->status = "INVALID_CREDENTIALS";
    echo json_encode($response);
    http_response_code(404);
}
?>