global class ScheduleGetData implements Schedulable{
    public static String sch = '0 30 0 1/1 * ? *';

    global void execute(SchedulableContext sc){
    	InventoryDataScheduler.ExternalLegacyConnection();
    }
    
}