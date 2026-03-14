@RestResource(urlMapping='/Account/*')
global with sharing class RestApiUsingConnectClass {
    @HttpGet
    global static List<Account> getAccounts(){
        System.debug('GET Method has been called');
        return [Select Name, Phone from Account Limit 10];    
    }
}