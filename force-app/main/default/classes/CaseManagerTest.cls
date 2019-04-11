@IsTest
private class  CaseManagerTest {
	//public CaseManagerTest() {
		
	//}


	@testSetup static void insertMockData(){

		List<Location__c> locations = new List<Location__c>();

		locations.add(new Location__c(Name = 'Location1'));

		insert locations; 
	}

	@isTest static  void testGetLocationById(){

		List<Location__c> locations = [Select Id from Location__c];

		RestRequest request = new  RestRequest();

		request.requestURI = 'https://brave-shark-aopfgn-dev-ed.lightning.force.com/services/apexrest/Cases/' + locations[0].Id;

		request.httpMethod = 'GET';
		RestContext.request = request;

		Location__c localtion = CaseManager.getLocationById();

		System.debug('location' + localtion);

		System.assert(localtion !=null);


 	}

 	@isTest static void testCreateLocation(){
 		Id thisLocationId = CaseManager.createLocation('VTc Cong hoa');

 		System.assert(thisLocationId != null);
 		Location__c local = [Select Id , Name from Location__c where Id =: thisLocationId];

 		System.debug('local' + local);

 		System.assert(local != null);
 	}
}