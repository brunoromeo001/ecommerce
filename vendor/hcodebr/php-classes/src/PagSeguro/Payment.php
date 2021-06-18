<?php 

namespace Hcode\PagSeguro;

use Exception;
use DOMDocument;
use DOMElement;
use Hcode\PagSeguro\Payment\Method;

class Config{

  private $mode = "default";
  private $currency = "BRL";
  private $extraAmout = 0;
  private $reference = "";
  private $items = [];
  private $sender;
  private $shipping;
  private $method;
  private $creditCard;
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

  public function addItem(Item $item)
  {

    array_push($this->$items, $item);
    
  }

  public function setBank(Bank $bank)
  {

    $this->bank = $bank;
    $this->method = Method::DEBIT;
  }

  public function setCreditCard(CreditCard $creditCard)
  {

    $this->creditCard = $creditCard;
    $this->method = Method::CREDIT_CARD;
  }

  public function setBoleto()
  {
    
    $this->method = Method::BOLETO;
  }
  

  public function getDOMDocument():DOMDocument
  {

    $dom = new DOMDocument('1.0', 'ISO-8859-1');

    $payment = $dom->createElement("payment");
    $payment = $dom->appendChild($payment);

    $mode = $dom->createElement("mode", $this->mode);
    $mode = $dom->appendChild($mode);



    return $dom;
  }



};

?>