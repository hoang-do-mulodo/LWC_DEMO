//tesstsdsdsdsds
global with sharing class SeminarVfController {
	public SeminarVfController() {
		
	}

	List<SeminarParticipant__c> seminarParticipant = new List<SeminarParticipant__c> ();



	@AuraEnabled(cacheable=true)
	@RemoteAction
	global static list<Seminar__c> getSeminars(){
		list<Seminar__c> seminars = [select Id, Name from Seminar__c limit 5];
		System.System.debug('serminars' + seminars);
		return seminars;
	}
	@AuraEnabled(cacheable=true)
	public static list<Seminar__c> getListSeminar(){
		list<Seminar__c> seminars = [select Id, Name , seminarTitle__c from Seminar__c limit 5];
		return seminars;
	}

	@AuraEnabled(cacheable=true)
	public static list<Seminar__c> findSeminars(String searchKey){
		String key = '%' + searchKey + '%';
		list<Seminar__c> seminars = [select Id, Name , seminarTitle__c from Seminar__c Where  Name Like :key limit 10 ];
		System.System.debug('serminars search' + seminars);
		return seminars;
	}

	@AuraEnabled(cacheable=true)
	@RemoteAction 
	global static Seminar__c getSeminarById(String id){
			Seminar__c seminar = [select Id, Name from Seminar__c limit 1];

			return seminar;

	}

	//public void createSeminarParticipant(){
	//	seminarParticipant.add(new SeminarParticipant__c('sp5' ,'', 'a076F00000qKL7FQAW' , 'a0A6F00000xz085UAA'));
	//	seminarParticipant.add(new SeminarParticipant__c('sp5' ,'', 'a076F00000qKL7FQAW' , 'a0A6F00000xz1RuUAI'));

	//	insert seminarParticipant;

		
	//}
}