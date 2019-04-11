global with sharing class MovieController {
	public MovieController() {
		
	}

	public String getMovies(){
		//list<Movie__c> movies = [Select Id, Name , Title__c from Movie__c];
		return JSON.serialize([Select Id, Name , Title__c from Movie__c]);
	}

	@RemoteAction
	global static list<Movie__c> getMoviesByRemoteAction(){
		list<Movie__c> movies = [Select Id, Name , Title__c , Description__c from Movie__c limit 5];

		return movies;

	}

	@RemoteAction
	global static Movie__c getMovieById(String id){
		Movie__c  movie = [Select Id, Name , Title__c , Description__c , Image__c from Movie__c Where Id =: id];
		return movie;
	}
}