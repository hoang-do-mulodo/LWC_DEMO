import { LightningElement, track } from 'lwc';

export default class ParentContact extends LightningElement {
    @track precentage = 20;
    @track pageNumber = 1;

    handlePrecentageChange(event){
        this.precentage = event.target.value;
    }
    handlePrevious(){
        if(this.pageNumber > 1){
            this.pageNumber--;
        }     
    }
    handleNext(){
        this.pageNumber++;  
    }

}