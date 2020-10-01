<?php 

namespace Hcode\PagSeguro;

class Config{

    const SANDBOX = true;

    const SANDBOX_EMAIL = "brunogfvot@hotmail.com";
    const PRODUCTION_EMAIL = "brunogfvot@hotmail.com";

    const SANDBOX_TOKEN = "BAAF3380E44640FE9A95D1AA24A5DA9A";
    const PRODUCTION_TOKEN = "5f13f9f3-2cb9-47fe-97b9-c1be6be53fed56dd869d4703830dd74d0129256c8fed7d02-35db-4ba2-8efd-1dce647812af";

    const SANDBOX_SESSIONS = "https://ws.sandbox.pagseguro.uol.com.br/v2/sessions";
    const PRODUCTION_SESSIONS = "https://ws.pagseguro.uol.com.br/v2/sessions";
    
    const SANDBOX_URL_JS = "https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";
    const PRODUCTION_URL_JS = "https://stc.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";

    const MAX_INSTALLMENT_NO_INTEREST = 3;
    const MAX_INSTALLMENT = 10;

    public static function getAuthentication():array
    {
        if (Config::SANDBOX === true){

            return [
                "email"=>Config::SANDBOX_EMAIL,
                "token"=>Config::SANDBOX_TOKEN
            ];
        
        } else {

            return [
                "email"=>Config::PRODUCTION_EMAIL,
                "token"=>Config::PRODUCTION_TOKEN
            ];
        }

    }

    public static function getUrlSessions():string
    {

        return (Config::SANDBOX === true) ? Config::SANDBOX_SESSIONS : Config::PRODUCTION_SESSIONS;

    }

    public static function getUrlJS()
    {

        return (Config::SANDBOX === true) ? Config::SANDBOX_URL_JS : Config::PRODUCTION_URL_JS;

    }

};