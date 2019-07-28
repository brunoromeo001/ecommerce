<?php

use \Hcode\PageAdmin;
use \Hcode\Model\User;
use \Hcode\Model\Product;
use \Hcode\Model\Order;

$app->get('/admin/', function() {
	
	User::verifyLogin();    
    
	$lastProducts	= Product::lastProductsAdd();
	$lastOrders		= Order::lastOrdersAdd();
	$usersCount		= User::usersCount();
	$usersCountAdm 	= User::usersCountAdm();
	
	$page = new PageAdmin();	
	
	$page->setTpl("index", [		
		'usersCount'=>$usersCount,
		'usersCountAdm'=>$usersCountAdm,
		'lastOrders'=>$lastOrders,
		'lastProducts'=>$lastProducts
	]);	

});
$app->get("/admin/login", function() {
    
	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
	
	$page->setTpl("login", [
		"error"=>User::getError()
	]);

});

$app->post("/admin/login", function(){
	
	try{
		
		User::login($_POST["login"], $_POST["password"]);
	
	}catch(Exception $e){

		User::setError($e->getMessage());
		header("Location: /admin/login");
		exit;
	}
	
	header("Location: /admin");
	exit;
	
});

$app->get("/admin/logout", function(){
	
	User::logout();
	
	header("Location: /admin/login");
	exit;
	
});

$app->get("/admin/forgot", function() {
    
	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
	
	$page->setTpl("forgot", [
		"error"=>User::getError()
	]);

});

$app->post("/admin/forgot", function(){
				
	try{
		
		$user = User::getForgot($_POST["email"]);				
		
	} catch(Exception $e){
		
		User::setError($e->getMessage());
		header("Location: /admin/forgot");
		exit;
	}
	
	header("Location: /admin/forgot/sent");
	exit;
});

$app->get("/admin/forgot/sent", function(){
			
	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
	
	$page->setTpl("forgot-sent");
});

$app->get("/admin/forgot/reset", function(){
	
	$user = User::validForgotDecrypt($_GET["code"]);
	
	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
	
	$page->setTpl("forgot-reset", array(
		"name"=>$user["desperson"],
		"code"=>$_GET["code"]
	));
});

$app->post("/admin/forgot/reset", function(){
			
	$forgot = User::validForgotDecrypt($_POST["code"]);
	
	User::setForgotUsed($forgot["idrecovery"]);

	$user = new User();
	
	$user->get((int)$forgot["iduser"]);
	
	$password = password_hash($_POST["password"], PASSWORD_DEFAULT, ["const"=>12]);
	
	$user->setPassword($password);
	
	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
	
	$page->setTpl("forgot-reset-success");		
	
});

?>