public class QuotationHelper implements QuotationSync{
    
    public void initialConfig() {
        //Create 2 Accounts
        List<Account> accounts = new List<Account>{new Account(Name='Compumundo'),
                                                    new Account(Name='Compuworld')};

        insert accounts;   
    }

    public List<Inventario__c> getAllInventario() {
        //Get all Inventories
        return [SELECT Id,Name, Codigo_Prod__c, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c LIMIT 200];
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
        
        //Get product with the ProductCode receive by params
        Product2 product = [SELECT Id,Name FROM Product2 WHERE ProductCode =: prodCode];
        //Validate if exist 1 product
        return product != null;
    }

    public Product2 searchProductByCode(String prodCode) {
       
        //Get products with the ProductCode receive by params
        Product2 product = [SELECT Product2.Name, Product2.ExternalId, (SELECT PriceBookEntry.UnitPrice FROM PriceBookEntries), (SELECT Inventario__c.Cantidad_apart__c,Inventario__c.Cantidad_dis__c FROM Inventarios__r) FROM Product2 WHERE Product2.ProductCode =: prodCode];
        return product;
       
    }

    public Double searchCantDisponibleByCode(String prodCode) {
        Boolean prodExist = confirmProductExistByCode(prodCode);
        if (prodExist) {
            //Get products in an inventory with the ProductCode receive by params
            Inventario__c inventory = [SELECT Id,Name,Cantidad_dis__c FROM Inventario__c WHERE Product__r.ProductCode =: prodCode LIMIT 1];
            return inventory.Cantidad_dis__c;
        } else {
            return 0;
        }
    }
    public Double searchCantApartadaByCode(String prodCode) {
        Boolean prodExist = confirmProductExistByCode(prodCode);
        if (prodExist) {
            //Get products in an inventory with the ProductCode receive by params
            Inventario__c inventory = [SELECT Id,Name,Cantidad_apart__c FROM Inventario__c WHERE Product__r.ProductCode =: prodCode LIMIT 1];
            return inventory.Cantidad_apart__c;
        } else {
            return 0;
        }
    }

    @InvocableMethod(label='StockEmptyAlert')
     public static void StockEmptyAlert(){
        QuotationHelper qh = new QuotationHelper();
        List<Inventario__c> prodInInventory = qh.getAllInventario();
        List<FeedItem> feed = new List<FeedItem>();
        
        for(Inventario__c InventItem :prodInInventory){
            if(InventItem.Cantidad_dis__c == 0){
                //Post to chatter
                FeedItem objPost = new FeedItem();
	        	objPost.ParentId = UserInfo.getUserId();
                objPost.Body = 'Producto sin Inventario';
                feed.add(objPost);
            }
        }
    }
}