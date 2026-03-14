public class accountFetch {
    public static List<Account> getAccount() {
        List<Account> accList = [SELECT Id, AccountNumber, Name FROM Account Where Name = 'pandey ji 1 7 9 9 8 0000'];
        System.debug('accList::>>'+accList);
        for(Account acc : accList) {
            acc.AccountNumber = acc.AccountNumber + 1;
        }
        update accList;
        System.debug('accList2::>>'+accList);
        return accList;
    }
    
}