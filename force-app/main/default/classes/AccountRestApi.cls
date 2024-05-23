@RestResource(urlMapping = '/accountData/')
global class AccountRestApi {
    
    @httpGet
    global static List<Account> getAccountRecord(){
        
        List<Account> acclist=[SELECT Id, Name,Industry,Rating,AnnualRevenue FROM Account WHERE Name !=null  LIMIT 10];
        return acclist;
    }

}