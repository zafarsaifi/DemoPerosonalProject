import { api,LightningElement,wire } from 'lwc';
import getContactList from '@salesforce/apex/LWCControllerClass.getContact';
import { getRecord } from 'lightning/uiRecordApi';
export default class GetContactsRelatedTheAccount extends LightningElement {
 
    @api recordId;//This is Account Id
    contacts;
    error;
    @wire(getRecord,{recod:'$recordId',field:'Account.Name'})

    record;//It is Property has to thing First One {Data,Error}

    @wire(getContactList ,{accId:'$recordId'})
   // contacts;//This is also propertry 
    //I want to write contacts in the form of Functions
    wirecontacts({error,data}){
        if(data){
            this.contacts=data;
            this.error=undefined;
        }else if(error){
            this.error=error;
            this.contacts=undefined;
        }
    }
    
    get Name(){
        return this.record.data.field.Name.value;
    }


}