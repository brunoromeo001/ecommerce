<?php

use \Hcode\PageAdmin;
use \Hcode\Model\User;

$app->get('/admin/', function() {

	// Método para verificar o Login
	User::verifyLogin();
    
    // Carrega a página header.html pelo método mágico construct
	$page = new PageAdmin();
	
	// Carrega a pagina index.html. Não precisa colocar html porque é a padrão.
	$page->setTpl("index");

	//Por ultimo carrega o arquivo footer.html pelo método mágico destruct. 

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