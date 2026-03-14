trigger newOppOnAccountUpdate on Account (after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    if(Trigger.isUpdate && Trigger.isAfter) {
        for(Account acc : Trigger.new) {
           Opportunity opp = new Opportunity();
            opp.stageName = 'Prospect';
            opp.CloseDate = Date.today() + 5;
            opp.AccountId = acc.Id;
            opp.Name = 'test1234 opp';
            oppList.add(opp);
        }
         insert oppList; 
    }
}