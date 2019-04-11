import { LightningElement, track, api } from 'lwc';
// import getSeminarById from '@salesforce/apex/SeminarVfController.getSeminarById';

export default class SeminarDetail extends LightningElement {
    _seminarId = undefined;
    @track seminar;
    // @wire(getSeminarById, {id: '$seminarId'}) seminarDetail;

    // set seminarId(value){
    //     this.seminarId = value;
    //     this.seminar = this.seminarDetail;
    // }

    @api get seminarId(){
        return this._seminarId;
    }
}