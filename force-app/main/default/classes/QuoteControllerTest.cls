@IsTest
public class QuoteControllerTest {
@IsTest
    public static void searchTest(){
        Product2 prod = new Product2();
        prod.Name = 'Prod01';
        prod.ProductCode ='code01';
        insert prod;
        Product2 producto = [SELECT Id FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        Inventario__c invent = new Inventario__c();
        invent.Name = 'Inv01';
        invent.Codigo_Prod__c = 'code01';
        invent.Cantidad_apart__c = 10;
        invent.Cantidad_dis__c = 30;
        invent.Product__c = producto.Id;
        insert invent;
        
        List<Inventario__c> inventario = [SELECT Id,Name,Cantidad_apart__c,Cantidad_dis__c,Product__r.Name, Product__r.ProductCode FROM Inventario__c WHERE Product__r.ProductCode = 'code01'];
        
        Test.startTest();
        List<Inventario__c> real = QuoteController.search('code01');
        Test.stopTest();
        System.assertEquals(real, inventario, 'si coinciden');
    }
    @IsTest
    public static void saveTest(){
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
        pr.ProductCode = 'codigo';
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

        Test.startTest();
        Boolean inserted = QuoteController.save(5, 'codigo', qta.Id);
        Boolean notInserted = QuoteController.save(5, 'otro', qta.Id);

        Test.stopTest();

        System.assertEquals(inserted, true, 'si coinciden');
        System.assertEquals(notInserted, false, 'si coinciden');

    }
}