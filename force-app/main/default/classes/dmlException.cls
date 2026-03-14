public class dmlException extends Exception {
    public static void updateAccount() {
        Account acc = new Account();
        acc.Name = 'Govind';
        insert acc;
        
        User u = [SELECT Id, Name, Title FROM User Where Name Like '%Nishant%'];
        u.Street = 'Test Title';
        update u;
    }
}