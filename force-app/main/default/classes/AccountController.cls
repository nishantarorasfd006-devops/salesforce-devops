public class AccountController {
    
    public static List<Account> getAccount() {
        System.debug('nisha');
        List<Account> acclist = [SELECT Id from Account];
    return acclist;

    }
}