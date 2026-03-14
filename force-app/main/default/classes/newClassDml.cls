public class newClassDml {
	public static void updateAccountAndUser() {
        // Inserting an Account record
        Account acc = [SELECT Id FROM Account Where Name = 'Raghu Banjara'];
        acc.Name = 'Raghu singh';
        update acc;
        insertUser();
        
        
    }
    
    @future
    public static void insertUser() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='CEO'];
        User usr = new User(alias = 'apexs', email='apex@apexhours.com', 
            emailencodingkey='UTF-8', lastname='Hours', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username='apexhours@apexhours.com');
        insert usr;
        insertUser2();
    }
    
    @future
    public static void insertUser2() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='CEO'];
        User usr = new User(alias = 'apexs hours', email='apex@apexhours.com', 
            emailencodingkey='UTF-8', lastname='Hours_2', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username='apexhours@apexhours.com');
        insert usr;
    }
    
    

}