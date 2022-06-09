trigger QLITriggerAfterUpdate on QuoteLineItem (after update) {
    QuoteTriggerHandler qth = new QuoteTriggerHandler();
    List<Id> pbe = new List<Id>();
    for(QuoteLineItem qli:Trigger.New){
        pbe.add(qli.Product2Id);
    }
    
    List<Inventario__c> inv = [SELECT Id, Name, Product__c, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c WHERE Product__c IN:pbe];
    
    Map<String, Inventario__c> invMap = new Map<String, Inventario__c>();
    for(Inventario__c inventItem : inv){
        invMap.put(inventItem.Product__c,inventItem);
    }
    qth.updateQuantities(Trigger.new, Trigger.oldMap, invMap);
}