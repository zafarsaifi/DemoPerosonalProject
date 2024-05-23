public class ApexCallInFlow {
    
     @InvocableMethod
    public static List<Decimal> updateAccAnnualRevenue(List<Id> ids){
        System.debug('List Of Ids==>'+ids[0]);
        List<Opportunity> oppList=[SELECT AccountId,Amount FROM Opportunity WHERE Id =:ids[0]];
         System.debug('List<Opportunity>==>'+oppList);
        
        List<Account> accList =[SELECT AnnualRevenue,Name,Rating FROM Account WHERE Id=:oppList[0].AccountId];  
         System.debug('List<Account>==>1234'+accList);
           Double Sum=0;
         Sum +=accList[0].AnnualRevenue + OppList[0].Amount;
         accList[0].AnnualRevenue =sum;
         
         update accList;
         System.debug('accList[0].AnnualRevenue==>'+ accList[0].AnnualRevenue);
        
        List<Decimal> updateAccAnnualRevenueList=new List<Decimal>();  
        updateAccAnnualRevenueList.add(accList[0].AnnualRevenue);
        System.debug('accList==>'+accList);
             System.debug('updateAccAnnualRevenueList==>'+updateAccAnnualRevenueList);
        return updateAccAnnualRevenueList;
              
    }

}