public class AccountController {
    
    public static List<Account> getAccount() {
        List<Account> acclist = [SELECT Id from Account];
    return acclist;

    }
}