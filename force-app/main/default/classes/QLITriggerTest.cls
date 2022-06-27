@IsTest
public class QLITriggerTest {
@IsTest
    public static void InsertTriggerTest(){
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
      
        PricebookEntry pb = new PricebookEntry();
        pb.Product2Id = pr.Id;
        pb.PriceBook2Id = Test.getStandardPricebookId();
        pb.UnitPrice = 21;
        pb.UseStandardPrice = false;
        pb.isActive=true;
        insert pb; 
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c invBefore = new Inventario__c();
        invBefore = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        QuoteLineItem qli = new QuoteLineItem();
        qli.UnitPrice=21;
        qli.Quantity=10;
        qli.QuoteId=qta.id;
        qli.PricebookEntryId=pb.id;
        qli.Product2Id = producto.Id;
        Double quantOld = qli.Quantity;

        Test.startTest();
        insert qli;
        Test.stopTest();
        Inventario__c invAfter = new Inventario__c();
        invAfter = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        System.assertEquals(quantOld + invBefore.Cantidad_apart__c, invAfter.Cantidad_apart__c, 'si coinciden');
        System.assertEquals(invBefore.Cantidad_dis__c-quantOld, invAfter.Cantidad_dis__c, 'si coinciden');
    }
    
    @IsTest
    public static void UpdateTriggerTest(){
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
      
        PricebookEntry pb = new PricebookEntry();
        pb.Product2Id = pr.Id;
        pb.PriceBook2Id = Test.getStandardPricebookId();
        pb.UnitPrice = 21;
        pb.UseStandardPrice = false;
        pb.isActive=true;
        insert pb; 
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c invBefore = new Inventario__c();
        invBefore = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        QuoteLineItem qli = new QuoteLineItem();
        qli.UnitPrice=21;
        qli.Quantity=10;
        qli.QuoteId=qta.id;
        qli.PricebookEntryId=pb.id;
        qli.Product2Id = producto.Id;
        Double quantOld = qli.Quantity;
		insert qli;
        qli.Quantity = 15;
        Test.startTest();
        update qli;
        Test.stopTest();
        Inventario__c invAfter = new Inventario__c();
        invAfter = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        System.assertEquals((qli.Quantity-quantOld) + invBefore.Cantidad_apart__c + quantOld, invAfter.Cantidad_apart__c, 'si coinciden');
        System.assertEquals(invBefore.Cantidad_dis__c-(qli.Quantity-quantOld)-quantOld, invAfter.Cantidad_dis__c, 'si coinciden');
    }
    @IsTest
    public static void WrongInsertTriggerTest(){
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
      
        PricebookEntry pb = new PricebookEntry();
        pb.Product2Id = pr.Id;
        pb.PriceBook2Id = Test.getStandardPricebookId();
        pb.UnitPrice = 21;
        pb.UseStandardPrice = false;
        pb.isActive=true;
        insert pb; 
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c invBefore = new Inventario__c();
        invBefore = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        QuoteLineItem qli = new QuoteLineItem();
        qli.UnitPrice=21;
        qli.Quantity=50;
        qli.QuoteId=qta.id;
        qli.PricebookEntryId=pb.id;
        qli.Product2Id = producto.Id;
        Double quantOld = qli.Quantity;
        try
        {
            insert qli;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('La cantidad en la cotizacion debe ser menor que la cantidad disponible en inventario') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);  
        } 
    }
    
    @IsTest
    public static void WrongUpdateTriggerTest(){
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
      
        PricebookEntry pb = new PricebookEntry();
        pb.Product2Id = pr.Id;
        pb.PriceBook2Id = Test.getStandardPricebookId();
        pb.UnitPrice = 21;
        pb.UseStandardPrice = false;
        pb.isActive=true;
        insert pb; 
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 15;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c invBefore = new Inventario__c();
        invBefore = [SELECT Id,Name,Cantidad_apart__c, Cantidad_dis__c FROM Inventario__c WHERE Product__c =: producto.Id];

        QuoteLineItem qli = new QuoteLineItem();
        qli.UnitPrice=21;
        qli.Quantity=10;
        qli.QuoteId=qta.id;
        qli.PricebookEntryId=pb.id;
        qli.Product2Id = producto.Id;
        Double quantOld = qli.Quantity;
		insert qli;
        qli.Quantity = 30;
        try
        {
            update qli;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown =  e.getMessage().contains('La cantidad en la cotizacion debe ser menor que la cantidad disponible en inventario') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);  
        }
    }
}