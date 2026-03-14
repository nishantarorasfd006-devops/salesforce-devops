/**
* @File Name : NewAccountClass.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : December 12, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 12, 2024 |   | Initial Version
**/

public class NewAccountClass {
	@AuraEnabled(cacheable=true)
	public static List<Account> getAccounts(){
		List<Account> acc = [SELECT Id, Name FROM Account];
		return acc;
	}
}