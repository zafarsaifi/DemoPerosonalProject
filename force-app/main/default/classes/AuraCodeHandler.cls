public with sharing class AuraCodeHandler {

    
    //This method is use for to fetch the Account Record in Ligthning component
    @AuraEnabled
    public static List<Account> getAccountData1(){
        List<Account> accList = [SELECT Id, Name,  
                                    Phone, Industry, Type from Account  ORDER BY CreatedDate DESC LIMIT 10  ];
        return accList;
    }
 //This method is use for to insert the Account Record 
     @AuraEnabled
     public static boolean createAccount(String mname,String mnumber,String Indus){
     Account ac=new Account();
      ac.Name=mname;
      ac.Phone=mnumber;
       ac.Industry=Indus;
      insert ac;
      return true;
}

//This method is use for update the Record of Account Object
@AuraEnabled
 public static Account updateAccountRecord(String accId){  
  Account ac=[SELECT Id, Name,Phone, Industry FROM Account  WHERE Id=:accId];
  return ac;
 }

 @AuraEnabled
 public static Boolean updateAccountRecordData(String acc_Name,String acc_Phone,String acc_Industry,String acc_Id){
    Account ac=new Account();
    ac.Name=acc_Name;
    ac.Phone=acc_Phone;
    ac.Industry=acc_Industry;
    ac.Id=acc_Id;
   
    upsert ac;
    return true;
  
   

 }

 //This method is use for to fetch the Contact Record in Ligthning component
      
    @AuraEnabled
    public static List<Contact> getContactData(){
        List<Contact> conList=[SELECT Id,FirstName,LastName,Phone,Email FROM Contact limit 20];
        return conList;
    }
 
    @AuraEnabled
    public static boolean deleteAccountRecord(String acc_Id){
       Account ac=new Account();
       ac.Id=acc_Id;
       delete ac;
        return true;

    }
    
      @AuraEnabled 
    public static list<Contact> fetchRecord(){
        return [SELECT Id,FirstName,LastName From Contact limit 10];
        
    }

}