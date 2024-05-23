public class TestingPurpsoe {
    
    public static void createContact(){
        List<Contact> conList =new List<Contact>();
        for(Integer i=1;i<10;i++){
            Contact con =new Contact();
            con.LastName ='Test'+i;
            conList.add(con);
        }
        Database.insert(conList);
    }

}