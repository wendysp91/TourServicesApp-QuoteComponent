public class QuoteControllerTest {
/*@IsTest
    public static void buscarTest(){
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
        pr.ProductCode = 'codigo001';
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
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        
        Test.startTest();
        QuoteController qc = new QuoteController(Apexpages.StandardController controller);
        qc.buscar();
        Test.stopTest();
        Inventario__c inventario = [SELECT Name,Cantidad_apart__c,Cantidad_dis__c, Product__r.Name, Product__r.ProductCode,Product__r.ExternalId  FROM Inventario__c WHERE Product__r.ProductCode ='codigo001'];
        PriceBookEntry pbEntry = [SELECT UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode = 'codigo001' LIMIT 1];
        System.assertEquals('Inv01', inventario.Name, 'si coinciden');
        System.assertEquals(20, pbEntry.UnitPrice, 'si coinciden');

    }*/
}