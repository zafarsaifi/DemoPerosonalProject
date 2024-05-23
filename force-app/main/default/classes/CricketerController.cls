public class CricketerController {


     @AuraEnabled(cacheable=true)
    public static List<Cricketer__c> getPlayerDetails(String nationality){
        List<Cricketer__c> playerList;
      
         if(nationality ==''){
           playerList=[SELECT id,Name,Nationality__c,Image_URL__c
                                        ,Age__c,Runs__c FROM Cricketer__c];
         }
         else{
                playerList=[SELECT id,Name,Nationality__c,Image_URL__c
                                        ,Age__c,Runs__c FROM Cricketer__c WHERE Nationality__c =:nationality ];
         }
       
        if(playerList !=null){
            return playerList;
        }  
        else{
            return null;
        }                              
    }

}