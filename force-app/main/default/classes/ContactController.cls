public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        List<Contact> contacts = [select Id, Name , Email, Custom_Image__c, Custom_Image_Display__c from Contact ];
            system.System.debug('contacts ' + contacts);
    	return contacts;
    }
}