trigger QLITriggerAfterUpdate on QuoteLineItem (before update) {
    QuoteTriggerHandler qth = new QuoteTriggerHandler();
    List<Id> pbe = new List<Id>();
    
    //get the Product id and add it to a list
    for(QuoteLineItem qli:Trigger.New){
        pbe.add(qli.Product2Id);
    }
    //retrieve all products with id in inventory
    List<Inventario__c> inv = [SELECT Id, Name, Product__c, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c WHERE Product__c IN:pbe];
    //create a map to relate Product id with inventario record
    Map<String, Inventario__c> invMap = new Map<String, Inventario__c>();
    for(Inventario__c inventItem : inv){
        invMap.put(inventItem.Product__c,inventItem);
    }
    //call handler class 
    qth.updateQuantities(Trigger.new, Trigger.oldMap, invMap);
}