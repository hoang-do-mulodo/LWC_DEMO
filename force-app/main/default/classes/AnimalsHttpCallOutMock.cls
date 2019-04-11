@isTest
public class AnimalsHttpCallOutMock implements HttpCalloutMock {


	public HttpResponse respond(HttpRequest request){
		HttpResponse respond = new HttpResponse();

		respond.setStatusCode(200);
		respond.setHeader('Content-Type', 'application/json');

		respond.setBody('{"animals" : ["do" , "test"]}');

		return respond;
	}


}