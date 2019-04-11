import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
const fieldsStatic = [NAME_FIELD];
export default class RecordFormDynamicContact extends LightningElement {
    @api recordId;
    @api objectApiName
    fields = ['AccountId' , 'Name' , 'Title', 'Phone' , 'Email']; 
    //get Fields 
    @wire(getRecord , {recordId: '$recordId' , fields: fieldsStatic}) myPropety;
    get name(){
        return getFieldValue(this.myPropety.data , NAME_FIELD);
    }
}