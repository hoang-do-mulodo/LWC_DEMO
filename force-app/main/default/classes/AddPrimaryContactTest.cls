@isTest
public with sharing class AddPrimaryContactTest {
	

	@testSetup static void insertMockdata(){
		List<Account> accounts = new List<Account>();


		for(Integer i =0 ; i< 50 ; i++){
			accounts.add(new Account(Name ='acc ' +i  , BillingState = 'NY' ));
			accounts.add(new Account(Name ='acc '+51+i  , BillingState = 'CA' ));
		}

		insert accounts;
		List<Account> Teste = new List <Account>();

		//for(Integer i=0;i<50;i++)

  //       {

  //           Teste.add(new Account(BillingState = 'CA', name = 'Test'+i));

  //       }

  //       for(Integer j=0;j<50;j++)

  //       {

  //           Teste.add(new Account(BillingState = 'NY', name = 'Test'+j));

  //       }
  //       insert Teste;

	}

	@isTest static void testMethodQueueable(){
		List<Account> accounts = [select Id, Name  from Account];
		//List<Contact> contacts = [select Id, Name  from Contact];

		Contact con = new Contact(FirstName ='do' , LastName ='Hoang');
		insert con;

		String state = 'CA';
		

		AddPrimaryContact  addPriary = new AddPrimaryContact(con , state);
		Test.startTest();

		System.enqueueJob(addPriary);


		Test.stopTest();
	}
}