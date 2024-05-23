import { LightningElement,api } from 'lwc';

export default class ChildLwc extends LightningElement {
  @api textvalue ='';
  @api counter =0;
  @api increamnentHandler(Id,objectapiName){
      console.log('event,=>',Id);
       console.log('event,=>',objectapiName);
      this.counter++
  }

    addhandler(){
        console.log('Child add');
        this.dispatchEvent(new CustomEvent('add'));
    }
    subtracthandler(){
        console.log('Child subtract');
        this.dispatchEvent(new CustomEvent('subtract'));
    }
    handleClickOnTwo(event){
          console.log('Hello')
        const valueforMul= event.target.value;
      
        console.log('Multiply by '+valueforMul);
        this.dispatchEvent(new CustomEvent('multiply',{
            detail:valueforMul
        }))
    }
    handleClickOnThree(event){
        console.log('Hello Three');
        const eventValue=event.target.value;
        console.log('eventValue=>'+eventValue);
        this.dispatchEvent(new CustomEvent('multipybythree',{
            detail:eventValue
        }))
    }
}