public class DuplicateSParticipantTriggerHandler {

	public static void checkDuplicateWhenInsert(List<SeminarParticipant__c> seminarList){

		set<String> seminarSet = new set<String>();
	    set<String> participantSet = new set<String>();


	    List<SeminarParticipant__c> seminarParticipantList = new List<SeminarParticipant__c>();

	    for(SeminarParticipant__c seminarParticipant : seminarList){

	        if(seminarParticipant.Seminar__c !=null){
	            seminarSet.add(seminarParticipant.Seminar__c);
	        }

	        if(seminarParticipant.Participant__c !=null){
	            participantSet.add(seminarParticipant.Participant__c);
	        }   
	    }        

		seminarParticipantList = [SELECT Id, Name , Seminar__c , Participant__c from SeminarParticipant__c WHERE Seminar__c IN : seminarSet AND Participant__c IN : participantSet];
		System.debug('seminar' + seminarParticipantList);

		for (SeminarParticipant__c seminarParInsert : seminarList){
		    System.debug('seminar insert' + seminarParInsert);

		    for(SeminarParticipant__c  seminarPar : seminarParticipantList){
		        
		            if(seminarParInsert.Seminar__c == seminarPar.Seminar__c && seminarParInsert.Participant__c == seminarPar.Participant__c){
		                seminarParInsert.addError('duplicate SeminarParticipant');
		                
		            }
		    }

		}
	}

	public static void checkDuplicateWhenUpdate(List<SeminarParticipant__c> spNew , List<SeminarParticipant__c> spOld){

		set<String> seminarSet = new set<String>();
	    set<String> participantSet = new set<String>();
	    set<String> seminarExist = new set<String>();
	    set<String> participantExist = new set<String>();


	    List<SeminarParticipant__c> seminarParticipantList = new List<SeminarParticipant__c>();

	    for(SeminarParticipant__c seminarParticipant : spNew){

	        if(seminarParticipant.Seminar__c !=null && seminarParticipant.Seminar__c != spOld[0].Seminar__c){
	            seminarSet.add(seminarParticipant.Seminar__c);
	           
	        }

	        if(seminarParticipant.Participant__c !=null && seminarParticipant.Participant__c != spOld[0].Participant__c){
	            participantSet.add(seminarParticipant.Participant__c);
	           
	        }   
	    }

	    System.debug('before' +  seminarSet + participantSet);
	    if(seminarSet.size() !=0 || participantSet.size() !=0){
	    	System.debug('passed' +  seminarSet + participantSet);
	    	seminarParticipantList = [SELECT Id, Name , Seminar__c , Participant__c from SeminarParticipant__c WHERE Seminar__c IN : seminarSet AND Participant__c IN : participantSet];
		System.debug('seminar' + seminarParticipantList);

		for (SeminarParticipant__c seminarParUpdate : spNew){
		    System.debug('seminar insert' + seminarParUpdate);

		    //if(seminarParUpdate.Seminar__c != spOld[0].Seminar__c || seminarParUpdate.Participant__c != spOld[0].Participant__c){
		    		for(SeminarParticipant__c  seminarPar : seminarParticipantList){
		        
		            if(seminarParUpdate.Seminar__c == seminarPar.Seminar__c && seminarParUpdate.Participant__c == seminarPar.Participant__c){
		                seminarParUpdate.addError('duplicate SeminarParticipant');
		                
		            }
		    	//}
		    }

		    

		}

	    }
	   
		//seminarParticipantList = [SELECT Id, Name , Seminar__c , Participant__c from SeminarParticipant__c WHERE Seminar__c IN : seminarSet AND Participant__c IN : participantSet];
		//System.debug('seminar' + seminarParticipantList);

		//for (SeminarParticipant__c seminarParUpdate : spNew){
		//    System.debug('seminar insert' + seminarParUpdate);

		//    if(seminarParUpdate.Seminar__c != spOld[0].Seminar__c || seminarParUpdate.Participant__c != spOld[0].Participant__c){
		//    		for(SeminarParticipant__c  seminarPar : seminarParticipantList){
		        
		//            if(seminarParUpdate.Seminar__c == seminarPar.Seminar__c && seminarParUpdate.Participant__c == seminarPar.Participant__c){
		//                seminarParUpdate.addError('duplicate SeminarParticipant');
		                
		//            }
		//    	}
		//    }

		    

		//}
	}


}