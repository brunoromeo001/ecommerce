<?php 

namespace Hcode\PagSeguro;

class Config{

  private $mode = "default";
  private $currency = "BRL";
  private $extraAmout = 0;
  private $reference = "";
  private $items = [];
  private $sender;
  private $shipping;
  private $method;
  private $creditCart;
  private $bank;

  public function __construct(
    string $reference,
    Sender $sender,
    Shipping $shipping,
    float $extraAmout = 0
  )
  {
    $this->sender = $sender;
    $this->shipping = $shipping;
    $this->reference = $reference;
    $this->extraAmout = number_format($extraAmout, 2, '.', '');
  }

  public function getDOMDocument():DOMDocument
  {

    $dom = new DOMDocument('1.0', 'ISO-8859-1');


    return $dom;
  }



};

?>