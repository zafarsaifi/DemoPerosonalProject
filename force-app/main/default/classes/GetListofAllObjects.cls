public class GetListofAllObjects {
    Public string SelectObj{get;set;}
    Public Map<String, Schema.SObjectType> AllObjMap;
    
    Public GetListofAllObjects(){
        AllObjMap= New Map<String, Schema.SObjectType>();
        AllObjMap= Schema.getGlobalDescribe();
    }
    Public List<selectoption> getAllObjectList(){
        List<selectoption> AllobjectList = new List<selectoption>();
        for(string r:AllObjMap.keyset()){
            AllobjectList.add(new selectoption(r,r));
        }
        return AllobjectList;   
    }
}