/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global  class AccountBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc){
        String q='SELECT ID,Name,CreatedDate FROM Account WHERE CreatedDate >=LAST_N_DAYS:10';
        return Database.getQueryLocator(q);
    }
    global void execute(Database.BatchableContext bc, List<Account> accList){
        //Process the record;
        if(!accList.isEmpty() || accList.size()>0 ){
            delete accList;
        }
    }
    global void finish(Database.BatchableContext bc){
    }
    global void execute(SchedulableContext sc){
        AccountBatch ab=new AccountBatch();
        Database.executeBatch(ab);
    }
   
   
}