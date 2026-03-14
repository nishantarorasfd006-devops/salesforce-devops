/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-11-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class AccountClass {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, Phone FROM Account LIMIT 50];
    }

    @AuraEnabled
    public static void updateAccounts(List<Account> accountsToUpdate) {
        if (accountsToUpdate.isEmpty()) return;

        try {
            update accountsToUpdate;
        } catch (Exception ex) {
            throw new AuraHandledException('Failed to update accounts: ' + ex.getMessage());
        }
    }
}