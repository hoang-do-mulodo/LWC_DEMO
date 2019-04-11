global with sharing class LeadProcessor implements Database.Batchable<sObject> , Database.Stateful {
	//public LeadProcessor() {
		
	//}


	global Database.QueryLocator start(Database.BatchableContext bc){
		return Database.getQueryLocator('select Id , Name from Lead');	
	}

	global void execute(Database.BatchableContext bc , List<Lead> scope){
		List<Lead> leadUpdate = new List<Lead>();
		for(Lead lead : scope){
			lead.LeadSource = 'Dreamforce';

			leadUpdate.add(lead);
		}

		update leadUpdate;
	}

	global void finish(Database.BatchableContext bc){}
}