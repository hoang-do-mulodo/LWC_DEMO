public  class ContactEditController {

	public Contact  contact {get; set;} 


	public boolean isNew = false;

	public ContactEditController() {
		Id id = ApexPages.currentPage().getParameters().get('id');

		contact = (id == null) ? new Contact(): [select LastName , Phone, Name , AccountId , ReportsToId ,Salutation , HomePhone , MobilePhone, FirstName, OtherPhone , Fax , Title, Email,Department , Birthdate , AssistantPhone , Description, LeadSource , Languages__c , Level__c , OwnerId , MailingCity ,OtherCity, MailingStreet , OtherStreet , MailingState, OtherState , MailingPostalCode , OtherPostalCode , MailingCountry , OtherCountry  from Contact where Id =:id];
		
	}

	public PageReference save(){

		System.debug('contact' + contact);
		contact.Level__c = 'Primary';
		try{
			upsert(contact);
		}catch(System.DMLException e){
			ApexPages.addMessages(e);
			return null;

		}

		if(isNew == false){
			PageReference redirectSuccess = new ApexPages.StandardController(Contact).view();
			//redirectSuccess.setRedirect(true);
			return redirectSuccess;

		}else{
			return null;
		}

		
	}

	public PageReference saveAndNew(){
		isNew = true;
		save();
		PageReference prAddNew = new PageReference('/apex/NewContactVfPageCustom');
		//pr.setRedirect(true);
		return prAddNew;

	}

	public PageReference cancel(){

		Contact contactNew = new Contact();
		PageReference redirectToListPage = new PageReference('https://brave-shark-aopfgn-dev-ed.my.salesforce.com/003/o');
		//redirectToListPage.setRedirect(true);
		return(redirectToListPage);
	}

}