import { LightningElement, api } from 'lwc';

export default class Seminar extends LightningElement {
    @api seminar;
    
    seminarClick(){
        const event = new CustomEvent('seminarclick', {detail: this.seminar.Id});
        this.dispatchEvent(event);
    }
}