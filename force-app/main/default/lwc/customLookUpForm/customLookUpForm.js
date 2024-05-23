import { LightningElement,track,api } from 'lwc';
import getAllContacts from '@salesforce/apex/LwcHandler.getAllContacts';
import { NavigationMixin } from 'lightning/navigation';
const columns = [{
    label: 'First Name',
    fieldName: 'FirstName',
    type: 'text',
    sortable: true
},
{
    label: 'Lasr Name',
    fieldName: 'LastName',
    type: 'text',
    sortable: true
},
{
    label: 'Phone',
    fieldName: 'Phone',
    sortable: true
}];
export default class CustomLookUpForm extends LightningElement {
    @track ShowContacts='Show Contacts';
    @track isVisible=false;
   @track columns=columns;
   @track data=[];
     @api recordId;
     @api searchkey='';

     connectedCallback(){
        //Calling Apex Method 
        getAllContacts({recId:this.recordId})
        .then(result=>{
            this.data=result})
        .catch(err=>{
            console.log('Error Occurs==>'+err)
        })
     }
     onchangeContact(event){
        this.searchkey=event.target.value;
        console.log("SearchKey"+JSON.stringify(this.searchkey));
        getAllContacts({searchkeys:this.searchkey,recId:this.recordId })
        .then(result=>{
            this.data=result
        })
        .catch(error=>{
            console.log('SearcKeay Error'+error)
        })

     }
    onclickhandler(event){
        const label=event.target.label;
        if(label === 'Show Contacts')
        {
          this.ShowContacts='Hide Contacts';
          this.isVisible ='true'
        }
        else if(label === 'Hide Contacts'){
            this.ShowContacts ='Show Contacts';
            this.isVisible ='false'
        }
    }
  
    onrowchangehandler(event) {
        const recordId = event.detail.selectedRows;
        // this[NavigationMixin.Navigate]({
        //     type: 'standard__recordPage',
        //     attributes: {
        //         recordId: recordId,
        //         objectApiName: 'Contact',
        //         actionName: 'view'
        //     }
        // });
        window.alert(recordId);
    }
    
}