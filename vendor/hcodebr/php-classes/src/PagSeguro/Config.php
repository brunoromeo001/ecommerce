<?php 

namespace Hcode\PagSeguro;

class Config{

    const SENDBOX = true;

    const SENDBOX_EMAIL = "brunogfvot@hotmail.com";
    const PRODUCTION_EMAIL = "contato@brunoromeo.com.br";

    const SENDBOX_TOKEN = "BAAF3380E44640FE9A95D1AA24A5DA9A";
    const PRODUCTION_TOKEN = "2081f11d-b664-4d77-82ba-e58f8383bbe0c3ae54ff4129b4acd950cb5bb7a1448306e1-0b2a-4a49-83de-28410c7b2197";

    const SENDBOX_SESSIONS = "https://ws.sandbox.pagseguro.uol.com.br/v2/sessions";
    const PRODUCTION_SESSIONS = "https://ws.pagseguro.uol.com.br/v2/sessions";

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

}