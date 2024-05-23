public class CallApexMethodInFlow1 {
    @InvocableMethod
    public static  List<String> returnAccountName(List<Id> IdList)
    {
        List<String> strList =new List<String>();
        for(Account ac:[SELECT Name FROM Account WHERE Id IN:IdList])
        {
            strList.add(ac.Name);
        }
        return strList;
    }

}