/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-24-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public  class OrderItemHandler {
    
    //If field Quantity Delivered is greater than 0 but less than Quantity set the field Order Line Status = Partially Delivered.
    public static void automationQuantityDelivered(List<OrderItem> orderitemList){
        for(OrderItem oi:orderitemList){
            if(oi.Quantity_Delivered__c>0 && oi.Quantity_Delivered__c<oi.Quantity){
                oi.Order_Line_Status__c ='Partially Delivered';
            }          
             //If the field Quantity Delivered is 0 and Quantity is 0 set the field Order Line Status = Cancelled.
            else if(oi.Quantity_Delivered__c ==0 && oi.Quantity==0){
                oi.Order_Line_Status__c ='Cancelled';
            }
            //If the field Quantity Delivered is greater than 0 and = Quantity set the field Order Line Status = Completed
            else  if(oi.Quantity_Delivered__c>0 && oi.Quantity_Delivered__c==oi.Quantity){
                oi.Order_Line_Status__c ='Complete';
          }
        }
    }
    public static void beforeInsetOpen(List<OrderItem> orderitemList){
        for(Orderitem oi :orderitemList){
            oi.Order_Line_Status__c='Open';
        }
    }
    public static void checkForDeletion(List<OrderItem> orderitemList){
        for(OrderItem oi:orderitemList){
            if(oi.Order_Line_Status__c =='Accepted' ||oi.Order_Line_Status__c =='Partially Delivered'||oi.Order_Line_Status__c =='Complete'||oi.Order_Line_Status__c =='Cancelled'){
                oi.addError('You can not remove this Order Line Item');

            }
        }
    }
  
    public static void preventEditing(List<OrderItem> orderitemList){
        for(OrderItem oi:orderitemList){
            if(oi.Order_Line_Status__c =='Complete'){
                oi.addError('You can not Edit  this Order Line Item Beacuse status is Completed');
            }
        }
    }
    public static void updateOrderStatus(List<OrderItem> listOrderItem){
        Set<Id> orderIdSet=new Set<Id>();
        List<order> listofOrder=new List<Order>();
        for(OrderItem oi:listOrderItem){   
           if(oi.Order_Line_Status__c=='Partially Delivered'){
            Order o=new Order();
            o.Id=oi.OrderId;
            o.Status='Partially Delivered';
            listofOrder.add(o);
           }
        }
        if(listofOrder !=null){
            try{
                update listofOrder;
            }catch(DmlException e){
                System.debug('Exception->'+e.getMessage());
            }      
        }
    }
    public static void changeStatusOfOrder(List<OrderItem> newList,List<OrderItem> oldList){
        Map<id,Order> orderidVsOrderMap=new Map<Id,Order>();
        Set<id> orderIdSet=new Set<Id>();
        for(Orderitem oi:newList){
            if(oi.Orderid !=null){
                orderIdSet.add(oi.OrderId);
            }
        }
        if(oldList !=null){
            for(Orderitem oi:oldList){
                if(oi.Orderid !=null){
                    orderIdSet.add(oi.OrderId);
                }
            }
        }
       
        List<OrderItem> listOfOrderItem=[SELECT id,OrderId,Order.status,Order_Line_Status__c FROM OrderItem WHERE OrderId In:orderIdSet];
      if(!listOfOrderItem.isEmpty())
        for(OrderItem oi:listOfOrderItem){
            if(oi.Order_Line_Status__c =='Complete' && (oi.Order_Line_Status__c=='Open' || oi.Order_Line_Status__c=='Accepted')){
                if(orderidVsOrderMap.containsKey(oi.OrderId)){
                    orderidVsOrderMap.put(oi.OrderId,new order(Id=oi.OrderId,Status ='Complete'));
                    System.debug('MapData1->'+orderidVsOrderMap.values());
                }
                else {
                    orderidVsOrderMap.put(oi.OrderId,new order(Id=oi.OrderId,Status ='Complete'));
                    System.debug('MapData2->'+orderidVsOrderMap.values());
                }
            }   
        }
        System.debug('MapData3->'+orderidVsOrderMap.values());
        if(!orderidVsOrderMap.isEmpty()){
            System.debug('Error->'+orderidVsOrderMap);
            update orderidVsOrderMap.values();
        }
    }
}