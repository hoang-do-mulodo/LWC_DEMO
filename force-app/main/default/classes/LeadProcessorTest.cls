@isTest
private class LeadProcessorTest
{
	@testSetup static void insertDataMock(){
		List<Lead>  leads  = new List<Lead>();

		for(Integer i = 0 ; i < 200 ; i++){
			leads.add(new Lead(LastName = 'Name ' + i, Company = 'Company' +i , Status ='Open'));
		}

		insert leads;
	}

	@isTest static void testBatchUpdateLead(){
		Test.startTest();

		LeadProcessor myProcesser = new LeadProcessor();
         
		

		Id batchId= Database.executeBatch(myProcesser ,200);

		Test.stopTest();


		List<Lead> leads = [Select Id, Name , Status , LeadSource from Lead];

		System.debug('leads' + leads);
		System.debug('batch id' + batchId);


		System.assertEquals('Dreamforce' , leads[0].LeadSource);



	}
}