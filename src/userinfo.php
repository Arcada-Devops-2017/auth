<?php
include_once 'config/database.php';
header("Access-Control-Allow-Origin: *");


$db = new Database();
//Create databses if not exist
$db->createDB();

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $postBody = file_get_contents("php://input");
    $postBody = json_decode($postBody);
    
    $token = $postBody->token;        
        
    if($db->checkToken($token)) {
        $userID = $db->getUserIDTokens($token);

        $response = $db->getUserInfo($userID);
        
        echo json_encode($response);
        
        http_response_code(200);
    } else {
        $response->status = "INVALID_CREDENTIALS";
        echo json_encode($response);
        http_response_code(404);
    }
        
}
/*else {
    $response->status = "INVALID_CREDENTIALS";
    echo json_encode($response);
    http_response_code(404);
}*/
?>
