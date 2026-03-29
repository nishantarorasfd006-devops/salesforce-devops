public class AccountController {
    
    public static List<Account> getAccount() {
        System.debug('123');
        List<Account> acclist = [SELECT Id from Account];
    return acclist;

    }
}