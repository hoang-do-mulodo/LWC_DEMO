import { LightningElement, api, track } from 'lwc';
import {testShareFunction} from 'c/util';

export default class ChildContact extends LightningElement {
    @api precentage;
    @api pageNumber;
    @track dataRecieved = testShareFunction();
    get style(){
        return `width: ${this.precentage}% ; color: red`;
    }

    preHandle(){
        this.pageNumber = this.pageNumber -1;
    }
    nextHandle(){
        this.pageNumber = this.pageNumber +1;
    }
    previous(){
        this.dispatchEvent(new CustomEvent('previous'));
    }
    next(){
        this.dispatchEvent(new CustomEvent('next'))
    }
    

}