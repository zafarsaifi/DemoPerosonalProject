public class TaskTringgerHandler {
    
    public static void counterTaskwithStatus(List<Task> newTaskList ,List<Task> oldTaskList){
        Map<Id,Task> leadIdVsTaskMap=new Map<Id,Task>();
        for(Task t:newTaskList){
            if(t.WhoId != null && t.Subject=='Email' ){
                 leadIdVsTaskMap.put(t.whoId,t);              
            }
          
        }
          for(Task t1:oldTaskList){
            if(t1.WhoId != null && t1.Subject=='Email') {
                 leadIdVsTaskMap.put(t1.whoId,t1);              
            }
          
        }
        
        Map<Id,lead> leadMap =new Map<Id,Lead>([SELECT Id,Task_Counter__c FROM Lead WHERE Id IN :leadIdVsTaskMap.keySet()]);
    }

}