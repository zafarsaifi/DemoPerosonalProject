import { LightningElement,wire,api } from 'lwc';
import getCrickerDetails  from '@salesforce/apex/CricketerController.getPlayerDetails';
export default class PlayerSearchResults extends LightningElement {

    nationality ='';
    criketerData;
    selectedplayerId;
    error;
 

    @wire(getCrickerDetails ,{nationality :'$nationality'})
    getCrickerDetailsfromApex({data,error}){
        if(data){
            this.criketerData =data;
            console.log('CricketerData==>'+JSON.stringify(this.criketerData));
        }else if(error){
            this.error =error;
           console.log('Error in getCrickerDetailsfromApex=======>',error);
        }
    }
    handleClickPlayerCard(event){
        this.selectedplayerId = event.currentTarget.dataset.id;
        console.log('SelectedplayerId=>'+this.selectedplayerId);

        let boxClass= this.template.querySelectorAll('.selected');
        console.log('boxClass length=>'+boxClass.length);
        if(boxClass.length>0){
            this.removeClass();
        }
        
       // let playerBox =this.template.querySelector(`[data-id="${this.selectedplayerId}"]`);
        let playerBox = this.template.querySelector(`[data-id="${this.selectedplayerId}"]`);


        console.log('playerBox=>'+playerBox);

        if(playerBox){
            playerBox.className ='title_wrapper selected';
        }

        this.dispatchEvent(new CustomEvent('selected',{
            detail:{
                playerId :this.selectedplayerId
            }

        }))

    }
    removeClass(){
        this.template.querySelectorAll('.selected')[0].classList.remove('selected');

    }
   @api searchPlayerResult(nationalityOfPlayer){
       console.log('nationalityOfPlayer=>'+JSON.stringify(nationalityOfPlayer));
       this.nationality = nationalityOfPlayer;
     


    }
}