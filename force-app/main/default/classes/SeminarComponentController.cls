public with sharing class SeminarComponentController {

@AuraEnabled
	public static List<Seminar__c> getSeminars(){
		return [select Id, Name from Seminar__c limit 10];

	}
	 @AuraEnabled
    public static Seminar__c getSeminarById(Id recordId) {
 
        Seminar__c semi = [select Id, Name, seminarTitle__c from Seminar__c  where Id =: recordId];
        return semi;
    }
}