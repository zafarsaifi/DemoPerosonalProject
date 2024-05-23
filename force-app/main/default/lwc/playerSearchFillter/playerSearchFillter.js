import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import CRICKETER_OBJECT from '@salesforce/schema/Cricketer__c'; // Corrected import
//import NATIONALITY_FIELD from '@salesforce/schema/Cricketer__c.Nationality__c'; // Corrected import

 const NATIONALITY_FIELD = 'Cricketer__c.Nationality__c';
export default class PlayerSearchFillter extends NavigationMixin(LightningElement) {
    recordTypeId;
    picklistValues;
    optionsArray;
    selectedNationality = '';
    playerName ='test';
    selectedplayerId;

    @wire(getObjectInfo, { objectApiName: CRICKETER_OBJECT })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
            console.log('this.recordTypeId', this.recordTypeId);
        }
        if (error) {
            console.log('error', JSON.stringify(error));
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: NATIONALITY_FIELD })
    nationalityFieldValues({ data, error }) {
        if (data) {
            console.log('pickListData====>', data);
            let arr = [];

            this.picklistValues = data.values;
            console.log('this.picklistValues', JSON.stringify(this.picklistValues));

            this.picklistValues.forEach(element => {
                arr.push({ label: element.value, value: element.value });
            });
            this.optionsArray = arr;
            console.log('this.optionsArray======>', JSON.stringify(this.optionsArray));
        }
        if (error) {
            console.log('error=======>', JSON.stringify(error));
        }
    }

    hendelToCreateNewCriketer() {
        console.log('hendelToCreateNewCriketer++++++++++');
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Cricketer__c',
                actionName: 'new'
            },
        });
    }

    handelToComboboxValues(event) {
        this.selectedNationality = event.detail.value;
        console.log('this.selectedNationality======>', this.selectedNationality);
        this.template.querySelector('c-player-search-results').searchPlayerResult(this.selectedNationality);
    }
    handleSelectdfromChild(event){
        this.selectedplayerId =event.detail.playerId;
        console.log('playerId'+this.selectedplayerId);

    }
}