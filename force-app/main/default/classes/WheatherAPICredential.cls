public class WheatherAPICredential {

    @AuraEnabled
    public static String getDataFromWheatherApi(String city){
        HttpRequest httpRes =new HttpRequest();
        httpRes.setEndpoint('callout:wheatheApiCred/current.json?q='+city);
        httpRes.setMethod('GET');
        HttpResponse res =new HttpResponse();
        Http ht=new Http();
        res =ht.send(httpRes);
        System.debug('Response Body=>'+res.getBody());
        return res.getBody();
    }

}