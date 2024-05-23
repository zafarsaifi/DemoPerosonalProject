import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    number=0;
   valueForChild ='';
   
  handleForChild(event){
      console.log('Inside the hadle for child method');
      var valueForChild =event.target.value;
      this.valueForChild=valueForChild;

  }
  handleIncreamnentValue(){
      console.log('Inside the hadle for child method');
     // var constValue = this.template.querySelector('c-child-lwc');
     // constValue.increamnentHandler();
      //or 
      this.template.querySelector('c-child-lwc').increamnentHandler('testing','12345');
  }


    addhandler1(){
        console.log('Testing Code=>For Add');
        this.number++;
        
        
    }
    subtracthandler1(){
        // number--;
        console.log('Testing Code=>For Subtract');
        this.number--;
    }
    multiplyhandler(event){
        console.log('Hello Parent');
        const eventDetail=event.detail;
        console.log('Hello Parent'+eventDetail);
        this.number *= eventDetail;
    }
    multipybyThree(event){
        console.log('event value=>'+event.detail);
        const val=event.detail;
    this.number *=val;
    }
}