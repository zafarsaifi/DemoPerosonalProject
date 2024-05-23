/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger AllTriggerForAccount on Account (before insert, before update, before delete, after insert , after update) {

//    if(Trigger.isBefore)
//    {
//      if(Trigger.isInsert)
//        {
//          for(Account acc:Trigger.new)
//           {
//             if(acc.Industry=='Media')
//             {
//                 acc.Rating ='Hot';
//             }
//           }
//         }
//         if(Trigger.isUpdate){
//             for(Account acc:Trigger.new)
//             { 
//                 if(acc.Industry =='HealthCare'){
//                     acc.Rating ='Cold';
//                 }    
//             }
//         }
//         if(Trigger.isDelete){
//             for(Account acc:Trigger.old){
//                 if(acc.Ownership =='private')
//                 {
//                     acc.addError('you can not delete this Account becase this Account is private');
//                 }
//             }
//         }
//     }

//     if(Trigger.isAfter)
//     {
//         if(Trigger.isInsert){
//             List<Opportunity> opList =new List<Opportunity>();
//             for(Account acc:Trigger.New){
//                 Opportunity op1=new Opportunity();
//                 op1.AccountId=acc.Id;
//                 op1.Name ='First Opportunity';
//                 op1.CloseDate =System.today();
//                 op1.StageName ='prospecting';
//                 opList.add(op1);

//             }
//             if(!opList.isEmpty() && opList !=null){
//                 insert opList;
//             }
            

//         }
//         if(Trigger.isUpdate){
//             List<Contact> listCon =new List<Contact>();
//             Set<Id> contId=new Set<Id>();
//             for(Account acc:Trigger.old)
//             {
//                 if(acc.Id !=null)
//                 {
//                     contId.add(acc.Id);
//                 }
//             }
//              List<Contact> listOfContact=[SELECT ID,AccountId,LastName,Account.Name from Contact where AccountId IN: contId];
//              System.debug('ListOfContact-:'+listOfContact);
//              for(Contact con :listOfContact){
//                 COntact con1=new Contact();
//                 con1.Id=con.AccountId;
//                 con1.LastName =con.Account.Name;
//                 listCon.add(con1);
//                System.debug('Error121->'+con1);
//                update listCon; 
//              }
//             // if(!listCon.isEmpty() && listCon !=null)
//             // {
                
//             //     System.debug('Error->'+listCon);
//             // }
//          }
       
//     }


if(Trigger.isUpdate){
    if(trigger.isAfter){
        AccountHandler.updateRelatedOpportunity(Trigger.New,Trigger.oldMap);
    }
    if(Trigger.isBefore){
        AccountHandler.updateOldRecordStoreNewField(Trigger.New,Trigger.oldMap);
    }
}
if(Trigger.isDelete){
    if(Trigger.isBefore){
        AccountHandler.preventDeletionOfAccount(Trigger.old);
    }
}
}