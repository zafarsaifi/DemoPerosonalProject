/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public  class OpportunityHandler {

    //1Method For To Make A new Opportunity as primary Opportunity(Before Insert)
 public static void primaryCheckbox(List<Opportunity> newOppList){

    List<Opportunity> listOldOpp =[SELECT Id,PrimaryCheck__c FROM Opportunity WHERE PrimaryCheck__c=true];
    for(Opportunity op :listOldOpp){
      op.PrimaryCheck__c =false;
    }
     update listOldOpp;

    for(Opportunity op1:newOppList){
          op1.PrimaryCheck__c =true;
     }
   
  

 }
   public static void fillLookUpOpportunity(List<Opportunity> newOppList){
      List<Account> AcclistWithLookUp=new List<Account>();
      for(Opportunity op:newOppList){
         if(op.AccountId !=null  && op.PrimaryCheck__c==true){
            Account acc=new Account();
            acc.id=op.AccountId;
            acc.Opportunity__c =op.Id;
            AcclistWithLookUp.add(acc);
         }
        
      }
      if(!AcclistWithLookUp.isEmpty()){
         update AcclistWithLookUp;
      }
    
   }
   public static void beforeupdate(List<Opportunity> newList, Map<Id,Opportunity> oldMap){
    for(Opportunity op:newList){
     if(oldMap !=null && op.StageName !=oldMap.get(op.id).StageName && op.PrimaryCheck__c==true)
     {
       if(op.StageName =='closed lost')
      op.PrimaryCheck__c =false;
     }
    }
   }
// Deletion of Record,
   public static void afterDeleteFillLookUpOpportunity(List<Opportunity> oldlistOpp){
     
      Set<Id> accIdSet=new Set<Id>();
     Map<Id,Account> IdvsAccMap=new Map<Id,Account>();
      for(Opportunity op:oldlistOpp){
         if(op.AccountId !=null ){
             accIdSet.add(op.AccountId);
         }  
      }    
      List<Opportunity> oppList=[SELECT Id, AccountId,PrimaryCheck__c,Account.Opportunity__c FROM Opportunity WHERE AccountId IN:accIdSet Order by CreatedDate DESC limit 1];
    for(Opportunity op1:oppList){ 
         if(!IdvsAccMap.containsKey(op1.AccountId)){
            IdvsAccMap.put(op1.AccountId,new Account(id=op1.AccountId, Opportunity__c =op1.Id));
            System.debug('MapData1->'+IdvsAccMap.values());
          } else {
            IdvsAccMap.put(op1.AccountId,new Account(id=op1.AccountId, Opportunity__c =op1.Id));
            System.debug('MapData2->'+IdvsAccMap.values());
         }
      }
      System.debug('MapData3->'+IdvsAccMap.values());
      if(!IdvsAccMap.isEmpty()){
         try{

       update IdvsAccMap.values();
         }catch(DmlException e){
            System.debug('DML Error->'+e.getMessage() +''+e.getLineNumber());
         }
       
         System.debug('MapData4->'+IdvsAccMap.values());
      }
   }
  public static void totalOppInAccount(List<Opportunity> newOpp,List<Opportunity> oldOpp){
   Set<Id> accIdSet=new Set<id>();
   Map<Id,Account> updateMapAccount =new Map<Id,Account>();
   if(newOpp !=null){
      for(Opportunity op1:newOpp){
         if(op1.AccountId !=null){
            accIdSet.add(op1.AccountId);
         }
      }
   }
   if(oldOpp !=null){
      for(Opportunity op1:oldOpp){
         if(op1.AccountId !=null){
            accIdSet.add(op1.AccountId);
         }
      }
   }

   for(Opportunity op1:[SELECT Id,AccountId,StageName,Amount,Account.AnnualRevenue,Account.Total_Opportunity__c,Account.close_Opportunity__c,Account.won_Opportunity__c FROM Opportunity WHERE AccountId IN:accIdSet]){
      Decimal totalOpp=0;
      Decimal closeOpp=0;
      Decimal wonOpp=0;
      Decimal total=0;
      if(!updateMapAccount.containsKey(op1.AccountId)){
         totalOpp++;
         total +=op1.Amount;
        if(op1.StageName =='closed Lost')
         closeOpp++;
        if(op1.StageName =='closed won')
         wonOpp++;
        updateMapAccount.put(op1.AccountId,new Account(id=op1.AccountId,AnnualRevenue =total,Total_Opportunity__c=totalOpp,close_Opportunity__c=closeOpp,won_Opportunity__c=wonOpp));
      }
      else {
          totalOpp=updateMapAccount.get(op1.AccountId).Total_Opportunity__c;
          closeOpp=updateMapAccount.get(op1.AccountId).close_Opportunity__c;
          wonOpp=updateMapAccount.get(op1.AccountId).won_Opportunity__c;
          total +=updateMapAccount.get(op1.AccountId).AnnualRevenue;
            totalOpp++;
            total +=op1.amount;
           if(op1.StageName =='closed Lost')
            closeOpp++;
           if(op1.StageName =='closed won')
            wonOpp++;
           updateMapAccount.put(op1.AccountId,new Account(id=op1.AccountId,AnnualRevenue=total,Total_Opportunity__c=totalOpp,close_Opportunity__c=closeOpp,won_Opportunity__c=wonOpp));
         }
      }
      if(updateMapAccount !=null){
       update  updateMapAccount.values();
      }
   }
//Write a trigger Whenever an Opportunity is created,Updated,deleted then Roll-up the Opportunity AMount to Account
//Anual Revenue
             public static void afterInsertAnnualRevenueInAcc(List<Opportunity> newList){
               Set<Id> accIdSet=new Set<Id>();
               List<Account> updateAccountList=new List<Account>();
               for(Opportunity op:newList){
                  if(op.AccountId !=null){
                     accIdSet.add(op.AccountId);
                  }
               }
               updateAccountList=calculateAnnualRevenue(accIdSet);
               if(!updateAccountList.isEmpty()){
                  update updateAccountList; 
               }
             }
             public static void afterUpdateAnnualRevenueInAcc(List<Opportunity> newList,Map<Id,Opportunity> oldMap){
               Set<Id> accIdSet=new Set<Id>();
               List<Account> updateAccountList=new List<Account>();
               for(Opportunity op:newList){
                  if(oldMap !=null && op.Amount !=oldMap.get(op.Id).Amount){
                     accIdSet.add(op.AccountId);
                  }
               }
               updateAccountList=calculateAnnualRevenue(accIdSet);
               if(!updateAccountList.isEmpty()){
                  update updateAccountList; 
               }
             }
             public static void afterDeleteAnnualRevenueInAcc(List<Opportunity> oldList){
               Set<Id> accIdSet=new Set<Id>();
               List<Account> updateAccountList=new List<Account>();
               for(Opportunity op:oldList){
                  if(op.AccountId !=null){
                     accIdSet.add(op.AccountId);
                  }
               }
               updateAccountList=calculateAnnualRevenue(accIdSet);
               if(!updateAccountList.isEmpty()){
                  update updateAccountList; 
               }
             }

             public static List<Account> calculateAnnualRevenue(Set<Id> accIdSet){
               List<Account> updateAccList=new List<Account>();
               Map<Id,Decimal> accIdVsAmountMap=new  Map<Id,Decimal>();
               Decimal total=0;
               for(Opportunity op:[SELECT Id,Amount,AccountId FROM Opportunity WHERE AccountId IN:accIdSet ]){
                  if(accIdVsAmountMap.containsKey(op.AccountId)){
                     total=accIdVsAmountMap.get(op.AccountId);
                  }
                  if(op.Amount !=null){
                     total=total+op.Amount;
                  }
                  accIdVsAmountMap.put(op.AccountId, total);
               }
               if(!accIdVsAmountMap.isEmpty()){
                  for(Id i:accIdVsAmountMap.keySet()){
                     Account acc=new Account();
                     acc.id=i;
                     acc.AnnualRevenue=accIdVsAmountMap.get(i);
                     updateAccList.add(acc);
                  }
               }
             return updateAccList;
               
             }
             //update Version ofcalculateAnnualRevenue
             public static List<Account> calculateAnnualRevenue1(Set<Id> accIdSet){
               List<Account> updateAccList=new List<Account>();
               Map<Id,Account> accIdVsAmountMap=new  Map<Id,Account>();
               Decimal total=0;
               for(Opportunity op:[SELECT Id,Amount,AccountId FROM Opportunity WHERE AccountId IN:accIdSet ]){
                  if(!accIdVsAmountMap.containsKey(op.AccountId)){
                     total=op.Amount;
                     accIdVsAmountMap.put(op.AccountId, new Account(Id=op.AccountId ,AnnualRevenue=total));
                  }
                 else {
                  total=accIdVsAmountMap.get(op.AccountId).AnnualRevenue;
                  total =op.Amount;
                  accIdVsAmountMap.put(op.AccountId,new Account(Id=op.AccountId, AnnualRevenue =total));
                 }
                 
               }
               if(!accIdVsAmountMap.isEmpty()){
                  for(Id i:accIdVsAmountMap.keySet()){
                     Account acc=new Account();
                     acc.id=i;
                     acc.AnnualRevenue=accIdVsAmountMap.get(i).AnnualRevenue;
                     updateAccList.add(acc);
                  }
               }
             return updateAccList;
               
             }
             //New Method
             public static void updateActivationDate1(List<Opportunity> oppList){
               for(Opportunity o:oppList){
                  if(o.StageName =='closed Won'){
                     o.Activation_Date__c=System.today();
                  }
               }
             }
             public static void updateActivationDate(List<Opportunity> oppList,Map<Id,Opportunity> oldMapData)
             { 
                   
                   Set<Id> opIdSet=new Set<Id>();
                    for(Opportunity op:oppList){

                    if(oldMapData !=null && op.StageName!=oldMapData.get(op.id).StageName){
                      if(op.StageName =='closed Won'){
                        opIdSet.add(op.Id);
                        System.debug('OpportunityId-->'+op.Id);
                       }
                     
                     }
                     System.debug('opIdSet-->'+opIdSet);
                   }
                  List<OpportunityLineItem> listOfOLI1=new List<OpportunityLineItem>();
                List<OpportunityLineItem> listOfOPL=[Select id,Tenure__c,OpportunityId,Due_Date__c, Opportunity.StageName ,Opportunity.Activation_Date__c From OpportunityLineItem WHERE OpportunityId IN:opIdSet];
                   for(OpportunityLineItem o:listOfOPL)
                   {
                     System.debug('OpportunityLineItem-->'+o);
                     if(o.Tenure__c=='3Months'){
                        //OpportunityLineItem op1=new OpportunityLineItem();
                     //   op1.id=o.id;
                         o.Due_Date__c=o.Opportunity.Activation_Date__c+90;
                        System.debug('op1--->'+o);
                        listOfOLI1.add(o);
                        System.debug('3MonthsError12345-->'+listOfOLI1); 
                     } 
                    else if(o.Tenure__c=='6Months'){
                        o.Due_Date__c=o.Opportunity.Activation_Date__c+180;
                        System.debug('op1--->'+o);
                        listOfOLI1.add(o);
                        System.debug('6MonthsError12345-->'+listOfOLI1); 
                     }
                    else if(o.Tenure__c=='12Months'){
                        o.Due_Date__c=o.Opportunity.Activation_Date__c+360;
                        System.debug('op1--->'+o);
                        listOfOLI1.add(o);
                        System.debug('12MonthsError12345-->'+listOfOLI1); 
                     }
                   }
                   System.debug('Error-->'+listOfOLI1);
                   if(!listOfOLI1.isEmpty())
                   try {
                     update listOfOLI1;
                   } catch (Exception e) {
                     System.debug('This is Catch Block todo DMLException->'+e.getMessage() +':'+e.getLineNumber());
                   } finally {
                     
                   }
                 
                   System.debug('Error1-->'+listOfOLI1);   
             }
}