public with sharing class recipeContainerController {
    
    public static void getReturnableLogic(){
        Http htp=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://api.spoonacular.com/recipes/random?apiKey=ed70f110f90645e1b99319b8d233a6dc');//Call out the api
        request.setMethod('GET');//Method ka name jisse hm api ko hit krna hai
        
        HttpResponse response=htp.send(request);
        System.debug('Response Code==>'+response.getStatusCode());
        if(response.getStatusCode()==200){
            Map<String,Object> serializeMap =new Map<String,Object>();
            serializeMap = ( Map<String,Object>)Json.deserializeUntyped(response.getBody());
            System.debug('Response Body==>'+JSON.serializePretty(serializeMap));
        }
    }
}