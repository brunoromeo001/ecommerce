<?php 

namespace Hcode\PagSeguro;

use Exception;
use DOMDocument;
use DOMElement;

class Address{

  private $street;
  private $number;
  private $complement;  
  private $district;
  private $postalCode;
  private $city;
  private $state;  
  private $country;

  public function __construct(
    string $street, 
    string $number, 
    string $complement, 
    string $district, 
    string $postalCode, 
    string $city, 
    string $state, 
    string $country
  )
  {

    if(!$street)
    {

      throw new Exception("Informe o endereço");

    }

    if(!$number)
    {

      throw new Exception("Informe o número.");

    }
    

    if(!$district)
    {

      throw new Exception("Informe o bairro.");

    }

    if(!$postalCode)
    {

      throw new Exception("Informe o CEP.");

    }

    if(!$city)
    {

      throw new Exception("Informe a cidade.");

    }

    if(!$state)
    {

      throw new Exception("Informe o estado.");

    }

    if(!$country)
    {

      throw new Exception("Informe o país.");

    }
    

    $this->street = $street;
    $this->number = $number;
    $this->complement = $complement;
    $this->district = $district;
    $this->postalCode = $postalCode;
    $this->city = $city;
    $this->state = $state;
    $this->country = $country;

  }

  public function getDOMElement($node = "address"):DOMElement
  {

    $dom = new DOMDocument();

    $address = $dom->createElement($node);
    $address = $dom->appendChild($address);

    $street = $dom->createElement("street", $this->street);
    $street = $address->appendChild($street);

    $number = $dom->createElement("number", $this->number);
    $number = $address->appendChild($number);

    $complement = $dom->createElement("complement", $this->complement);
    $complement = $address->appendChild($complement);

    $district = $dom->createElement("district", $this->district);
    $district = $address->appendChild($district);

    $postalCode = $dom->createElement("postalCode", $this->postalCode);
    $postalCode = $address->appendChild($postalCode);

    $city = $dom->createElement("city", $this->city);
    $city = $address->appendChild($city);

    $state = $dom->createElement("state", $this->state);
    $state = $address->appendChild($state);

    $country = $dom->createElement("country", $this->country);
    $country = $address->appendChild($country);

    return $address;

  }

};

?>