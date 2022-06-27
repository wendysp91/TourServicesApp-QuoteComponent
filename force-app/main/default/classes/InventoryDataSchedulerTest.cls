@IsTest
public class InventoryDataSchedulerTest {
    public static String CRON_EXP = '0 55 19 27 6 ? 2022';
    
	@IsTest
    public static void ExternalLegacyConnectionTest(){
        Test.setMock(HttpCalloutMock.class, new ResponseMock()); 
        Test.startTest();
        InventoryDataScheduler.ExternalLegacyConnection();
        Test.stopTest();
        List<Inventario__c> inventarios = [SELECT Id FROM Inventario__c];
        System.assertEquals(3, inventarios.size(), 'si coincide el size de la lista');
    }
    
    @IsTest
    public static void ScheduleJobTest(){
        Test.setMock(HttpCalloutMock.class, new ResponseMock()); 
         
        //Test.setMock(InventoryDataSchedulerInterface.class, new InventoryDataSchedulerMock()); 
        ScheduleGetData data = new ScheduleGetData();
        Test.startTest();
        String jobId = System.schedule('InventoryDataSchedulerN1',CRON_EXP,data);
        

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);
        
        
        //data.execute(null);
        Test.stopTest();
        CronTrigger job = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType, CronTrigger.TimesTriggered,  
                           CronTrigger.State FROM CronTrigger ORDER BY CreatedDate DESC LIMIT 1];
        //List<Inventario__c> inventarios = [SELECT Id FROM Inventario__c];
        //System.assertEquals(3, inventarios.size(), 'si coincide el size de la lista');
        System.assertEquals(jobId, job.Id , 'Se completo el job');
        System.assertEquals('WAITING', job.State, 'Se ejecuto el job');
        
    }
}