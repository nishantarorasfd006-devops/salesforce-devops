trigger AccountNumberOnContactCreation on Contact (after insert, after delete, after Update) {
    Set<Id> accIds = new Set<Id>();
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Contact con : Trigger.New) {
            if(Trigger.oldMap != null && con.AccountId != Trigger.oldMap.get(con.Id).AccountId) {
                accIds.add(con.AccountId);
                accIds.add(Trigger.oldMap.get(con.Id).AccountId);
            } else {
                accIds.add(con.AccountId);
            }
        }
        System.debug('accIds:::'+accIds);
        List<Account> accList = [SELECT Id, AccountNumber, (Select Id FROM Contacts) FROM Account Where Id In : accIds];
        for(Account acc : accList) {
            System.debug('acc::>>'+acc.contacts.size());
            acc.AccountNumber = String.valueOf(acc.Contacts.size());
        }
        update accList;
        
    }
}