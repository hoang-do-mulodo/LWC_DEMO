@isTest
public with sharing class ParkLocatorTest {
	

	@isTest static void testGetCountry(){

		Test.setMock(WebServiceMock.class, new ParkServiceMock());
		List<String> result = new List<String>(); 
		//List<String> result = ParkLocator.country();
		List<String> expectedValue = new List<String> {'Germany', 'India' , 'Japan' , 'United States'};
		result = ParkLocator.country('India');

		System.assertEquals(expectedValue , result);
	}

}