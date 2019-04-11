public with sharing class AddPrimaryContact implements Queueable {

	private List<Account> accounts;
	private Contact contact;

	private String state;
	public AddPrimaryContact(Contact contact , String state) {
		this.contact = contact;
		this.state = state;
		
	}

	public void execute(QueueableContext context){
		//for (Account account : accounts) {
  //        //account.parentId = parent;
  //        // perform other processing or callout
  //      }

  		List<Account> accounts = [select Id, Name, BillingState ,(select Id , LastName, FirstName  from Contacts ) from Account  where BillingState = : state limit 200];

  		List<Contact> contacts = new List<Contact>();

  		for(Account acc : accounts){
  			Contact cont = contact.clone(false, false, false, false);
  			cont.AccountId = acc.Id;
  			contacts.add(cont);
  		}

  		if(contacts.size() > 0){
  			insert contacts;
  		}

	}
}