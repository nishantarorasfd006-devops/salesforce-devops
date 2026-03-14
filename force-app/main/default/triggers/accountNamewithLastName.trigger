trigger accountNamewithLastName on Contact (after insert, after update, after delete) {
    Map<Id, String> mapToUpdateAccountName = new Map<Id, String>();
    Map<Id, String> mapToRemoveAccountName = new Map<Id, String>();
    List<Account> accListToUpdate = new List<Account>();
    List<Account> accIds = new List<Account>();
    if(Trigger.isAfter && Trigger.isInsert) {
        for(Contact con : Trigger.New) {
            Account acc = new Account();
            acc.Name = con.Account.Name + '' + con.LastName;
            acc.Id = con.AccountId;
            accListToUpdate.add(acc);
        }
        upsert accListToUpdate;
        
    }
    if(Trigger.isAfter && Trigger.isUpdate) {
        for(Contact con : Trigger.New) {
            if(Trigger.oldMap != null && (Trigger.oldMap.get(con.Id).AccountId != con.AccountId)) {
                mapToRemoveAccountName.put(trigger.oldMap.get(con.ID).AccountId, con.LastName);
                mapToUpdateAccountName.put(con.AccountId, con.LastName);
            } else {
                mapToUpdateAccountName.put(con.AccountId, con.LastName);
            }
        }
        for(Id accId : mapToRemoveAccountName.keySet()) {
            System.debug('mapToRemoveAccountName.get(accId)>>'+mapToRemoveAccountName.get(accId));
            Account acc = new Account();
            acc.Name = acc.Name.remove(mapToRemoveAccountName.get(accId));
            acc.Id = accId;
            accListToUpdate.add(acc);
        } 
        for(Id accId : mapToUpdateAccountName.keySet()) {
            Account acc = new Account();
            acc.Name = acc.Name + mapToUpdateAccountName.get(accId);
            acc.Id = accId;
            accListToUpdate.add(acc);
        }
        upsert accListToUpdate;
    }
}