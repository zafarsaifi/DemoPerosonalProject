import { LightningElement } from 'lwc';
import getDataFromWheatherApi from '@salesforce/apex/WheatherAPICredential.getDataFromWheatherApi';
export default class WheatherApi extends LightningElement {
    wheatherText;
    wheatherIcon;
    cityName;

    cityHandler(event){
        console.log('Event=>'+event.target.value);  
        this.cityName=event.target.value;
    }
    getCityWheatherHandler(){
        console.log('getCityWheatherHandler'); 
        getDataFromWheatherApi({city:this.cityName})
        .then(result=>{
            let wheatherjson= JSON.parse(result);
            //console.log('Result=>'+JSON.stringify(wheatherjson));
            this.wheatherText = wheatherjson.current.condition.text;
           
            this.wheatherIcon = wheatherjson.current.condition.icon;
            console.log('this.wheatherIcon'+this.wheatherText);
             console.log('this.wheatherIcon=>'+this.wheatherIcon);

        }) 
        .catch(error=>{
            console.log('Show Error=>'+error);
        })
       

    }

}