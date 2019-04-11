@isTest
public with sharing class AccountManagerTest {


	@testSetup static void insertMockData(){
		List<Account> accounts = new List<Account>();

		accounts.add(new Account(Name = 'Hoang Đô' , AccountNumber ='12345678'));
		accounts.add(new Account(Name = 'Minh Quân' , AccountNumber= 'quan1234'));

		insert accounts ;


		List<Contact> contacts = new List<Contact>();

		contacts.add(new Contact(AssistantName='Contact 1' , LastName = 'Contact 11', AccountId = accounts[0].Id ));

		insert contacts;


	}

	@isTest static void TestGetAccount(){
		List<Account>  accountsList = [select Id , Name  from Account];
		List<Contact>  contactsList = [select Id , Name , AccountId from Contact];

		RestRequest request = new RestRequest();

		request.requestURI =  'https://brave-shark-aopfgn-dev-ed.lightning.force.com/services/apexrest/Accounts/' + accountsList[0].Id + '/contacts';
		request.httpMethod = 'GET';
		RestContext.request = request;

		Account result = AccountManager.getAccount();

		System.debug('result' + result);
		System.debug('accounts ' + accountsList);
		System.debug('contacts' + contactsList);

		System.assertEquals('Hoang Đô' , result.Name);
	}
}