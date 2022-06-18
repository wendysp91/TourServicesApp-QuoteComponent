@IsTest
public class InventoryDataSchedulerTest {
	@IsTest
    public static void ExternalLegacyConnectionTest(){
        Test.setMock(HttpCalloutMock.class, new ResponseMock()); 
        Test.startTest();
        InventoryDataScheduler.ExternalLegacyConnection();
        Test.stopTest();
        List<Inventario__c> inventarios = [SELECT Id FROM Inventario__c];
        System.assertEquals(3, inventarios.size(), 'si coinciden');
    }
}