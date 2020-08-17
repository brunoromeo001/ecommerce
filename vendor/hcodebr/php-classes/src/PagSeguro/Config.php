<?php 

namespace Hcode\PagSeguro;

class Config{

    const SANDBOX = true;

    const SANDBOX_EMAIL = "brunogfvot@hotmail.com";
    const PRODUCTION_EMAIL = "contato@brunoromeo.com.br";

    const SANDBOX_TOKEN = "BAAF3380E44640FE9A95D1AA24A5DA9A";
    const PRODUCTION_TOKEN = "08fb43f8-805a-4314-974d-25eab3653226f2c50936450c8d90e30d1f209d59c3b9ca34-506f-429c-8462-efb067c63c49";

    const SANDBOX_SESSIONS = "https://ws.sandbox.pagseguro.uol.com.br/v2/sessions";
    const PRODUCTION_SESSIONS = "https://ws.pagseguro.uol.com.br/v2/sessions";
    
    const SANDBOX_URL_JS = "https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";
    const PRODUCTION_URL_JS = "https://stc.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";

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

        return (Config::SANDBOX == true) ? Config::SANDBOX_SESSIONS : Config::PRODUCTION_SESSIONS;

    }

    public static function getUrlJS()
    {

        return (Config::SANDBOX == true) ? Config::SANDBOX_URL_JS : Config::PRODUCTION_URL_JS;

    }

}