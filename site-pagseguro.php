<?php

use \Hcode\Page;
use \Hcode\Model\User;
use \Hcode\PagSeguro\Config;
use \GuzzleHttp\Client;


$app->get('/payment/pagseguro', function() {
	
	
    $client = new \GuzzleHttp\Client();
    $response = $client->request('POST', Config::getUrlSessions() . "?" . http_build_query(Config::getAuthentication()), ['verify'=>false]);
    

    echo $response->getBody()->getContents(); // '{"id": 1420053, "name": "guzzle", ...}'
    

   
});

?>