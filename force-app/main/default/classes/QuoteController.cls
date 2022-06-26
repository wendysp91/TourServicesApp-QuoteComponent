public class QuoteController {

    @AuraEnabled(Cacheable = true)
    public static List<Inventario__c> search(String textkey){
        textkey = '%' + textkey + '%';
        List<Inventario__c> inv = [SELECT Id,Name,Cantidad_apart__c,Cantidad_dis__c,Product__r.Name, Product__r.ProductCode FROM Inventario__c WHERE Product__r.ProductCode LIKE :textkey]; 
        if (inv.size()>0) { 
            return inv;
        } else {
            throw new AuraHandledException('Lo siento, el código del producto no se encuentra registrado');
        }
    }
    public static Product2 product(String code){
        code = '%' + code + '%';
        Product2 prod = [SELECT Id,Name,ProductCode FROM Product2 WHERE ProductCode LIKE :code]; 
        if (prod!=null) { 
            return prod;
        } else {
            throw new AuraHandledException('Lo siento, el código del producto no se encuentra registrado');
        }
    }
    @AuraEnabled
    public static Boolean save( Double quantity, String code, String recordId){
        try {
            Product2 prod = QuotationHelper.searchProductByCode(code);
            PriceBookEntry pbe = [SELECT Id,UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode LIKE :code LIMIT 1];
            QuoteLineItem newQli = new QuoteLineItem(Product2Id = prod.Id, 
                                                     QuoteId = recordId, 
                                                     pricebookentryId = pbe.Id, 
                                                     Quantity = quantity, 
                                                     UnitPrice = pbe.UnitPrice);
            insert newQli; 
            return true;
        } catch(Exception e) {
           return false;
        }
    }
}