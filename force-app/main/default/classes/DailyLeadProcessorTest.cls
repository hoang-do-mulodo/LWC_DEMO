@isTest
public with sharing class DailyLeadProcessorTest {
	public static String CRON_EXP = '0 10 13 21 9 ? 2018';


	@isTest static void testScheduleJob(){
		List<Lead>  leads = new List<Lead>();

		for(Integer i = 0; i < 200; i++){

            Lead lead = new Lead(LastName = 'Test ' + i, LeadSource = '', Company = 'Test Company ' + i, Status = 'Open - Not Contacted');

            leads.add(lead);
        }
        insert leads;


        Test.startTest();

        String jobId = System.schedule('update leadSource to deamforc', CRON_EXP,new DailyLeadProcessor());

        Test.stopTest();

	}

}