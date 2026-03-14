trigger autoConvertLead on Lead (after insert, after update) {
    List<Database.LeadConvert> leadToConvertList = new List<Database.LeadConvert>();
    LeadStatus convertStatus = [SELECT Id, ApiName FROM LeadStatus WHERE IsConverted=true LIMIT 1];
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Lead ld : Trigger.new) {
            if(ld.LeadSource == 'Web' && !ld.IsConverted) {
                Database.LeadConvert leadCVT = new Database.LeadConvert(); 
                leadCVT.setLeadId(ld.Id);
                leadCVT.setDoNotCreateOpportunity(false);
                leadCVT.setConvertedStatus(convertStatus.ApiName);
                leadToConvertList.add(leadCVT);
            }
        }
        List<Database.LeadConvertResult> results = Database.convertLead(leadToConvertList, false);
        System.debug('result::>>'+results);
    }
}