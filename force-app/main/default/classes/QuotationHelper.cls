public class QuotationHelper implements QuotationSync{

    public static void initialConfig() {
        //Create 2 Accounts
        try{
            List<Account> accounts = new List<Account>{new Account(Name='Compumundo'),
                                                    new Account(Name='Compuworld')};
        	insert accounts;   
        }catch(DmlException ex){
            ex.getMessage();
        }
    }

    public static List<Inventario__c> getAllInventario() {
        //Get all Inventories
        return [SELECT Id,Name, Codigo_Prod__c, Cantidad_dis__c, Cantidad_apart__c, Product__c FROM Inventario__c LIMIT 200];
    }

    public static List<Product2> productsInInventory() {
        //Get all Inventories throw getAllInventario method
        List<Inventario__c> inventario = getAllInventario();
        List<Product2> prodInInvent = new List<Product2>();
        //Get Product related to each Inventary record
        for (Inventario__c inv : inventario) {
            Product2 prod = [SELECT Id,Name FROM Product2 WHERE Id =:inv.Product__c];
            //Add to List<Product2> prodInInvent
            prodInInvent.add(prod);
        }
        return prodInInvent;
    }

    public static Boolean confirmProductExistByCode(String prodCode) {
        //Get product with the ProductCode receive by params
        List<Product2> products = [SELECT Id,Name FROM Product2 WHERE ProductCode =: prodCode];
        //Validate if exist 1 product
        if(products.size() > 0){
            return true;
        }else{
            return false;
        }
    }

    @AuraEnabled(Cacheable = true)
    public static List<PriceBookEntry> searchPBE(String prodCode){
        Boolean prodExist = QuotationHelper.confirmProductExistByCode(prodCode);
        List<PricebookEntry> pbe = new List<PricebookEntry>();
        if (prodExist) {
            //Get products in an inventory with the ProductCode receive by params
            pbe = [SELECT Id,UnitPrice, ProductCode FROM PricebookEntry WHERE Product2.ProductCode =: prodCode LIMIT 1];
            return pbe;
        } else {
            return pbe;
            
        }
    }

    @AuraEnabled(Cacheable = true)
    public static Product2 searchProductByCode(String prodCode) {       
        //Get products with the ProductCode receive by params
        Product2 prod = [SELECT Id,Name,ProductCode FROM Product2 WHERE ProductCode LIKE :prodCode]; 
        if (prod!=null) { 
            return prod;
        } else {
            throw new AuraHandledException('Lo siento, el código del producto no se encuentra registrado');
        }
    }

    public static Double searchCantDisponibleByCode(String prodCode) {
        Boolean prodExist = confirmProductExistByCode(prodCode);
        if (prodExist) {
            //Get products in an inventory with the ProductCode receive by params
            Inventario__c inventory = [SELECT Id,Name,Cantidad_dis__c FROM Inventario__c WHERE Product__r.ProductCode =: prodCode LIMIT 1];
            return inventory.Cantidad_dis__c;
        } else {
            return 0;
        }
    }

    public static Double searchCantApartadaByCode(String prodCode) {
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
        List<Inventario__c> prodInInventory = QuotationHelper.getAllInventario();
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
         insert feed;
    }
}