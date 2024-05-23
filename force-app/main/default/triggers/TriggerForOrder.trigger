/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger TriggerForOrder on Order (before insert,before update) {

    if(trigger.isinsert){
        if(Trigger.isBefore){
            OrderHandler.setStatusOpen(Trigger.New);
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore)
        OrderHandler.setStatusOnHold(Trigger.New);   
    }

}