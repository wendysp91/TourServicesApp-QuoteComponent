public class ScheduleGetData {
    public void ScheduleMethod(){
        InventoryDataScheduler reminder = new InventoryDataScheduler();
    String sch = '0 0 19 1/1 * ? *';
    String jobID = System.schedule('InventoryDataScheduler', sch, reminder);
    }
}