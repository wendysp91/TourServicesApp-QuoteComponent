@IsTest
public class QuotationHelperTest {
	@IsTest
    public static void initialConfigTest(){
        Test.startTest();
        QuotationHelper.initialConfig();
        Test.stopTest();
        Account account1 = [SELECT Name FROM Account WHERE Name = 'Compumundo'];
        Account account2 = [SELECT Name FROM Account WHERE Name = 'Compuworld'];

        System.assertEquals('Compumundo', account1.Name, 'si coinciden');
        System.assertEquals('Compuworld', account2.Name, 'si coinciden');
    }
    
    @IsTest
    public static void getAllInventarioTest(){
        List<Inventario__c> inventarios = new List<Inventario__c>();
        
        for(integer i=0; i<10; i++){
            Inventario__c element = new Inventario__c();
            element.Name = 'Inv'+i;
            element.Codigo_Prod__c = 'cod'+i;
            element.Product__c ='01tIY000000V5DnYAK';
            element.Cantidad_dis__c = 5;
            element.Cantidad_apart__c = 0;
            
            inventarios.add(element);
        }
        insert inventarios;
        Test.startTest();
        List<Inventario__c> real = QuotationHelper.getAllInventario();
        Test.stopTest();
        
        System.assertEquals(10, real.size(), 'si coinciden');
    }
    @IsTest
    public static void productsInInventoryTest(){
        Product2 prod1 = new Product2();
        prod1.Name = 'Prod01';
        prod1.ProductCode ='code01';
        insert prod1;
        Product2 producto1 = [SELECT Id FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        Product2 prod2 = new Product2();
        prod2.Name = 'Prod02';
        prod2.ProductCode ='code02';
        insert prod2;
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto1.Id;
        insert inv;
        
        Test.startTest();
        List<Product2> real = QuotationHelper.productsInInventory();
        Test.stopTest();
        
        System.assertEquals(1, real.size(), 'si coinciden');
    }
    @IsTest
    public static void confirmProductExistByCodeTest(){
        
        Product2 element = new Product2();
        element.Name = 'Prod01';
        element.ProductCode ='code01';
        insert element;
        
        Test.startTest();
        Boolean existe = QuotationHelper.confirmProductExistByCode('code01');
        Boolean noExiste = QuotationHelper.confirmProductExistByCode('code02');
        Test.stopTest();
        
        System.assertEquals(true, existe, 'si coinciden');
        System.assertEquals(false, noExiste, 'si coinciden');
    }
    @IsTest
    public static void searchPBETest(){
        Product2 pr = New Product2();
        pr.Name='test';
        pr.IsActive=true;
        pr.ProductCode ='code01';
        insert pr;
        Product2 producto = [SELECT Id, Name From Product2];
      
        PricebookEntry pb = new PricebookEntry();
        pb.Product2Id = pr.Id;
        pb.PriceBook2Id = Test.getStandardPricebookId();
        pb.UnitPrice = 21;
        pb.UseStandardPrice = false;
        pb.isActive=true;
        insert pb; 
        
        List<PriceBookEntry> noexiste = new List<PriceBookEntry>();
        List<PriceBookEntry> pbetest = [SELECT Id,UnitPrice, ProductCode FROM PricebookEntry WHERE Product2.ProductCode = 'code01'];
        Test.startTest();
        List<PriceBookEntry> pbe = QuotationHelper.searchPBE('code01');
        List<PriceBookEntry> nopbe = QuotationHelper.searchPBE('code02');
        Test.stopTest();
        
        System.assertEquals(pbe, pbetest, 'si coinciden');
        System.assertEquals(nopbe, noexiste, 'si coinciden');
    }
    @IsTest
    public static void searchProductByCodeTest(){
        Product2 element = new Product2();
        element.Name = 'Prod01';
        element.ProductCode ='code01';
        insert element;
        Product2 producto = [SELECT Product2.ExternalId, Product2.Name, Product2.ProductCode FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        Test.startTest();
        Product2 real = QuotationHelper.searchProductByCode('code01');
        Test.stopTest();
        System.assertEquals(producto, real, 'si coinciden');
    }
    @IsTest
    public static void searchCantDisponibleByCodeTest(){
        Product2 prod = new Product2();
        prod.Name = 'Prod01';
        prod.ProductCode ='code01';
        insert prod;
        Product2 producto = [SELECT Id FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c inventario = [SELECT Id,Name,Cantidad_dis__c FROM Inventario__c WHERE Product__r.ProductCode = 'code01'];
        
        Test.startTest();
        Double real = QuotationHelper.searchCantDisponibleByCode('code01');
        Double noExiste = QuotationHelper.searchCantDisponibleByCode('code02');
        Test.stopTest();
        System.assertEquals(inventario.Cantidad_dis__c, real, 'si coinciden');
        System.assertEquals(0, noExiste, 'si coinciden');
    }
    @IsTest
    public static void searchCantApartadaByCodeTest(){
        Product2 prod = new Product2();
        prod.Name = 'Prod01';
        prod.ProductCode ='code01';
        insert prod;
        Product2 producto = [SELECT Id FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 30;
        inv.Product__c = producto.Id;
        insert inv;
        Inventario__c inventario = [SELECT Id,Name,Cantidad_apart__c FROM Inventario__c WHERE Product__r.ProductCode = 'code01'];
        
        Test.startTest();
        Double real = QuotationHelper.searchCantApartadaByCode('code01');
        Double noExiste = QuotationHelper.searchCantApartadaByCode('code02');
        Test.stopTest();
        System.assertEquals(inventario.Cantidad_apart__c, real, 'si coinciden');
        System.assertEquals(0, noExiste, 'si coinciden');
    }
    @IsTest
    public static void StockEmptyAlertTest(){
        Product2 prod = new Product2();
        prod.Name = 'Prod01';
        prod.ProductCode ='code01';
        insert prod;
        Product2 producto = [SELECT Id FROM Product2 WHERE Product2.ProductCode = 'code01'];
        
        List<Inventario__c> inventarios = new List<Inventario__c>();
        for(integer i=0; i<10; i++){
            Inventario__c element = new Inventario__c();
            element.Name = 'Inv'+i;
            element.Codigo_Prod__c = 'cod'+i;
            element.Product__c = producto.Id;
            element.Cantidad_dis__c = 5;
            element.Cantidad_apart__c = 2;
            inventarios.add(element);
        }
        Inventario__c inv = new Inventario__c();
        inv.Name = 'Inv01';
        inv.Codigo_Prod__c = 'codigo';
        inv.Cantidad_apart__c = 10;
        inv.Cantidad_dis__c = 0;
        inv.Product__c = producto.Id;
        inventarios.add(inv);
        
        insert inventarios;
        Test.startTest();
        QuotationHelper.StockEmptyAlert();
        Test.stopTest();
        List<FeedItem> feed = [SELECT ID FROM FeedItem];

        System.assertEquals(1, feed.size(), 'si coinciden');
    }
}