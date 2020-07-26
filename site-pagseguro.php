<?php

use \Hcode\Page;
use \Hcode\Model\User;
use \Hcode\Model\Order;
use \Hcode\PagSeguro\Transporter;
use \Hcode\PagSeguro\Config;

$app->get('/payment', function(){
    
    User::verifyLogin(false);

    $order = new Order();

    $order->getFromSession();

    $years = [];

    for ($y = date('Y'); $y < date('Y')+14; $y++)
    {

        array_push($years, $y);
    }
    
    $page = new Page();

    $page->setTpl("payment", [
        'order'=>$order->getValues(),
        'msgError'=>Order::getError(),
        'years'=>$years,
        'pagseguro'=>[
            'urlJS'=>Config::getUrlJS(),
            'id'=>Transporter::createSession()
        ]
    ]);

});




?>