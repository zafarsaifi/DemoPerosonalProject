public class ReturingProductDate {
    
    public static Integer numberOfReturningDays(DateTime deliveryDate, Integer deliveryDay){
       Integer counter = 0;
        Integer InitialDay = 0;
       do{
            System.debug('Increament=>' + InitialDay);
            deliveryDate = deliveryDate.addDays(InitialDay);
            System.debug('deliveryDate==>' + deliveryDate);
            System.debug('deliveryDate==>deliveryDate=>' + deliveryDate.format('EEEE'));
           if(deliveryDate.format('EEEE') == 'Sunday'){
               System.debug('cvbnm,=>'+deliveryDate.format('EEEE'));
           }
            InitialDay++;
            System.debug('deliveryDay==>' + deliveryDay);
        }
        while (InitialDay < deliveryDay);
        System.debug('last Counter +' + counter);
        System.debug('out side the loop deliveryDay==>' + deliveryDay);
        return counter;
        
        
    }
}