/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger TriggerForOpportunity on Opportunity (before insert, after insert,after update,before update,before delete,after delete)
 {  
 
      If( Trigger.isUpdate)
     {
        if(Trigger.isBefore){
                //OpportunityHandler.primaryCheckbox(Trigger.New); 
                OpportunityHandler.updateActivationDate1(Trigger.New);
        }    
    
       if(Trigger.isAfter){
       // OpportunityHandler.fillLookUpOpportunity(Trigger.new);
      //  OpportunityHandler.primaryCheckbox(Trigger.New);
    
       }
    //  }
    //   if(Trigger.isDelete)
    //   {
    //     if(Trigger.isBefore){
    //      // OpportunityHandler.deletionCheckBox(Trigger.old);
    //     }
    //     if(Trigger.isAfter){
    //         OpportunityHandler.afterDeleteFillLookUpOpportunity(Trigger.old);
    //     }
    //  }

    //   if(Trigger.isUpdate)
    //   {
    //    if(Trigger.isBefore){
    //     OpportunityHandler.beforeupdate(Trigger.New,Trigger.OldMap);
    //    }
    //    if(Trigger.isAfter){
    //    //OpportunityHandler.fillLookUpOpportunity(Trigger.new);
    //   }
    // //  }
    //  if(Trigger.isInsert ||Trigger.isUpdate || Trigger.isDelete){
    //   if(Trigger.isAfter){
    //     OpportunityHandler.totalOppInAccount(Trigger.New, Trigger.Old);
    //   }
    // }
    //  if(Trigger.isInsert){
    //   if(Trigger.isAfter){
    //     OpportunityHandler.afterInsertAnnualRevenueInAcc(Trigger.New);
    //   }
    //  }
     if(Trigger.isUpdate){
      if(Trigger.isAfter){
        //OpportunityHandler.afterUpdateAnnualRevenueInAcc(Trigger.New,Trigger.oldMap);
         OpportunityHandler.updateActivationDate(Trigger.New,Trigger.oldMap);
      }
      }
    //  if(Trigger.isDelete){
    //   if(Trigger.isAfter){
    //     OpportunityHandler.afterDeleteAnnualRevenueInAcc(Trigger.old);
    //   }
    //  }
 }
}