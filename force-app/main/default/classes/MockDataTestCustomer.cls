public class MockDataTestCustomer {


	public static void MockdataInsert(){


		List<Customer__c> customers = new List<Customer__c>();

		customers.add(new Customer__c(Name = 'Cus1'));
		customers.add(new Customer__c(Name = 'Cus2'));

		insert customers;

		List<Order__c> orders = new List<Order__c>();

		orders.add(new Order__c(Name = 'Order1' , Customer__c = customers[0].Id));

		insert orders;
	}

}