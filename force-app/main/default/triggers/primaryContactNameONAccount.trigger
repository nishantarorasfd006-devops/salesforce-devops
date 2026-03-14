trigger primaryContactNameONAccount on Contact (after insert, after update) {
	Map<Id, String> accIdContactNameMap = new Map<Id, String>();
	Map<Id, List<Contact>> accounIdContToDelListMap = new Map<Id, List<Contact>>();
	Set<Id> contactListToremovePrimary =  new Set<Id>();
	if(Trigger.isAfter && Trigger.isInsert) {
		for(Contact con : Trigger.new) {
			if(con.isPrimary__c == true) {
				accIdContactNameMap.put(con.AccountId, con.firstName);
			}
		}
		List<Account> accList = [SELECT Id, primaryContact__c FROM Account Where Id IN : accIdContactNameMap.keySet()];
		for(Account acc : accList) {
			acc.primaryContact__c = accIdContactNameMap.get(acc.Id);
		}
		update accList;
	} else if (Trigger.isAfter && Trigger.isUpdate) {
		for(Contact con : Trigger.new) {
			if(Trigger.oldMap != null && con.isPrimary__c == true && Trigger.oldMap.get(con.Id).isPrimary__c != con.isPrimary__c) {
				accIdContactNameMap.put(con.AccountId, con.firstName);
				contactListToremovePrimary.add(con.Id);
			}
		}
		List<Contact> conList = [SELECT Id, AccountId, isPrimary__c FROM Contact Where AccountId In : accIdContactNameMap.keySet() AND Id Not IN : contactListToremovePrimary AND isPrimary__c = true];
		for(Contact con : conList) {
			con.isPrimary__c = false;
		}
		update conList;
		List<Account> accList = [SELECT Id, primaryContact__c FROM Account Where Id IN : accIdContactNameMap.keySet()];
		for(Account acc : accList) {
			acc.primaryContact__c = accIdContactNameMap.get(acc.Id);
		}
		update accList;
	}
}