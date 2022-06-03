public with sharing class QuotationHelper {
    
    public void initialConfig() {
        List<Account> accounts = new List<Account>{new Account(Name='Compumundo'),
                                                    new Account(Name='Compuworld')};

        insert accounts;   
    }

    public List<Inventario__c> getAllInventario() {
        return [SELECT Id,Name FROM Inventario__c];
    }

    public List<Product2> productsInInventory() {
        List<Inventario__c> inventario = getAllInventario();
        List<Product2> prodInInvent;
        
        for (Inventario__c inv : inventario) {
            Product2 prod = [SELECT Id,Name FROM Product2 WHERE Id =:inv.Product__c];
            prodInInvent.add(prod);
        }
        return prodInInvent;
    }
}
