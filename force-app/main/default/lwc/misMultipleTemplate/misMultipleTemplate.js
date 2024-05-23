import { LightningElement } from 'lwc';
import templateOne from './templateOne.html';
import templateTwo from './templateTwo.html';
export default class MisMultipleTemplate extends LightningElement {
    templateOne =true;
    render(){
        this.templateOne= this.templateOne ? templateOne:templateTwo;
    }

    switchTemplate(){
        this.templateOne=this.templateOne === true ? false:true;
    }
}