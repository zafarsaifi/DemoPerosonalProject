import { LightningElement,track,api,wire } from 'lwc';

export default class OrderMadeEasyScreens extends LightningElement {
     //Boolean tracked variable to indicate if modal is open or not
     // default value is false as modal is closed when page is loaded 
    @track isCreateAccountModel=false;
     @track showHomeModel=true;
     @api name ='';

    createAccountModel()
    {
     // to open modal set isModalOpen tarck value as true
        this.isCreateAccountModel=true;
        this.showHomeModel=false;
    }
    closeModal(){
        this.showHomeModel=true;
        this.isCreateAccountModel=false;

    }

    

}