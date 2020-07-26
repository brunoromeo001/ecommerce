<?php

use \Hcode\Page;
use \Hcode\Model\Product;
use \Hcode\Model\Category;
use \Hcode\Model\Cart;
use \Hcode\Model\Address;
use \Hcode\Model\User;
use \Hcode\Model\Order;
use \Hcode\Model\OrderStatus;

$app->get('/', function() {
	
	$products = Product::listAll();
    
	$page = new Page();
	
	$page->setTpl("index", [
		'products'=>Product::checkList($products)
	]);

});

$app->get("/categories/:idcategory", function($idcategory){
	
	$page = (isset($_GET['page'])) ? (int)$_GET['page'] : 1;
	
	$category = new Category();
	
	$category->get((int)$idcategory);
	
	$pagination = $category->getProductsPage($page);
	
	$pages = [];
	
	for ($i=1; $i <=$pagination['pages']; $i++){
		array_push($pages, [
			'link'=>'/categories/'.$category->getidcategory().'?page='.$i,
			'page'=>$i
		]);		
	}
	
	$page = new Page();
	
	$page->setTpl("category",[
		'category'=>$category->getValues(),
		'products'=>$pagination["data"],
		'pages'=>$pages
	]);
});

$app->get("/products/:desurl", function($desurl){
	
	$product = new Product();
	
	$product->getFromURL($desurl);
	
	$page = new Page();
	
	$page->setTpl("product-detail", [
		'product'=>$product->getValues(),
		'categories'=>$product->getCategories()
	]);
});

$app->get("/order/:idorder/pagseguro", function($idorder){
	
	User::verifyLogin(false);
	
	$order = new Order();
		
	$order->get((int)$idorder);
	
	$cart = $order->getCart();
	
	$page = new Page([
		'header'=>false,
		'footer'=>false
	]);
	
	/* var_dump($order->getValues());
	exit; */
	
	$page->setTpl("payment-pagseguro", [
		'order'=>$order->getValues(),
		'cart'=>$cart->getValues(),
		'products'=>$cart->getProducts(),
		'phone'=>[
			'areaCode'=>substr($order->getnrphone(), 0, 2),
			'number'=>substr($order->getnrphone(), 2, strlen($order->getnrphone()))
		]
	]); 
});

$app->get("/order/:idorder/paypal", function($idorder){
	
	User::verifyLogin(false);
	
	$order = new Order();
		
	$order->get((int)$idorder);
	
	$cart = $order->getCart();
	
	$page = new Page([
		'header'=>false,
		'footer'=>false
	]);
	
	$page->setTpl("payment-paypal", [
		'order'=>$order->getValues(),
		'cart'=>$cart->getValues(),
		'products'=>$cart->getProducts()		
	]); 
});



?>