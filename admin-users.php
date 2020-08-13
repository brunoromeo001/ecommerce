<?php

use \Hcode\PageAdmin;
use \Hcode\Model\User;

$app->get("/admin/users/:iduser/password", function($iduser){
	
	User::verifyLogin();
	
	$user = new User();
	
	$user->get((int)$iduser);
	
	$page = new PageAdmin();
	
	$page->setTpl("users-password",[
		'user'=>$user->getValues(),
		"msgError"=>user::getError(),
		"msgSuccess"=>User::getSuccess()
	]);
	
});

$app->post("/admin/users/:iduser/password", function($iduser){
	
	User::verifyLogin();
	
	if (!isset($_POST['despassword']) || $_POST['despassword'] === ''){
		
		User::setError("Preencha a nova senha.");
		header("Location: /admin/users/$iduser/password");
		exit;
	}
	
	if ($_POST['despassword'] !== $_POST['despassword-confirm']){
		
		User::setError("Confirme corretamente as senhas.");
		header("Location: /admin/users/$iduser/password");
		exit;
	}
	
	$user = new User();
	
	$user->get((int)$iduser);	
	
	$user->setPassword(User::getPasswordHash($_POST['despassword']));
	
	User::setSuccess("Senha alterada com sucesso.");
	header("Location: /admin/users/$iduser/password");
	exit;
	
});

$app->get("/admin/users", function(){
	
	User::verifyLogin();
	
	//pega o valor que está no formulario
	$search = (isset($_GET['search'])) ? $_GET['search'] : "";
	$page = (isset($_GET['page'])) ? (int)$_GET['page'] : 1;
	
	if ($search != ''){
		
		$pagination = User::getPageSearch($search, $page);
		
	} else{
		
		$pagination = User::getPage($page);
	}		
	
	$pages = [];
	
	for ($x = 0; $x < $pagination['pages']; $x ++){
		
		array_push($pages, [
			'href'=>'/admin/users?'.http_build_query([
				'page'=>$x + 1,
				'search'=>$search
			]),
			'text'=>$x + 1
		]);
		
	}
	
	$page = new PageAdmin();
	
	$page->setTpl("users", array(
		"users"=>$pagination['data'],
		"search"=>$search,
		"pages"=>$pages
	));
	
});

$app->get("/admin/users/create", function(){
	
	User::verifyLogin();
	
	$page = new PageAdmin();
	
	$page->setTpl("users-create");
	
});

$app->get("/admin/users/:iduser/delete", function($iduser){
	
	User::verifyLogin();
	
	$user = new User();
	
	$user->get((int)$iduser);
	
	$user->delete();
	
	header("Location: /admin/users");
	exit;
			
});

$app->get("/admin/users/:iduser", function($iduser){
	
	User::verifyLogin();
	
	$user = new User();
	
	$user->get((int)$iduser);
	
	$page = new PageAdmin();
	
	$page->setTpl("users-update", array(
		"user"=>$user->getValues()
	));
	
});

$app->post("/admin/users/create", function(){
	
	User::verifyLogin();
		
	$user = new User();
	
	$_POST["inadmin"] = (isset($_POST["inadmin"]))?1:0;
			
	$user->setData($_POST);
	
	$user->save();
	
	header("Location: /admin/users");
	exit;
	
});

$app->post("/admin/users/:iduser", function($iduser){
	
	User::verifyLogin();
	
	$user = new User();
	
	$_POST["inadmin"] = (isset($_POST["inadmin"]))?1:0;
	
	$user->get((int)$iduser);
	
	$user->setData($_POST);
	
	$user->update();
	
	header("Location: /admin/users");
	exit;
			
});

$app->get("/admin/profile", function(){    	
	
	User::verifyLogin();
	
	$user = User::getFromSession();
	
	$page = new PageAdmin();	
			
	$page->setTpl("profile", [
		"user"=>$user->getValues(),
		'profileMsg'=>User::getSuccess(),
		'profileError'=>User::getError()
	]);	
	
}); 

