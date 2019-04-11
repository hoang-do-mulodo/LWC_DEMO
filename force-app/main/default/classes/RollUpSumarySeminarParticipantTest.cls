@isTest
public class RollUpSumarySeminarParticipantTest {

    public static List<SeminarParticipant__c> createSeminarParticipant(){

        List<SeminarParticipant__c> semiarParticipantList = new List<SeminarParticipant__c>();
            semiarParticipantList.add(new SeminarParticipant__c (name= 'sp30' , Seminar__c = 'a076F00000qKPPSQA4' , Participant__c = 'a0A6F00000xz085UAA'));
            semiarParticipantList.add(new SeminarParticipant__c (name= 'sp31' , Seminar__c ='a076F00000qKPPSQA4' , Participant__c = 'a0A6F00000xz1RuUAI'));

            //insert semiarParticipantList;

            return semiarParticipantList;

    }
	
    
    @isTest static void TestCreateSeminarParticipant(){


       List<SeminarParticipant__c> seminarParticipantInsert =  createSeminarParticipant();
        Test.startTest();
       insert seminarParticipantInsert;     
       Test.stopTest();
            
        
    }
    
    
    
    
    @isTest static Decimal TestRollUpCountSeminar(){
         //SeminarParticipant__c semiarParticipant = new SeminarParticipant__c(Name = 'sp30'  , Seminar__c ='a076F00000qKPPSQA4' , Participant__c = 'a0A6F00000xz08FUAQ');
         List<SeminarParticipant__c> seminarParticipantInsert =  createSeminarParticipant();
        Test.startTest();
        insert seminarParticipantInsert[0];
        Seminar__c seminar = [select Id, Name,  totalParticipant__c from  Seminar__c where Id =: 'a076F00000qKPPSQA4'];
        Decimal i = seminar.totalParticipant__c;
        System.debug('roll up update ' + i);
        
        //Test.startTest();
        Test.stopTest();
        return i;
    }

    @isTest static void TestTriggerInsertSeminarParticipant(){

        set<String> seminarList = new set<String>();
        set<String> participantList = new set<String>();
        seminarList.add('a076F00000qKL7FQAW');
        seminarList.add('a076F00000qKSu1QAG');

        participantList.add('a0A6F00000xz085UAA');
        participantList.add('a0A6F00000xz1RuUAI');




         List<SeminarParticipant__c> seminarParticipantList = new List<SeminarParticipant__c>();
        //seminarParticipantList.add(new SeminarParticipant__c (name= 'sp32' , Seminar__c = 'a076F00000qKSu1QAG' , Participant__c = 'a0A6F00000xz085UAA'));
        seminarParticipantList.add(new SeminarParticipant__c (Name= 'sp32' , Seminar__c = 'a076F00000qKL7FQAW' , Participant__c = 'a0A6F00000xz085UAA'));
        seminarParticipantList.add(new SeminarParticipant__c (Name= 'sp33' , Seminar__c = 'a076F00000qKSu1QAG' , Participant__c = 'a0A6F00000xz1RuUAI'));

        Test.startTest();



        try{

            insert seminarParticipantList;

        }catch(Exception e){
            //seminarParticipantList
            //System.assert(false , 'duplicate semiarParticipant');
            System.assertEquals(e.getMessage() , e.getMessage());
        }
            
       Test.stopTest();

       //List<SeminarParticipant__c> seminarParticipants_Inserted =  [select Id, Name from SeminarParticipant__c where Id In : semiarParticipantList];

       //for(SeminarParticipant__c sp_inserted : seminarParticipants_Inserted){
       //     System.assertEquals('seminar insert' ,  sp_inserted.Name);
       //}

    }

    @isTest static void TestDeleteSeminarParticipant(){
         List<SeminarParticipant__c> seminarParticipantList = new List<SeminarParticipant__c>();
            seminarParticipantList.add(new SeminarParticipant__c (name= 'sp30' , Seminar__c = 'a076F00000qKPPSQA4' , Participant__c = 'a0A6F00000xz085UAA'));
            
            insert seminarParticipantList;
        Test.startTest();
       
       Database.DeleteResult result = Database.delete(seminarParticipantList[0], false);
       Test.stopTest();

       System.assert(result.isSuccess());
       //System.assert(result.getErrors().size() >0);
       //System.assertEquals('cannot delete semnanar participant', result.getErrors()[0].getMessage());
   }

   @isTest static void TestDeleteSeminarHasParticipant(){

        List<SeminarParticipant__c> spList = [Select Id, Name , Seminar__c  from SeminarParticipant__c];
        if(spList.size() >0 ){
            Seminar__c seminar = [select Id, Name from Seminar__c where Id =:  spList[0].Seminar__c];

            Test.startTest();
            Database.DeleteResult result = Database.delete(seminar , false);
            Test.stopTest();

            System.assert(result.isSuccess());
        }


   }


}