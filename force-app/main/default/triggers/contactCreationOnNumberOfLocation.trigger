trigger contactCreationOnNumberOfLocation on Account (after insert, after update) {
    Map<Id, Integer> numberOfEmployeeAccIdMap = new Map<Id, Integer>();
    Map<Id, List<Contact>> contactAccMap = new Map<Id, List<Contact>>();
    Set<Id> accIds = new Set<Id>();
    List<Contact> conListToInsert = new List<Contact>();
    List<Contact> conListToDelete = new List<Contact>();
    if(Trigger.isInsert && Trigger.isAfter) {
        for(Account acc : Trigger.New) {
            for(Integer i = 0; i < acc.NumberOfEmployees; i++) {
                Contact con = new Contact();
                con.LastName = 'test' + i;
                con.AccountId = acc.Id;
                conListToInsert.add(con);
            }
        }
        insert conListToInsert;
    }
    else if(Trigger.isAfter && Trigger.isUpdate) {
        for(Account acc : Trigger.New) {
            if(!Trigger.oldMap.isEmpty() && acc.NumberOfEmployees != Trigger.oldMap.get(acc.Id).NumberOfEmployees) {
                numberOfEmployeeAccIdMap.put(acc.Id, acc.NumberOfEmployees);
                accIds.add(acc.Id);
            } else {
                numberOfEmployeeAccIdMap.put(acc.Id, acc.NumberOfEmployees);
                accIds.add(acc.Id);
            }
            
        }
        List<Contact> conlist = [SELECT Id, AccountId  FROM Contact Where AccountId In : accIds];
        for(Contact con : conList) {
            if(!contactAccMap.containsKey(con.AccountId)) {
                contactAccMap.put(con.AccountId, new List<Contact>{con});
            } else {
                contactAccMap.get(con.AccountId).add(con);
            }
        }
        for(Id accId : accIds) {
            Integer desired = numberOfEmployeeAccIdMap.get(accId);
            List<Contact> current =  contactAccMap.get(accId);
            Integer existing = current == null ? 0 : current.size();

            if(desired > existing) {
                for(Integer i = 0; i < desired - existing; i++) {
                    Contact con = new Contact();
                    con.LastName = 'test' + i;
                    con.AccountId = accId;
                    conListToInsert.add(con);
                }
            } else {
                for(Integer i = 0; i < existing - desired;  i++) {
                    conListToDelete.add(contactAccMap.get(accId)[i]);
                }
            }
        }
        if(conListToDelete.size() > 0) {
            delete conListToDelete;
        }
        if(conListToInsert.size() > 0) {
            insert conListToInsert;
        }
    }
}