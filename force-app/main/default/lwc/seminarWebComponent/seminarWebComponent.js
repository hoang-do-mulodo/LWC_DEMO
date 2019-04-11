/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement, wire , track, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
// createRecord(recordInput : Record): Promise<Record>
import getListSeminar from '@salesforce/apex/SeminarVfController.getListSeminar';
import findSeminars from '@salesforce/apex/SeminarVfController.findSeminars';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const DELAY = 300;

export default class SeminarWebComponent extends LightningElement {
    @api publicVariable = '';
    @track searchKeyLayout = '';
    @track ready = false;
    @track contactList;
    @track seminars;
    @track error;
    @api recordId;
    @wire(getListSeminar) seminars;
    @wire(getContacts) contacts;
    @wire(findSeminars , { searchKey: '$searchKeyLayout' }) seminars;
    @wire(getRecord , {recordId: '$recordId' , fields: ['Seminar__c.Name']}) myPropety;

    connectedCallback(){
        setTimeout(() =>{
            this.ready = true;
            console.log('propety' , this.myPropety);
        }, 3000);
    }
    
    handleChange (event){
        window.clearTimeout(this.delayTimeout);
        const search = event.target.value;
        this.delayTimeout = setTimeout( () => {
            this.searchKeyLayout = search;
        }, DELAY);
    }
    handleLoad(){
        getContacts().then(result => {
            this.contactList = result;
            console.log('contact list' , this.contactList);
        }).catch(error =>{
            this.error = error;
        })
    }
}