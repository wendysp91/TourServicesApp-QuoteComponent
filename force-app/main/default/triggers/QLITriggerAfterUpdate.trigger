trigger QLITriggerAfterUpdate on QuoteLineItem (after update) {
    QuotationHelper qh = new QuotationHelper();
    Double cantDisp, cantApartadaAfter, cantDispAfter;
    Inventario__c invUpdate = new Inventario__c();
    
    for(QuoteLineItem q : Trigger.New) {
        //Get Producto related to QuoteLineItem
        Product2 prod = [Select Id,ExternalId From Product2 Where Id =:q.Product2Id Limit 1];
        //Get Inventory related to Product
        Inventario__c inv = [Select Id,Cantidad_apart__c From Inventario__c  Where Product__c =:prod.Id Limit 1];
    
        //Get cantidad disponible trough searchProductByCode method
        cantDisp = qh.searchProductByCode(prod.ExternalId);
        //Update the numbers of cantidad apartada and cantidad disponible
        cantApartadaAfter = q.Quantity + inv.Cantidad_apart__c;
        cantDispAfter = cantDisp - cantApartadaAfter;
        //Update Cantidad_apart__c and Cantidad_dis__c fields in Inventory
        invUpdate.Cantidad_apart__c = cantApartadaAfter;
        invUpdate.Cantidad_dis__c = cantDispAfter;
    }
    
    Update invUpdate;
}