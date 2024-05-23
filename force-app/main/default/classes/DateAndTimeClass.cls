public class DateAndTimeClass {
    
    public static void getAMorPM(){
        
        List<String> dateTimeList=new List<String>();
        dateTimeList.add('2023-05-16T12:00');
        dateTimeList.add('2023-05-17T11:59');
        dateTimeList.add('2023-05-18T07:30');
        dateTimeList.add('2023-05-19T9:30');
        dateTimeList.add('2023-05-20T15:30');
        dateTimeList.add('2023-05-20T16:30');
        dateTimeList.add('2023-05-20T17:30');
        dateTimeList.add('2023-05-20T10:30');
        dateTimeList.add('2023-05-20T19:30');
        dateTimeList.add('2023-05-20T20:30');
        dateTimeList.add('2023-05-20T21:30');
        dateTimeList.add('2023-05-20T09:30');
        dateTimeList.add('2023-05-20T23:59');
         dateTimeList.add('2023-05-20T00:00');
        
        for(String str:dateTimeList){
            String   dateTimeString =str;
            DateTime d =(DateTime)JSON.deserialize('"'+ string.valueof(dateTimeString)+'"' , DateTime.class);
            String formattedDateTime = d.format('dd MMM yyyy');
            System.debug('Formatted DateTime: ' +formattedDateTime);
            Integer a=Integer.valueOf(str.substringAfter('T').substringBefore(':'));
            System.debug('Integer==>'+a);
            String str1= ((a >=12 && a< 24)  ? '@@@@@@@@@'+formattedDateTime+' '+'PM' : (a>=0 && a<12) ? '+++++++formattedDateTime==>'+formattedDateTime+' '+'AM':'');
            System.debug('Date and Time=>>'+str1);
         
            
            
            
            
            
        }
        
    }
    
}