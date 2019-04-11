@isTest
public class AnimalsCalloutsTest {


	@isTest static void testGetCallOuts(){

			Test.setMock(HttpCalloutMock.class, new AnimalsHttpCallOutMock());
			HttpResponse response = AnimalsCallouts.makeGetCallout();	
			


			System.debug('response' + response);
			String contentType = response.getHeader('Content-Type');
   			 //System.assert(contentType == 'application/json');	



	}


}