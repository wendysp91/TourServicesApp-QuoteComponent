public with sharing class QuotationHelper{
    
    public void initialConfig() {
        //Create 2 Accounts
        List<Account> accounts = new List<Account>{new Account(Name='Compumundo'),
                                                    new Account(Name='Compuworld')};

        insert accounts;   
    }

    public List<Inventario__c> getAllInventario() {
        //Get all Inventories
        return [SELECT Id,Name FROM Inventario__c];
    }

    public List<Product2> productsInInventory() {
        //Get all Inventories throw getAllInventario method
        List<Inventario__c> inventario = getAllInventario();
        List<Product2> prodInInvent;
        //Get Product related to each Inventary record
        for (Inventario__c inv : inventario) {
            Product2 prod = [SELECT Id,Name FROM Product2 WHERE Id =:inv.Product__c];
            //Add to List<Product2> prodInInvent
            prodInInvent.add(prod);
        }
        return prodInInvent;
    }

    public Boolean confirmProductExistByCode(String prodCode) {
        Boolean flag = false;
        //Get product with the ProductCode receive by params
        Product2 product = [SELECT Id,Name,ExternalId FROM Product2 WHERE ProductCode =: prodCode];
        //Validate if ExternalId field exist in the product
        if (product.ExternalId == ' ') {
            flag = false;
        } else {
            flag = true;
        }
        System.debug(flag);
        return flag;
    }

    public Double searchProductByCode(String prodCode) {
         //Get products in an inventory with the ProductCode receive by params
         Inventario__c inventory = [SELECT Id,Name,Cantidad_dis__c FROM Inventario__c WHERE Codigo_Prod__c =: prodCode];
         System.debug(inventory.Cantidad_dis__c);
        return inventory.Cantidad_dis__c;
    }

}
