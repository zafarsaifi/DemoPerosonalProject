import { LightningElement,wire } from 'lwc';
import { publish,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATE_CHANNEL from '@salesforce/messageChannel/Count_updated__c';
export default class PublicLwc extends LightningElement {
      inputValue =0;
      @wire(MessageContext)
      messageContext;

      handleClickAdd(){
      const payload ={
            Operator : 'add',
            constant :10


      };
      publish(this.messageContext,COUNTING_UPDATE_CHANNEL,payload)
      }
      handleClickSubtract(){
            const payload ={
                   Operator : 'sub',
                    constant :1
            }

               publish(this.messageContext,COUNTING_UPDATE_CHANNEL,payload)

      }
      handleClickMultiply(){
                 const payload ={
                   Operator : 'mul',
                    constant :2
            }
        publish(this.messageContext,COUNTING_UPDATE_CHANNEL,payload)
      }
}