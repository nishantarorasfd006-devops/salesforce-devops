trigger totalSlaryTrigger on Contact (after insert, after update) {
    Set<Id> AccountIdSet = new Set<Id>();
    Map<Id, Decimal> accIdSumSalary = new Map<Id, Integer>();
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Contact con : Trigger.New) {
            if(Trigger.oldMap != null && con.AccountId != Trigger.oldMAp.get(con.Id).AccountId) {
                AccountIdSet.add(Trigger.oldMAp.get(con.Id).AccountId);
                AccountIdSet.add(con.AccountId);
            } else {
                AccountIdSet.add(con.AccountId);
            }
        }
    }
    System.debug('Account Id>>>>>'+AccountIdSet);
    List<AggregateResult> agrList = [SELECT AccountId, Sum(Salary__c) totalSalary FROM Contact where AccountId IN : AccountIdSet AND Salary__c > 50000 Group By AccountId];
    System.debug('AggregateResult>>>>>'+agrList);
    for(AggregateResult agr : agrList) {
        accIdSumSalary.put((Id) agr.get('AccountId'), (Decimal) agr.get('totalSalary'));
    }
     System.debug('accIdSumSalary>>>>>'+accIdSumSalary);
    List<Account> accList = [SELECT Id, Total_Con_Amount__c, Name FROM Account where ID In : accIdSumSalary.keySet()];
    for(Account acc : accList) {
        if(acc.Total_Con_Amount__c > accIdSumSalary.get(acc.Id)) {
            acc.Total_Con_Amount__c = acc.Total_Con_Amount__c != null ? acc.Total_Con_Amount__c - (acc.Total_Con_Amount__c - accIdSumSalary.get(acc.Id)) : acc.Total_Con_Amount__c;
        } else if (acc.Total_Con_Amount__c < accIdSumSalary.get(acc.Id)) {
 			acc.Total_Con_Amount__c = acc.Total_Con_Amount__c != null ? acc.Total_Con_Amount__c + (accIdSumSalary.get(acc.Id) - acc.Total_Con_Amount__c) : acc.Total_Con_Amount__c;
        } else {
           acc.Total_Con_Amount__c = accIdSumSalary.get(acc.Id);
        }
    }
    
}