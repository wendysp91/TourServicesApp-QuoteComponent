public class Work {
    public void operacionDML(){
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Test 2';
        inv.Cantidad_apart__c = 3;
        inv.Codigo_Prod__c = 'PROD002';
        
        Inventario__c inv2 = new Inventario__c();
        inv2.Name = 'Test 1';
        inv2.Cantidad_apart__c = 3;
        inv2.Codigo_Prod__c	 = 'PROD001';
        
        
        List<Inventario__c> lst = new List<Inventario__c>();
        lst.add(inv);
        lst.add(inv2);
        
        insert lst;
    }
}