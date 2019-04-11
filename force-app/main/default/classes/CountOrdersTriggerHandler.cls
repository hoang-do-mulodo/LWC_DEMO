public with sharing class CountOrdersTriggerHandler {

    private	List<Customer__c> customerListToUpdate = new List<Customer__c>();

	public void updateOrderNumberCount(Set<Id> customerIDs){
		System.debug('cus ids' + customerIDs);
		Integer count;
		List<Customer__c> customerList = [select Id , Name from Customer__c];
		Map<Id, Integer> customerCountOrder = new Map<Id, Integer>();
		

		for(AggregateResult res: [Select count(Id) numberOrder , Customer__c from Order__c Where Customer__c IN : customerIDs group by Customer__c]){
			
				count =  (Integer)res.get('numberOrder');
			

			
			
			customerListToUpdate.add(new Customer__c(Id = (Id)res.get('Customer__c'), OrderNumber__c = count));
		}

		//Database.SaveResult[] resultList = Database.update(customerListToUpdate, false);

		

		
		try{
			update customerListToUpdate;
			


		}catch(DmlException de){
			System.debug(de);
		}
	}




}