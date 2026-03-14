trigger LeadCreationPrevention on Lead (before insert) {
    if(Trigger.isInsert && Trigger.isBefore) {
        for(Lead ld : Trigger.new) {
            if(ld.Email.contains('gmail.com')){
                ld.addError('Can not insert the lead with this domain');
            }
        }
    }
}