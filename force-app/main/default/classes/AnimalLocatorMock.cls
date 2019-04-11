public with sharing class AnimalLocatorMock  implements HttpCalloutMock {
	public HttpResponse respond(HttpRequest request){
		HttpResponse respond = new HttpResponse();

		respond.setStatusCode(200);
		respond.setHeader('Content-Type', 'application/json');
		 respond.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');

		return respond;
	}
}