import { LightningElement,api,wire,track } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';
//import trainerId from '@salesforce/schema/Pokemon__c.Traner__c';

const trainerId = 'Pokemon__c.Traner__c';

const pokemonField =[trainerId];

export default class TrainerDetailsForm extends LightningElement {

    @api recordId;
    trainerId;
    // @wire(getRecord ,{recordId : '$recordId', fields :pokemonField})
    // getTrainerId({error,data}){
    //     if(error){
    //         console.log('error==>'+JSON.stringify(error));
    //     }
    //     else if(data){
    //         console.log('data==>'+JSON.stringify(data));
    //         this.trainerId = getFieldValue(data,trainerId);

    //     }
    // }

    // Or we can like this
    @wire(getRecord ,{recordId :'$recordId',fields:pokemonField})
    getTrainerDetailviaProperty;

    get trainerId(){
        return getFieldValue(this.getTrainerDetailviaProperty.data,trainerId)
    }
    




}