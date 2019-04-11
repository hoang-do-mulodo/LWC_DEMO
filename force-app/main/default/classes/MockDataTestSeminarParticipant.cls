public class MockDataTestSeminarParticipant {


	public static void MockdataInsertedTest(){

		 List<Seminar__c> seminarMock = insertSeminarTest();
        List<Participant__c> participantMockList = insertParticipantTest();


         List<SeminarParticipant__c> seminarParticipantList = new List<SeminarParticipant__c>();
        seminarParticipantList.add(new SeminarParticipant__c (Name= 'sp1' , Seminar__c = seminarMock[0].Id , Participant__c = participantMockList[0].Id));
        seminarParticipantList.add(new SeminarParticipant__c (Name= 'sp2' , Seminar__c = seminarMock[0].Id , Participant__c = participantMockList[1].Id));
        seminarParticipantList.add(new SeminarParticipant__c (Name= 'sp3' , Seminar__c = seminarMock[0].Id , Participant__c = participantMockList[2].Id));

        insert seminarParticipantList;

	}

	private static List<Seminar__c> insertSeminarTest(){
       Location__c localtionMock = new Location__c(Name ='L1');
       insert localtionMock;
      List<Seminar__c> seminarMockList = new List<Seminar__c>();
      seminarMockList.add(new Seminar__c(Name = 'seminar1' , Location__c = localtionMock.Id));
      seminarMockList.add(new Seminar__c(Name = 'seminar2' , Location__c = localtionMock.Id));
      seminarMockList.add(new Seminar__c(Name = 'seminar3' , Location__c = localtionMock.Id));
      insert seminarMockList;
      return seminarMockList;
    }

    private static List<Participant__c> insertParticipantTest(){
      List<Participant__c> participantMockList = new List<Participant__c>();
          
          participantMockList.add(new Participant__c(Name = 'p1'));
          participantMockList.add(new Participant__c(Name = 'p2'));
          participantMockList.add(new Participant__c(Name = 'p3'));
        insert participantMockList;
        return participantMockList;
    }

}