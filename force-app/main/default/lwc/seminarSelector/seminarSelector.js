import { LightningElement, track } from 'lwc';

export default class SeminarSelector extends LightningElement {
    @track selectedId;

    handleSeminarSelected(event){
        this.selectedId = event.detail;
    }
}