public class QuoteTriggerHandler {
    public void updateQuantities(List<QuoteLineItem> quoteLineItems, Map<Id, QuoteLineItem> qliOldItems, Map<String, Inventario__c> inventarios){
        
       double cantDispUpdated, cantApartUpdated;   
        List<Inventario__c> invUpdated = new List<Inventario__c>();
        QuoteLineItem qliOldItem = new QuoteLineItem();
        //Por cada QuoteLineItem get the Inventory and update cantDisp and cantApart fields
        for(QuoteLineItem qlItem :quoteLineItems){
            //get inventories with Product id = QLIn id
            Inventario__c currentInventario = inventarios.get(qlItem.Product2Id);
            //get old QLI and its quantity
            qliOldItem = qliOldItems.get(qlItem.Id);
            Double oldQuantity = qliOldItem.Quantity;
            if (qlItem.Quantity - oldQuantity > currentInventario.Cantidad_dis__c) {
                qlItem.addError('La cantidad en la cotizacion debe ser menor que la cantidad disponible en inventario');
            } else {
            //calculate cantDip and cantApart in inventory    
            cantApartUpdated = qlItem.Quantity - oldQuantity + currentInventario.Cantidad_apart__c;
            cantDispUpdated = currentInventario.Cantidad_dis__c - (qlItem.Quantity - oldQuantity);
            //update both fields
            currentInventario.Cantidad_apart__c = cantApartUpdated;
            currentInventario.Cantidad_dis__c = cantDispUpdated;
            //update Inventory list
            invUpdated.add(currentInventario);
            }
        }
        update invUpdated;
    }
}