trigger contactCreationOnNumberOfLocation2 on Account (after insert, after update) {
    Set<Id> accIds = new Set<Id>();
    List<Contact> conListToInsert = new List<Contact>();
    if(Trigger.isAfter || (Trigger.isInsert && Trigger.isUpdate)) {
        for(Account acc : Trigger.new) {
            if(!Trigger.oldMap.isEmpty() && acc.NumberOfEmployees != Trigger.oldMap.get(acc.Id).NumberOfEmployees) {
                accIds.add(acc.Id);
            } else {
                for(Integer i = 0; i < acc.NumberOfEmployees; i++) {
                    Contact con = new Contact();
                    con.LastName = 'test' + i;
                    con.AccountId = acc.Id;
                    conListToInsert.add(con);
                }
            }
        }
    }
}