<?php 

namespace Hcode\PagSeguro;

class Config{

    const SENDBOX = true;

    const SENDBOX_EMAIL = "brunogfvot@hotmail.com";
    const PRODUCTION_EMAIL = "contato@brunoromeo.com.br";

    const SENDBOX_TOKEN = "BAAF3380E44640FE9A95D1AA24A5DA9A";
    const PRODUCTION_TOKEN = "f527f844-19c2-4082-9c27-11d89c95cb590edb9e904b5189a43b828a4b4a25ac2ef4e6-c5ef-453b-b5d6-02813ec0d8e0";

    const SENDBOX_SESSIONS = "https://ws.sandbox.pagseguro.uol.com.br/v2/sessions";
    const PRODUCTION_SESSIONS = "https://ws.pagseguro.uol.com.br/v2/sessions";

    const SENDBOX_URL_JS = 'https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js';
    const PRODUCTION__URL_JS = 'https://stc.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js';

    public static function getAuthentication():array
    {
        if (Config::SENDBOX === true){

            return [
                "email"=>Config::SENDBOX_EMAIL,
                "token"=>Config::SENDBOX_TOKEN
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

        return (Config::SENDBOX == true) ? Config::SENDBOX_SESSIONS : Config::PRODUCTION_SESSIONS;

    }

    public static function getUrlJS()
    {

        return (Config::SENDBOX == true) ? Config::SENDBOX_URL_JS : Config::PRODUCTION_URL_JS;

    }

}