public class PokemonsDetails {

@AuraEnabled
public static List<Pokemon__c> getPokemonsDetails(String searchKey){
         List<Pokemon__c> pokemonList;
        if(searchKey !='' && searchKey !=null){
                String key ='%'+searchKey+'%';

           pokemonList =new List<Pokemon__c>([select id,Name,height__c,
                                                               Weight__c,image__c,Traner__r.Name
                                                                FROM Pokemon__c 
                                                                WHERE NAME LIKE :key 
                                                                OR Traner__r.Name LIKE :key ]);
              
                

        }else{
            pokemonList =new List<Pokemon__c> ([select id,Name,height__c,
                                                                  Weight__c,image__c,Traner__r.Name
                                                                   FROM Pokemon__c ]);                        
        } 
        if(!pokemonList.isEmpty()){
            return pokemonList;
    }
    else{
            return NULL;
    }
  
    }
    


}