import { LightningElement,track,wire,api } from 'lwc';
import getPokemonsDetailFromAPex  from '@salesforce/apex/PokemonsDetails.getPokemonsDetails';

export default class PokemonCardList extends LightningElement {

@track PokemonsDetails
@track error
@api searchPokemons='';
isVisible =false;


connectedCallback() {
    this.loadPokemons();

    
}
handleSerchPokemons(event){
    console.log('Event=>'+event.target.value);
     this.searchPokemons = event.target.value;
     this.loadPokemons(this.searchPokemons);
     


}

loadPokemons(searchPokemons){
getPokemonsDetailFromAPex({searchKey :searchPokemons})
    .then(result=>{
        this.PokemonsDetails =result;
        console.log('Pokemons Details===>'+JSON.stringify(this.PokemonsDetails));
        if(this.PokemonsDetails.length>0  && this.PokemonsDetails.length !=null){
            this.isVisible =false;
        }else{
            this.isVisible =true;
        }

    })
    .catch(error=>{
         this.isVisible =true;
        this.error =error;
        console.log('Error Message=>'+JSON.stringify(this.error));
    })
}

}