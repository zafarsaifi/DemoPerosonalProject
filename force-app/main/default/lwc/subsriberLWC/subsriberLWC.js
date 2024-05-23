import { LightningElement,wire } from 'lwc';
import {subscribe,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATE_CHANNEL from '@salesforce/messageChannel/Count_updated__c';

export default class SubsriberLWC extends LightningElement {
   counter = 0;
   test =''
   subscription =null;

   @wire(MessageContext)
   messageContext;

   connectedCallback() {
       this.subscribeToMessageChannel();
   }
   subscribeToMessageChannel(){
       this.subscription = subscribe(
            this.messageContext,
            COUNTING_UPDATE_CHANNEL,
            (message) => this.handleMessage(message)
       );
   }
   handleMessage(message){
    //    alert('Message:'+JSON.stringify(message));
    if(message.Operator =='add'){
        this.test='This is basically from public component on click add function';
       this.counter +=  message.constant;
    }
    else if(message.Operator == 'sub'){
        this.test='This is basically from public component on click subtract function';
         this.counter -=  message.constant;
    }
    else if(message.Operator == 'mul'){
        this.test='This is basically from public component ';
           this.counter *=  message.constant;

    }
   }

}