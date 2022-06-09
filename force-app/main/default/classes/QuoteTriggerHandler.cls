public class QuoteTriggerHandler {
    public void updateQuantities(List<QuoteLineItem> quoteLineItems, Map<Id, QuoteLineItem> qliOldItems, Map<String, Inventario__c> inventarios){
        
       double cantDispUpdated, cantApartUpdated;   
        List<Inventario__c> invUpdated = new List<Inventario__c>();
        QuoteLineItem qliOldItem = new QuoteLineItem();
        
        for(QuoteLineItem qlItem :quoteLineItems){
            Inventario__c currentInventario = inventarios.get(qlItem.Product2Id);
            
            qliOldItem = qliOldItems.get(qlItem.Id);
            Double oldQuantity = qliOldItem.Quantity;
                
            cantApartUpdated = qlItem.Quantity - oldQuantity + currentInventario.Cantidad_apart__c;
            cantDispUpdated = currentInventario.Cantidad_dis__c - cantApartUpdated;
            
            currentInventario.Cantidad_apart__c = cantApartUpdated;
            currentInventario.Cantidad_dis__c = cantDispUpdated;
            
            invUpdated.add(currentInventario);
        }
        update invUpdated;
    }
}