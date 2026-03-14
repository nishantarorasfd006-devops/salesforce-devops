trigger LateOppDateField on Opportunity (after insert) {
    Set<Id> oppIdSet = new Set<Id>();
    if(Trigger.isInsert && Trigger.isAfter) {
        for(Opportunity opp : Trigger.new) {
            oppIdSet.add(opp.AccountId);
        }
        List<Account> accList = [SELECT Id, (SELECT Id, CloseDate FROM Opportunities ORDER BY CloseDate DESC) FROM Account where Id In : oppIdSet];
        for(Account ac : accList) {
            ac.LatesOppDate__c = ac.Opportunities[0].closeDate;
        }
        update accList;
    }
}