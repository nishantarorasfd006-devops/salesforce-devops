public class startClass {
    public static void main() {
        Account acc = [SELECT Id FROM Account Where Name = 'ANish'];
        
        string startString = '';
        for(integer i = 0; i<5; i++) {
            for (integer j = 0; j<i; j++) {
                startString += '*';
            }
            startString += '\n';
        }
        System.debug('startString:::'+startString);
        acc.BillingStreet = startString;
        update acc;
    }
}