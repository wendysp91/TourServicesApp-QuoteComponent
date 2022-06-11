/*Created by Wendy Suarez */
public with sharing class AccBatchScheduleClass implements Schedulable{
    global void execute(SchedulableContext ctx) {
        BatchApexExample bae = new BatchApexExample();
        String cronStr = '20 30 8 10 2 ?';
        String jobId = System.schedule('Process Acc Records', cronStr, bae);

    }
}
