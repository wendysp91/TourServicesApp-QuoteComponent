@IsTest
public class QLITriggerTest {
@IsTest
    public static void TriggerTest(){
            Opportunity opp = new Opportunity();
            opp.Name='test';
            opp.CloseDate=Date.Today();
            opp.StageName='Prospecting';
            insert opp;
           
             Quote qta = new Quote();
             qta.Name='test';
             qta.opportunityid=opp.id;
        	 qta.Pricebook2Id = Test.getStandardPricebookId();
             insert qta;
           
             Product2 pr = New Product2();
             pr.Name='test';
             pr.IsActive=true;
             insert pr;
        	Product2 producto = [SELECT Id, Name From Product2];
      
             PricebookEntry pb = New PricebookEntry();
                pb.Product2Id = pr.Id;
                pb.PriceBook2Id = Test.getStandardPricebookId();
        		pb.UnitPrice = 20;
                pb.UseStandardPrice = false;
                pb.isActive=true;
                insert pb; 
        
			 QuoteLineItem qli = New QuoteLineItem();
             qli.UnitPrice=20;
             qli.Quantity=10;
             qli.QuoteId=qta.id;
             qli.PricebookEntryId=pb.id;
             insert qli;
        Double quantOld = qli.Quantity;
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c invBefore = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        qli.Quantity = 15;
        Test.startTest();
        update qli;
        Test.stopTest();
        Inventario__c invAfter = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        System.assertEquals(invBefore.Cantidad_apart__c+qli.Quantity-quantOld, invAfter.Cantidad_apart__c, 'si coinciden');
        System.assertEquals(invBefore.Cantidad_dis__c-qli.Quantity, invAfter.Cantidad_dis__c, 'si coinciden');
    }
}