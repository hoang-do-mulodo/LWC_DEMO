public with sharing class AccountProcessor {


	@future
	public static void countContacts(List<Id> recordIds){

		List<Account> accounts = [select Id, Name from Account where Id IN : recordIds];

		List<Account> accountBeforeCountContact = new List<Account>();


		for(Account acc : accounts){
			List<Contact> contacts = [select Id,Name from Contact where Account.Id =: acc.Id];

			acc.Number_of_Contacts__c = contacts.size();

			accountBeforeCountContact.add(acc);

			
		}
		update accountBeforeCountContact;

		//try{
			
		//}catch(DmlException de){
		//	System.debug(de);
		//}
		



	}
	
}