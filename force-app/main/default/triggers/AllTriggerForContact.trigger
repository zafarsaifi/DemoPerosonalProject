/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger AllTriggerForContact on Contact (before insert, before delete , after insert, after update, after delete){
    if(Trigger.isDelete){
        if(Trigger.isbefore){
//  ContactHandlerForTrigger.checkContactActiveOrNot(Trigger.old);
        }
          
    }
    if(Trigger.isInsert || Trigger.isUpdate ||Trigger.isDelete){
        if(Trigger.isAfter){
           // ContactHandlerForTrigger.phoneUpdateInAccount(Trigger.new);
            ContactHandlerForTrigger.fillContactSalary(Trigger.New,Trigger.old);
        }
        if(Trigger.isBefore){
          // ContactHandlerForTrigger.preventDuplicateContact(Trigger.New, Trigger.oldMap);
        }
    }
}