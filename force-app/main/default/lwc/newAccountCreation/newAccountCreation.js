import { LightningElement } from 'lwc';

export default class NewAccountCreation extends LightningElement {

    handleSave(){
        this.dispatchEvent(new CustomEvent('save'));
    }
    handleCancel(){
        this.dispatchEvent(new CustomEvent('cancel'));
    }
    
}