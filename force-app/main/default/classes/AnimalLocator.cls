public with sharing class AnimalLocator {

	public static String getAnimalNameById(Integer Id){

			//RestRequest request = RestContext.request;

			Http http = new Http();

			HttpRequest request = new HttpRequest();

			System.debug('id' + Id);


			request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
			request.setMethod('GET');

			HttpResponse response = http.send(request);
			Map<String,Object> animals = new Map<String,Object>();
			System.debug('response' + response);

			if(response.getStatusCode() != 200){

				System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());

			}else{
				

				Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
				System.debug('result' + results.get('animal'));
            	animals = (Map<String,Object>)results.get('animal');
			}

			System.debug('animals' + animals);

			return (string)animals.get('name');


	}
}