@RestResource(urlMapping='/Account/*')
/* Expose Account object as web service to consume it from an external app */
global with sharing class OtripiAPI {
	
     global static List<Account> getAllAccounts(){
        List<Account> accounts = [SELECT Id, Name, Type, Rating, BillingAddress, Phone FROM Account LIMIT 200];
        return accounts;
    }
    
    @HttpGet
     global static Account searchAccountByName() {      
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account acc = [SELECT Id, Name, Type, Rating, BillingAddress, Phone FROM Account WHERE Id = :accId]; 
        if (acc!=null) { 
            return acc;
        } else {
            throw new AuraHandledException('Lo siento, el código del producto no se encuentra registrado');
        }
    }
    @HttpPost
    global static void createAccount(String name, String type, String rating, String phone) {
        //Create 2 Accounts
        try{
            Account account = new Account(Name=name,
                                          Type=type,
                                          Rating=rating,
                                          Phone=phone
                                          );
        	insert account;   
        }catch(DmlException ex){
            ex.getMessage();
        }
    }
}