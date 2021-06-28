<?php 

namespace Hcode\PagSeguro;

class Config{

    const SANDBOX = true;

    const SANDBOX_EMAIL = "brunogfvot@hotmail.com";
    const PRODUCTION_EMAIL = "brunogfvot@hotmail.com";

    const SANDBOX_TOKEN = "BAAF3380E44640FE9A95D1AA24A5DA9A";
    const PRODUCTION_TOKEN = "ed677158-d0ab-4959-b583-ee6f6e30d2ee54c3ffc745bdaf81cdd5803e5052fe97b3c7-c0e0-458a-8a67-6fad44908789";

    const SANDBOX_SESSIONS = "https://ws.sandbox.pagseguro.uol.com.br/v2/sessions";
    const PRODUCTION_SESSIONS = "https://ws.pagseguro.uol.com.br/v2/sessions";
    
    const SANDBOX_URL_JS = "https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";
    const PRODUCTION_URL_JS = "https://stc.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js";

    const MAX_INSTALLMENT_NO_INTEREST = 3;
    const MAX_INSTALLMENT = 10;
    
    const SANDBOX_URL_TRANSACTION = "https://ws.sandbox.pagseguro.uol.com.br/v2/transactions";
    const PRODUCTION_URL_TRANSACTION = "https://ws.pagseguro.uol.com.br/v2/transactions";

    const SANDBOX_URL_NOTIFICATION = "https://ws.sandbox.pagseguro.uol.com.br/v2/transactions/notifications/";
    const PRODUCTION_URL_NOTIFICATION = "https://ws.pagseguro.uol.com.br/v2/transactions/notifications/";
    
    const NOTIFICATION_URL = "http://www.brunoromeo.com.br/payment/notification";

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

    public static function getUrlTransaction()
    {

        return (Config::SANDBOX === true) ? Config::SANDBOX_URL_TRANSACTION : Config::PRODUCTION_URL_TRANSACTION;

    }
    
    public static function getNotificationTransactionURL()
    {

        return (Config::SANDBOX === true) ? Config::SANDBOX_URL_NOTIFICATION : Config::PRODUCTION_URL_NOTIFICATION;

    }

    

};