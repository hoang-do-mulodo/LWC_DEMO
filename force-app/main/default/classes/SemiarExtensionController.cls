public with sharing class SemiarExtensionController {

	private final Seminar__c seminar;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public SemiarExtensionController(ApexPages.StandardController stdController) {
        this.seminar = (Seminar__c)stdController.getRecord();
    }

    //public String getRecordName() {
    //    return 'Hello ' + (String)mysObject.get('name') + ' (' + (Id)mysObject.get('Id') + ')';
    //}

    public String getSeminar(){
        //Seminar__c seminarDetail = this.seminar;
        return JSON.serialize(this.seminar);
    }

    public String getSemiarParticipant(){
        Seminar__c seminarDetail = this.seminar;
        list<SeminarParticipant__c> seminarParticipants = [select Id, Name , Participant__c from  SeminarParticipant__c where Seminar__r.Id =:seminarDetail.Id limit 10];

        return JSON.serialize(seminarParticipants);
    }
}