import { LightningElement, wire } from 'lwc';
import getListSeminar from '@salesforce/apex/SeminarVfController.getListSeminar';

export default class SeminarList extends LightningElement {

    @wire(getListSeminar) seminars;
    handleSeminarClick(evt){
        const events = new CustomEvent('seminarselected', {detail: evt.detail});
        this.dispatchEvent(events);
    }
}