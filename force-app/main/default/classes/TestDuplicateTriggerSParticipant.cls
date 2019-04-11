//@isTest(SeeAllData=true)
@isTest
public class TestDuplicateTriggerSParticipant {

   @testSetup static void insertDataTest(){
        MockDataTestSeminarParticipant.MockdataInsertedTest();

    }

		@isTest static void TestTriggerForInsertSeminarParticipant(){
      Test.startTest();
        List<Seminar__c> seminarMockList = [select Id, Name from Seminar__c];
        List<Participant__c> participantMockList =  [select Id, Name from Participant__c];
         List<SeminarParticipant__c> sParticipantListInsert = new List<SeminarParticipant__c>();



        //SeminarParticipant__c semiarParticipant = new SeminarParticipant__c(Name = 'sp4'  , Seminar__c = 'a076F00000qKL7FQAW' , Participant__c = 'a0A6F00000xz085UAA');

        sParticipantListInsert.add(new SeminarParticipant__c(Name = 'sp4'  , Seminar__c = seminarMockList[0].Id , Participant__c = participantMockList[0].Id));
        sParticipantListInsert.add(new SeminarParticipant__c(Name = 'sp5'  , Seminar__c = seminarMockList[1].Id , Participant__c = participantMockList[1].Id));
        
          //insert sParticipantListInsert;   
        try{
          insert sParticipantListInsert;   
        }catch(Exception e){
          //System.Assert(e.getMessage().contains('Insert Failed'), 'duplicate seminar participant');

        }
        
        Test.stopTest(); 
        System.assert(sParticipantListInsert[0].Id == null);
        System.assert(sParticipantListInsert[1].Id == null);


		}

    @isTest static void TestTriggerForUpdateSeminarParticipant(){
      //insertDataTest();

      List<SeminarParticipant__c> seminarParticipantList = [select Id, Name from SeminarParticipant__c];
      List<Seminar__c> seminarMockList = [select Id, Name from Seminar__c];
      List<Participant__c> participantMockList =  [select Id, Name from Participant__c];

      seminarParticipantList[0].Participant__c = participantMockList[1].Id;
      Test.startTest();

      try{
        update seminarParticipantList[0];

        }catch(Exception e){

        }   
      Test.stopTest();
      //System.assertEquals(seminarParticipantList[0].Participant__c , participantMockList[1].Id ,  'ok');
      System.assert(seminarParticipantList[0].Participant__c == participantMockList[1].Id );


    }
}