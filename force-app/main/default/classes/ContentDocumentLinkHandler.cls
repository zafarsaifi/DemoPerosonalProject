public class ContentDocumentLinkHandler {
    public static void addAFileIntoAccount(List<ContentDocumentLink> newcdl){
        Map<Id, Id> contentIdVsAccountId = new Map<Id, Id>();
        for(ContentDocumentLink cdl:newcdl){
            if(cdl.LinkedEntityId !=null && String.valueOf(cdl.LinkedEntityId).startsWith('001')){
                contentIdVsAccountId.put(cdl.contentDocumentId, cdl.LinkedEntityId);
                System.debug('cdl.LinkedEntityId ==>'+cdl.LinkedEntityId );
            }   
        }
       
        List<Contact> conlist=[SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN:contentIdVsAccountId.values() limit 49999];
        
        Map<Id, Id> conVsAccId = new Map<Id, Id>();
        List<ContentDocumentLink> contentDoc_List = new List<ContentDocumentLink>();
        for(Contact con:conlist){
            conVsAccId.put(con.Id, con.AccountId);
            for(String Ids:contentIdVsAccountId.keySet()){
                if(contentIdVsAccountId.get(Ids) == con.AccountId){
                    ContentDocumentLink contentDoc = new ContentDocumentLink();
                    contentDoc.contentDocumentId = Ids;
                    contentDoc.LinkedEntityId = con.Id;
                    contentDoc_List.add(contentDoc);
                }
            }
            
            
        }
        
        if(!contentDoc_List?.isEmpty()){
           
            insert contentDoc_List;
        }
        /*Map<Id,Account> accIdVsNumberMap=new  Map<Id,Account>();
if(!acclist.isEmpty()){
for(Account ac:acclist){
accIdVsNumberMap.put(ac.Id,ac);     
}
}*/
        /*Integer a=1;
List<Account> updateAccList=new List<Account>();
System.debug('accIdVsNumberMap==>'+accIdVsNumberMap);
for(ContentDocumentLink cdl1:newcdl){
if(accIdVsNumberMap.containsKey(cdl1.LinkedEntityId)){              
Account ac=accIdVsNumberMap.get(cdl1.LinkedEntityId);
if(  ac.OldNumber__c == null)
ac.OldNumber__c =a;
else
ac.OldNumber__c +=a+1;
System.debug('ac.OldNumber__c'+ac.OldNumber__c);
updateAccList.add(ac);
System.debug('updateAccList@@@@@@@@@=>'+updateAccList);
} 
}
System.debug('Before update Account===>'+updateAccList);
if(!updateAccList.isEmpty())
{
update updateAccList;
}

System.debug('After update Account===>'+updateAccList);
List<ContentDocumentLink> allFileListToAccount=[SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE 
LinkedEntityId IN : parentIdSet];
System.debug('All Files allFileListToAccount'+allFileListToAccount);
List<Contact> conListRelatedToAccout=[SELECT Id,Name FROM Contact WHERE  AccountId IN : parentIdSet];

List<ContentDocumentLink> insertTocdlList=new List<ContentDocumentLink>();
for(Contact con:conListRelatedToAccout){
System.debug('Contacts Data@@@@@@@@@@==>'+JSON.serializePretty(con));
for(ContentDocumentLink cdl:allFileListToAccount){
System.debug('ContentDocumentLink One By One '+JSON.serializePretty(cdl));
ContentDocumentLink cdl1=new ContentDocumentLink();
//cdl1.id=cdl.Id;
if(cdl1.ContentDocumentId !=cdl.ContentDocumentId){
cdl1.ContentDocumentId=cdl.ContentDocumentId;
cdl1.LinkedEntityId=con.id;
insertTocdlList.add(cdl1); 

}

}
System.debug('Before Insert ContentDocumentLink '+insertTocdlList);

if(!insertTocdlList.isEmpty()){
insert insertTocdlList;
} 
System.debug('After Insert ContentDocumentLink '+insertTocdlList);
}*/
        
        
        
    }
    
}