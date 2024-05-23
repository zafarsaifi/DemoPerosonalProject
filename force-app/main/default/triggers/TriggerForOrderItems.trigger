/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger TriggerForOrderItems on OrderItem (before insert,before update,before delete,after insert,after update) {
 
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
           // OrderItemHandler.automationQuantityDelivered(Trigger.New);
        }
        if(Trigger.isAfter){
            OrderItemHandler.changeStatusOfOrder(Trigger.New, Trigger.Old);
        }
    }
    if(Trigger.isInsert){
        if(trigger.isBefore){
         //   OrderItemHandler.beforeInsetOpen(Trigger.New);
        }
    }
    if(Trigger.isDelete){
        if(Trigger.isBefore){
         //   OrderItemHandler.checkForDeletion(Trigger.old); 
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            //OrderItemHandler.preventEditing(Trigger.New);  
        }
        if(Trigger.isAfter){
           // OrderItemHandler.updateOrderStatus(Trigger.New);
        }
    }
   
    

}