public  class LWCControllerClass {

  //1 To get The Contact which is related to the  Passing Account Id of this below method;
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(String accId){   
        return [SELECT Id,AccountId, FirstName,LastName,Phone FROM Contact WHERE AccountId=:accId];
    }

}