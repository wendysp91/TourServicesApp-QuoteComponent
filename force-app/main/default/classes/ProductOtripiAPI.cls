@RestResource(urlMapping='/Product/*')
/* Expose Product object as web service to consume it from an external app */
global with sharing class ProductOtripiAPI {
	
    global static List<Product__c> getAllProducts(){
        List<Product__c> products = [SELECT Id, Name, ProductCode__c, Description__c, IsActive__c FROM Product__c LIMIT 200];
        return products;
    }
   
    @HttpGet
    global static Product__c searchProductByCode() {       
 		RestRequest request = RestContext.request;
        String prodId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Product__c prod = [SELECT Id, Name, ProductCode__c, Description__c, IsActive__c FROM Product__c WHERE ProductCode__c = :prodId]; 
        if (prod!=null) { 
            return prod;
        } else {
            throw new AuraHandledException('Lo siento, el código del producto no se encuentra registrado');
        }
    }
    @HttpPost
     global static void createOneProduct(String name, String productCode, String description, Boolean isActive, Account acc) {
        //Create 2 Accounts
        try{
            Product__c product = new Product__c(Name=name, 
                                                ProductCode__c=productCode, 
                                                Description__c=description, 
                                                IsActive__c=isActive );
        	insert product;   
        }catch(DmlException ex){
            ex.getMessage();
        }
    }

}