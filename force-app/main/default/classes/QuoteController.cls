public class QuoteController {
    @AuraEnabled(Cacheable = true)

    public static List<Inventario__c> buscar(String textkey){
        textkey = '%' + textkey + '%';

        List<Inventario__c> inv = [SELECT Id,Name,Cantidad_apart__c,Cantidad_dis__c,Product__r.Name, Product__r.ProductCode FROM Inventario__c WHERE Name LIKE :textkey];  
        /*PriceBookEntry pbe = [SELECT UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode  LIKE :textkey LIMIT 1];
        Plantillalwc__c plantilla = new Plantillalwc__c();
        Plantillalwc__c plantillalwc = new Plantillalwc__c();

        plantilla.ProductName__c = inv.Product__r.Name;
        plantilla.ProductCodigo__c = inv.Product__r.ProductCode;
        plantilla.ProductUnitPrice__c = pbe.UnitPrice;
        plantilla.InventarioCantDisp__c = inv.Cantidad_dis__c;
        plantilla.InventarioCantApart__c = inv.Cantidad_apart__c;

        insert plantilla;
         
        plantillalwc=[SELECT ProductName__c,ProductCodigo__c,ProductUnitPrice__c,InventarioCantDisp__c,InventarioCantApart__c FROM Plantillalwc__c WHERE ProductCodigo__c LIKE:textkey];
       */
        return inv;

    }
   /* public void guardar(){
        try{
            QuotationHelper qh = new QuotationHelper();
            prod = qh.searchProductByCode(codigo);
            cantApart = qh.searchCantApartadaByCode(codigo);
            pbe = [SELECT Id,UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode =: codigo LIMIT 1];
            quoteId = ApexPages.currentPage().getParameters().get('id');
            QuoteLineItem newQli = new QuoteLineItem(Product2Id = prod.Id, 
                                                     QuoteId = quoteId, 
                                                     pricebookentryId = pbe.Id, 
                                                     Quantity = quantity, 
                                                     UnitPrice = pbe.UnitPrice);
            insert newQli;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Cotizacion creada exitosamente!'));
        }catch(DmlException ex){
            ex.getMessage();
        }
    }
    
    public void atras(){
        prod.clear();
        inv.clear();
        pbe.clear();
    }*/
}