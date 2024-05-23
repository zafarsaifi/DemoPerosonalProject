/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-31-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class ContactHandlerForTrigger {
    //1Method
    public static void checkContactActiveOrNot(List<Contact> oldConList)
    {
        for(Contact con:oldConList)
        {
            if(con.Active__c ==true)
                con.addError('You can not Delete this number');
        }
    }

    //Method 2
    public static void phoneUpdateInAccount(List<Contact> newList){
      
        List<Account> listAccount =new List<Account>();
        for(Contact con:newList)
        {
            Account acc=new Account();
            acc.id=con.AccountId;
            acc.phone =con.Phone;
            listAccount.add(acc);
            
        }
        update listAccount;
    }
//before update and before insert kam karega ye trigger,,
    public static void preventDuplicateContact(List<Contact> newList, Map<Id,Contact> oldMapData){
        for(Contact con:newList){
            if(oldMapData !=null && con.phone != oldMapData.get(con.id).phone){
                con.addError('Duplicate Number not Allowed');
            }   
        }

    }

    //1->fillContactSalary In Account (After Insert)
    public static void fillContactSalary(List<Contact> newList,List<Contact> oldList)
    {
        Set<Id> accIdSet=new Set<Id>();
        //1
        if(newList !=null){
            for(Contact newCon:newList){
                System.debug('New.Con-->'+newCon);
                System.debug('New.AcountId-->'+newCon.AccountId);
                if(newCon.AccountId !=null){
                    accIdSet.add(newCon.AccountId);
                }
            }
        }
        if(oldList !=null){
                    for(Contact oldCon:oldList){
                        if(oldCon.AccountId !=null){
                            accIdSet.add(oldCon.AccountId);
                        }
                    }
                  }
        /*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
       // list<Account> updateAccList=new list<Account>();
        Map<Id, wrapAccountAvgSalaryData> IdVsAccountWrappedDataMap = new Map<Id, wrapAccountAvgSalaryData>();
        //System.debug('Empty Map=>'+IdVsAccountMap);
        List<Contact> conList=[SELECT Id,AccountId,AgeOfCon__c,Salary__c,Account.AvgSalaryOne18To25__c, Account.AvgSalaryTwo26To35__c, Account.AvgSalaryThree36To50__c FROM Contact WHERE AccountId IN:accIdSet];
        System.debug('Query On conList->>>'+conList);
        for(Contact con :conList){
            if(!IdVsAccountWrappedDataMap.containsKey(con.AccountId)) {
                if(con.AgeOfCon__c != null && con.AgeOfCon__c >= 18 && con.AgeOfCon__c <= 25) {
                    IdVsAccountWrappedDataMap.put(con.AccountId, new wrapAccountAvgSalaryData(con.AccountId, con.Salary__c, 1, 0, 0, 0, 0));
                }
                else if (con.AgeOfCon__c != null && con.AgeOfCon__c >= 26 && con.AgeOfCon__c <= 35) {
                    IdVsAccountWrappedDataMap.put(con.AccountId, new wrapAccountAvgSalaryData(con.AccountId, 0, 0,con.Salary__c,1,0,0));
                }
                else if (con.AgeOfCon__c != null && con.AgeOfCon__c >= 36 && con.AgeOfCon__c <= 50) {
                    IdVsAccountWrappedDataMap.put(con.AccountId, new wrapAccountAvgSalaryData(con.AccountId,0,0,0,0, con.Salary__c, 1));
                }
            }
            else {
                if(con.AgeOfCon__c != null && con.AgeOfCon__c >= 18 && con.AgeOfCon__c <= 25) {
                    IdVsAccountWrappedDataMap.get(con.AccountId).salary18To25 += con.Salary__c;
                    IdVsAccountWrappedDataMap.get(con.AccountId).countContact18To25++;    
                }
                else if (con.AgeOfCon__c != null && con.AgeOfCon__c >= 26 && con.AgeOfCon__c <= 35) {
                    IdVsAccountWrappedDataMap.get(con.AccountId).salary26To35 += con.Salary__c;
                    IdVsAccountWrappedDataMap.get(con.AccountId).countContact26To35++;    
                }
                else if (con.AgeOfCon__c != null && con.AgeOfCon__c >= 36 && con.AgeOfCon__c <= 50) {
                    IdVsAccountWrappedDataMap.get(con.AccountId).salary36To50 += con.Salary__c;
                    IdVsAccountWrappedDataMap.get(con.AccountId).countContact36To50++;    
                }
            }
        }
        System.debug('IdVsAccountWrappedDataMap>>'+JSON.serializePretty(IdVsAccountWrappedDataMap));
        List<Account> updateAccList=new List<Account>();
        // for(Id i:IdVsAccountWrappedDataMap.keySet()){
        //     Account ac=new Account();
        //     ac.Id=i;
        //     ac.AvgSalaryOne18To25__c=((IdVsAccountWrappedDataMap.get(i).salary18To25)/(IdVsAccountWrappedDataMap.get(i).countContact18To25));
        //     System.debug('after Average AvgSalaryOne18To25__c-->'+JSON.serializePretty(ac.AvgSalaryOne18To25__c));
        //     ac.AvgSalaryTwo26To35__c=((IdVsAccountWrappedDataMap.get(i).salary26To35)/(IdVsAccountWrappedDataMap.get(i).countContact26To35));
        //     System.debug('after Average AvgSalaryTwo26To35__c-->'+JSON.serializePretty(ac.AvgSalaryTwo26To35__c));
        //     ac.AvgSalaryThree36To50__c=((IdVsAccountWrappedDataMap.get(i).salary36To50)/(IdVsAccountWrappedDataMap.get(i).countContact36To50));
        //     System.debug('after Average AvgSalaryThree36To50__c-->'+JSON.serializePretty(ac.AvgSalaryThree36To50__c));
        //     updateAccList.add(ac);
        // }
        if(IdVsAccountWrappedDataMap != null && !IdVsAccountWrappedDataMap.isEmpty()) {
            for(wrapAccountAvgSalaryData wrapAcc : IdVsAccountWrappedDataMap.values()) {
                updateAccList.add(new Account(Id = wrapAcc.accId,
                                            AvgSalaryOne18To25__c = (wrapAcc.salary18To25/wrapAcc.countContact18To25),
                                            AvgSalaryTwo26To35__c = (wrapAcc.salary26To35/wrapAcc.countContact26To35),
                                            AvgSalaryThree36To50__c = (wrapAcc.salary36To50/wrapAcc.countContact36To50)));
            }
        }
        
        System.debug('updateAccList->'+JSON.serializePretty(updateAccList));
        if(!updateAccList.isEmpty()){
            try {
                update updateAccList;
            } catch (DMLException e) {
                System.debug('DML ERROR Occours Here-->'+e.getMessage() +':'+e.getLineNumber());
            }
        }
    }

    public class wrapAccountAvgSalaryData {
        public Id accId;
        public Decimal salary18To25;
        public Integer countContact18To25;
        public Decimal salary26To35;
        public Integer countContact26To35;
        public Decimal salary36To50;
        public Integer countContact36To50;
        public wrapAccountAvgSalaryData (Id accId, Decimal salary18To25, Integer countContact18To25, Decimal salary26To35, Integer countContact26To35, Decimal salary36To50, Integer countContact36To50) {
            this.accId = accId;
            this.salary18To25 = salary18To25;
            this.countContact18To25 = countContact18To25;
            this.salary26To35 = salary26To35;
            this.countContact26To35 = countContact26To35;
            this.salary36To50 = salary36To50;
            this.countContact36To50 = countContact36To50;
        }
    }



        // System.debug('AccIdSet@@@@@@@@-->'+accIdSet);
        // List<Account> accList=new list<Account>();
        // accList = calculatesalary(accIdSet);
        // System.debug('AccountList->>>'+accList);

        // if(!accList.isEmpty()){
        //     update accList;
        //     System.debug('After Update AccountList->>>'+accList);
        // }
   // }
    //   //2
    //     if(!oldList.isEmpty() ||oldList !=null){
    //         for(Contact newCon:oldList){
    //             if(newCon.AccountId !=null){

    //             }
    //         }
    //       }
    //   }

        
        // //Calculate Salary Method
        // public static List<Account> calculatesalary(Set<id> accIdSet)
        // {
        //     list<Account> updateAccList=new list<Account>();
        //     Map<Id,Account> IdVsAccountMap=new Map<Id,Account>();
        //     System.debug('Empty Map=>'+IdVsAccountMap);
        //     List<Contact> conList=[SELECT Id,AccountId,AgeOfCon__c,Salary__c,Account.AvgSalaryOne18To25__c FROM Contact WHERE AccountId IN:accIdSet];
        //     System.debug('Query On conList->>>'+conList);
        //     for(Contact con:conList){
        //         Decimal d=0;
        //         Decimal count=0;
        //          Decimal AvgSal1=0;
        //         if(!IdVsAccountMap.containsKey(con.AccountId)){
        //             if(con.AgeOfCon__c>18 && con.AgeOfCon__c<25){   
        //                   count++;
        //                   System.debug('Number Of Contact Under 18 to 25->'+count);
        //                 if(con.Salary__c !=null){
        //                     d+=con.salary__c;
        //                     System.debug('Contact salary Sum->'+AvgSal1);
        //                 }
        //                 if(d!=null){
        //                     AvgSal1 =d/count;
        //                     System.debug('Average salary Of All Contact under 18 to 25->'+AvgSal1);
        //                 }

        //             }

        //             IdVsAccountMap.put(con.AccountId,new Account(id=con.AccountId,AvgSalaryOne18To25__c=AvgSal1));
        //             System.debug('If IdVsAccountMap->'+IdVsAccountMap);
        //         }
        //         else {
        //             AvgSal1=IdVsAccountMap.get(con.AccountId).AvgSalaryOne18To25__c;
        //              if(con.AgeOfCon__c>18 || con.AgeOfCon__c<25){    
        //                  count++;
        //                 if(con.Salary__c !=null){
        //                     d+=con.salary__c;
        //                 }
        //                 if(d!=null){
        //                     AvgSal1 =d/count;
        //                 }
        //             }
        //             IdVsAccountMap.put(con.AccountId,new Account(id=con.AccountId,AvgSalaryOne18To25__c=AvgSal1));
        //             System.debug('Else IdVsAccountMap->'+IdVsAccountMap);
        //         }

        //     }
        //     if(!IdVsAccountMap.isEmpty()){
        //         for(Id i:IdVsAccountMap.keySet()){
        //             Account acc=new Account();
        //             acc.id=i;
        //             acc.AvgSalaryOne18To25__c=IdVsAccountMap.get(i).AvgSalaryOne18To25__c;
        //             updateAccList.add(acc);
        //             System.debug('After Add Salary in updateAccList->'+updateAccList);
        //          }
        //     }
        //     System.debug('Return updateAccList->'+updateAccList);
        //     return updateAccList;
            
        // }
}