$app->post("/admin/profile", function(){
	
	User::verifyLogin();
	
	if (!isset($_POST['desperson']) || $_POST['desperson'] === ''){
		
		User::setError("Preencha o seu nome.");
		header("Location: /admin/profile");
		exit;
	}	
	
	if (!isset($_POST['desemail']) || $_POST['desemail'] === ''){
		
		User::setError("Preencha o seu e-mail.");
		header("Location: /admin/profile");
		exit;
	}
	
	$user =  User::getFromSession();
	
	if ($_POST['desemail'] !== $user->getdesemail()){
		
		if (User::checkLoginExist($_POST['desemail']) === true){
			
			User::setError("Este endereço de e-mail já está cadastrado.");
			header("Location: /admin/profile");
		exit;
		}
	}
		
	$_POST['inadmin'] = $user->getinadmin();
	$_POST['despassword'] = $user->getinadmin();
	$_POST['deslogin'] = $_POST['desemail'];
	
	$user->setData($_POST);
	
	$user->save();
	
	$user::setSuccess("Dados alterados com sucesso!");
	
	header("Location: /admin/profile");
	exit;
});

//ROTA PARA MOSTRA O FORMULÁRIOD DE CADASTRO DO FUNCIONÁRIO
$app->get("/admin/profile/change-password", function(){
	
	User::verifyLogin();		
	
	$page = new PageAdmin();
	
	$page->setTpl("/admin/profile-change-password", [		
		"alterarSenhaError"=>User::getError(),		
		"alterarSenhaSuccess"=>User::getSuccess()
	]);
	
});

$app->post("/admin/profile/alterar-senha", function(){
	
	User::verifyLogin();
	
	if (!isset($_POST['senha_atual']) || $_POST['senha_atual'] === ''){
		
		User::setError("Digite a senha atual.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	if (!isset($_POST['nova_senha']) || $_POST['nova_senha'] === ''){
		
		User::setError("Digite a nova senha.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	if (!isset($_POST['nova_senha_confirma']) || $_POST['nova_senha_confirma'] === ''){
		
		User::setError("Confirme a nova senha.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	if ($_POST['senha_atual'] === $_POST['nova_senha']){
		
		User::setError("A sua nova senha deve ser diferente da senha atual.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	if ($_POST['nova_senha'] != $_POST['nova_senha_confirma']){
		
		User::setError("A confirmação da nova senha não pode ser diferente da mesma.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	$user = User::getFromSession();
	
	if (!password_verify($_POST['senha_atual'], $user->getsenha())){
		
		User::setError("A senha atual está inválida.");
		header("Location: /admin/profile/alterar-senha");
		exit;
	}
	
	$user->setsenha($_POST['nova_senha']);
	
	$user->update();
	
	User::setSuccess("Senha alterada com sucesso.");
	
	header("Location: /admin/profile/alterar-senha");
	exit;
});

//ROTA PARA MOSTRA O FORMULÁRIOD DE CADASTRO DO FUNCIONÁRIO
$app->get("/admin/profile/photo", function(){
	
	User::verifyLogin();		
	
	$page = new PageAdmin();

	$user = new User();
	
	$page->setTpl("/admin/profile-photo", [		
		"user"=>$user->getValues(),
		"photoSuccess"=>User::getSuccess(),
		"photoError"=>User::getError()
	]);
	
});

$app->post("/admin/profile/photo", function(){
		
		User::verifyLogin();		
		
		$user = new User();
		
		$user = User::getFromSession();
		
		$data = $_POST["image"];
	
		$image_array_1 = explode(";", $data);
	
		$image_array_2 = explode(",", $image_array_1[1]);
			
		$data = base64_decode($image_array_2[1]);
			
		$imageName = $user->getiduser() . '.jpg';
	
		file_put_contents('res/admin/dist/img/user-photo/'.$imageName, $data);
	
		User::setSuccess("Foto alterada com sucesso.");	
	
		header("Location: /admin/profile/photo");
		exit;			
	
});

?>