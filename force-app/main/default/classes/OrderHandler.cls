/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public  class OrderHandler {
   //The initial value for Order Status should be Open.
   public static void setStatusOpen(List<Order> newList){
    for(Order odr:newList){
        odr.status='Open';
    }
   }
   
   public static void setStatusOnHold(List<Order> newList){
    for(Order odr:newList){
       if(odr.Status =='On Hold'){
        odr.Order_class__c ='UPPER';
       }
      
       else {
        odr.Order_class__c='LOWER';
       }
       
    }
   }
}