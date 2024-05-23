public class PlatformEventCtrl {
     public static void publishEvent(){
        Techdicer_Event__e event = new Techdicer_Event__e();
        event.message__c = 'testZafar';
        event.recordId__c = '0016F000041zsTDQAY';
        event.status__c = 'Success';
        EventBus.publish(event);
    }

}