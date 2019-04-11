global with sharing class DailyLeadProcessor implements Schedulable{

	global void execute(SchedulableContext ctx){
		List<Lead> leads = [select Id , Name from Lead where LeadSource = : null limit 200];


		if(!leads.isEmpty()){
			for(Lead l : leads){
				l.LeadSource = 'Dreamforce';
			}
			update leads;
		}



	}
	
}