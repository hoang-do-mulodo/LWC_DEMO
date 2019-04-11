@RestResource(urlMapping= '/Accounts/*/contacts')
global with sharing class AccountManager {

	@HttpGet

	global static Account getAccount(){

		RestRequest request = RestContext.request;

		//String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

		String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');
		System.debug('account id' + accountId);

		Account result = [Select Id, Name, (Select Id , Name , AccountId from Contacts where AccountId =: accountId) from Account where Id =: accountId LIMIT 1];

		System.debug('Account manager result' + result);

		return result;

	}
}