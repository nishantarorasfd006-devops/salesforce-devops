public class batchAccount {
    public static void inSertAccount(Integer accountLimit, integer lnumber) {
        List<Account> accList = new List<Account>();
        if(accountLimit > 10000) {
            for(Integer i = 0; i < 10000; i++) {
                Account acc = new Account();
                acc.Name = 'nis' + lnumber;
                accList.add(acc);
                lnumber += 1;
            }
            insert accList;
            accountLimit = accountLimit - 10000;
            inSertAccount(accountLimit, lnumber);
        } else {
            for(Integer i = 0; i < accountLimit; i++) {
                Account acc = new Account();
                acc.Name = 'nis' + lnumber;
                accList.add(acc);
                lnumber += 1;
            }
            insert accList;
        }
        
        
    }                                     
}