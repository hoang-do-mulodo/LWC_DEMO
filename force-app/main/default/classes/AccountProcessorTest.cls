@isTest
public with sharing class AccountProcessorTest {
	

	@testSetup static void insertMockdata(){


		List<Account> accounts = new List<Account>();

		accounts.add(new Account(Name ='acc1' , AccountNumber = '12345678'));
		accounts.add(new Account(Name ='acc2' , AccountNumber = '12345786'));
		accounts.add(new Account(Name ='acc3' , AccountNumber = '12345876'));
		insert accounts;

		List<Contact> contacts = new List<Contact>();

		contacts.add(new Contact(AccountId = accounts[0].Id , LastName = 'Hoang'));
		contacts.add(new Contact(AccountId = accounts[0].Id , LastName = 'do'));
		contacts.add(new Contact(AccountId = accounts[1].Id , LastName = 'Quan'));

		insert contacts;
	}

	@isTest static void testUpdateCountNumberContacts(){


		List<Account> accounts = [select Id, Name from Account];

		List<Contact> contacts = [select Id, Name from Contact];


		List<Id> recordIds = new List<Id>();
		recordIds.add(accounts[0].Id);
		recordIds.add(accounts[1].Id);

		Test.startTest();

		AccountProcessor.countContacts(recordIds);

		Test.stopTest();


		List<Account> accountList = [select Id, Name ,Number_of_Contacts__c, (select Id, Name from Contacts) from Account];
		List<Contact> contactList = [select Id, Name from Contact];

		System.debug('accounts' + accountList);

		//System.debug('contact')s

		System.assertEquals(2 , accountList[0].Number_of_Contacts__c);


	}
}