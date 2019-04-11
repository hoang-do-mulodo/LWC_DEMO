@isTest
public class TestTriggerCountOrders {


	@testSetup static void insertDataTest(){

		MockDataTestCustomer.MockdataInsert();
	}

	@isTest static void TestTriggerCountOrderWhenInsert(){

	   
		Test.startTest();
	   	List<Customer__c> customer = [Select Id, Name , OrderNumber__c from Customer__c];

	   	 List<Order__c> order = new List<Order__c>();

	   	 order.add(new Order__c(Name ='Order 1', Customer__c = customer[0].Id));
	   	 order.add(new Order__c( Name= 'Order 2' , Customer__c = customer[1].Id));

	   	 
	   	 	insert order;
	   	 
	   	 Test.stopTest();

	   	 
	   	 List<Customer__c> customer1 = [Select Id, Name , OrderNumber__c from Customer__c];
	   	 System.debug('customer' + customer1);
	   	 System.assertEquals(2 , customer1[0].OrderNumber__c);

	}

	@isTest static void TestTriggerCountOrderWhenUpdate(){
		Test.startTest();
		List<Customer__c> customers = [Select Id, Name , OrderNumber__c from Customer__c];
		List<Order__c> orders = [Select Id, Name , Customer__c from Order__c];

		orders[0].Customer__c = customers[1].Id;

		update orders;

		Test.stopTest();
		List<Customer__c> customerResult = [Select Id, Name , OrderNumber__c from Customer__c];
	   	 System.debug('customer' + customerResult);
	   	 System.assertEquals(1 , customerResult[1].OrderNumber__c );
	   	  System.assertEquals(0 , customerResult[0].OrderNumber__c );



	}

	@isTest static void TestTriggerCountOrderWhenDelete(){

		Test.startTest();
		List<Customer__c> customers = [Select Id, Name , OrderNumber__c from Customer__c];
		List<Order__c> orders = [Select Id, Name , Customer__c from Order__c];


		delete orders[0];

		Test.stopTest();
		List<Customer__c> customerResult = [Select Id, Name , OrderNumber__c from Customer__c];
	   	 System.debug('customer' + customerResult);
	   	 System.assertEquals(0 , customerResult[0].OrderNumber__c);



	}

	
}