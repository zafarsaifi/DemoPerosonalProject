public  class LwcHandler {
    
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getAllContacts(String RecId,String searchKey){

        if(searchkey !=null && searchKey !=''){
            String key= '%' + searchKey + '%';
            List<Contact> seacrhContackList=[SELECT Id,AccountId,FirstName,LastName,Phone,Email FROM Contact  WHERE AccountId=:RecId AND LastName LIKE :key];
            return seacrhContackList;
        }
        else{
            List<Contact> contListData=[SELECT Id,AccountId,FirstName,LastName,Phone,Email FROM Contact WHERE AccountId=:RecId];
            system.debug('contListData ==> '+contListData);
            if( !contListData.isEmpty()){
               return contListData; 
            }
            return null;
        }   
    }
}