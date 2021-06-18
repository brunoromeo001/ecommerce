<?php 

namespace Hcode\PagSeguro;

use Exception;
use DOMDocument;
use DOMElement;

class Phone{

  private $areaCode;
  private $number;

  public function __construct(int $areaCode, int $number)
  {

    if(!$areaCode || $areaCode < 11 || $areaCode > 99 )
    {

      throw new Exception("Informe o DDD do telefone.");

    }

    if(!$number || strlen($number) < 9 || strlen($number) > 10 )
    {

      throw new Exception("Informe o número do telefone.");

    }

    $this->$areaCode = $areaCode;
    $this->$number = $number;

  }

  public function getDOMElement():DOMElement
  {

    $dom = new DOMDocument();

    $phone = $dom->createElement("phone");
    $phone = $dom->appendChild($phone);

    $areaCode = $dom->createElement("areaCode", $this->areaCode);
    $areaCode = $document->appendChild($areaCode);

    $phone = $dom->createElement("number", $this->number);
    $phone = $phone->appendChild($number);

    return $phone;

  }

};

?>