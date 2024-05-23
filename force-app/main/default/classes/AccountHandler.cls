public class AccountHandler {

    //Method for  Q2. Write a trigger to update the city field in all the 
    //related opportunities when the city field is updated in Account

    public static void updateRelatedOpportunity(List<Account> newList,Map<Id,Account> oldMapData){
       Map<Id,Account> accIdVsAccMap=new Map<Id,Account>();
        for(Account acc:newList){
            if(oldMapData !=null && acc.BillingCity !=oldMapData.get(acc.Id).BillingCity){
                   accIdVsAccMap.put(acc.Id,acc);
            }
        }
        List<Opportunity> opList=new List<Opportunity>();
        for(Opportunity op:[SELECT ID,AccountId,City__c FROM  Opportunity WHERE  AccountId IN:accIdVsAccMap.keySet() ]){
            Opportunity op1=new Opportunity();
            if(accIdVsAccMap.containsKey(op.AccountId)){
                op1.id=op.Id;
                op1.City__c=accIdVsAccMap.get(op.AccountId).BillingCity;
                opList.add(op1);
            }

        }
        if(opList !=null){
            update opList;
        }

    }
//Before Update
    public static void updateOldRecordStoreNewField(List<Account> newList,Map<Id,Account> oldMapData){  
        for(Account acc:newList){
            if(oldMapData !=null && acc.Phone !=oldMapData.get(acc.Id).Phone){
                 // acc.OldNumber__c = oldMapData.get(acc.Id).Phone;
                  acc.Description ='Your Phone Number is update';
             }  
        }
    } 
    //Before Delete
    public static void preventDeletionOfAccount(List<Account> oldList){
        Set<Id> accIdSet=new Set<Id>();
            for(Account acc:oldList){
                if(acc.id !=null){{
                    accIdSet.add(acc.id);
                }}
            }
            List<Contact> listOfContact=[SELECT Id,AccountId FROM Contact WHERE AccountId IN:accIdSet];
            for(Account acc:oldList){
                if(listOfContact.isEmpty()){
                    acc.addError('You can not remove this contact Because There is Noo contact Related This Account');
                }
            } 
        
    } 
}