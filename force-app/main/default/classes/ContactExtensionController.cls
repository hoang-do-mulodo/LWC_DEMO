global with sharing class ContactExtensionController {

	private final Contact contact;
    private List<Contact> contacts;
     public  String fileName {get; set;}
     public  Blob fileBody {get; set;}
     public Integer totalRecord { get; set; }
     private static Id idDetail;

     public class WrapperFile {
        public String name {get; set;}
        public String contentType {get; set;}
        public String body {get; set;}
        public String uploadStatus {get; set;}
        public WrapperFile() {}
    }

    //WrapperFile wrap = new WrapperFile();

    //WrapperFile att = (WrapperFile) System.JSON.deserialize(stringJSONFromClient, WrapperFile.class);


    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public ContactExtensionController(){

    }
    public ContactExtensionController(ApexPages.StandardController stdController) {
        this.contact = (Contact)stdController.getRecord();
    }

    global static String getContacts(){
        return JSON.serialize([select Id, Name , LastName, Email, Custom_Image__c, Custom_Image_Display__c , Account.Name , Owner.Name ,Phone from Contact order by Name  ASC]);
        //order by Name  ASC
    }

    public String getAccounts(){
        return JSON.serialize([select Id, Name from Account ]);
    }

    @RemoteAction
    global static List<Contact> getContactsPromise(){
        List<Contact> contacts = [select Id, Name , LastName, Email, Custom_Image__c, Custom_Image_Display__c , Account.Name , Owner.Name ,Phone from Contact order by Name  ASC];

        return contacts;

    }

    global static Integer getTotalRecordContact() {
        return [SELECT Count() FROM Contact]; // init total record to show on visualforce page
    }

    @RemoteAction
    global static List<Contact> getEachPageContact(Integer pageSize ,Integer pageNum){
        pageNum *= pageSize;
        List<Contact> contacts = [select Id, Name , LastName, Email, Custom_Image__c, Custom_Image_Display__c , Account.Name , Owner.Name ,Phone from Contact  limit :pageSize  offset :pageNum];

        return contacts;

    }

    @RemoteAction
    public static Contact getContactById(Id id){

           idDetail = id;
        Contact contact = [select Id, Name , Email,LastName, Custom_Image__c, Account.Name , Owner.Name , Phone from Contact where Id =: id limit 1];
        if(contact != null){

            //return JSON.serialize(contact);
            return contact;
        }else{
            return null;
        }

    }

    @RemoteAction
    public static Contact upSertContact(Contact contact, WrapperFile att){
         //System.debug('fileBody' + file);
         //WrapperFile att1 = (WrapperFile) System.JSON.deserialize(stringJSONFromClient, WrapperFile.class);


        if(contact != null){
            try{
                upsert contact;
                System.debug('Contact' + contact);
                System.debug('Att upsert' + att);
                if(att != null){
                     new ContactExtensionController().UploadAttachment(contact, att);
                }

                
                return contact;
            }catch(DmlException de){
                System.debug(de);
                return null;
            }


        }
        return null;

        
    }


    public static PageReference refreshTable(){
        PageReference curPage = ApexPages.currentPage();
        curPage.setRedirect(true);
        return curPage;
    }

    @RemoteAction
    public static void deleteContact(Id id){
        Contact contactdetail = [select Id, Name  from Contact where Id =: id limit 1];
         try{
            delete contactdetail;
            getContacts();
            //refreshTable();

        }catch(DmlException de){

            System.debug(de);

        }
    }

    public  void UploadAttachment(Contact contactDetail , WrapperFile att){
        //System.debug('fileBody' + file);
        //System.debug('Name' + fileName);
        System.debug('contact detail attach' + contactdetail);
        System.debug('att' + att);
        System.debug('att body ' + att.body);
        if(att.body != null){
            Attachment myAttachment = new Attachment();
            myAttachment.Body =  EncodingUtil.base64Decode(att.body);
            myAttachment.Name = att.name;
            myAttachment.ParentId = contactDetail.Id;
            insert myAttachment;

            List<Attachment> images = [Select id from Attachment where Name =: att.name And parentId = :contactDetail.Id order by CreatedDate DESC];

            //contactDetail.Custom_Image__c = 'https://brave-shark-aopfgn-dev-ed--c.ap4.visual.force.com/servlet/servlet.FileDownload?file=' + images[0].Id;
            contactDetail.Custom_Image__c = 'https://mulodo241018-developer-edition.ap4.force.com/servlet/servlet.FileDownload?file=' + images[0].Id;

            update contactDetail;
        }
    }

    public static PageReference listContact(){
        PageReference pr = new PageReference('/apex/ListContactVfSLDSPage#');

        return pr;
    }

    public void UploadAttachmentTest(){
        

        Id para = Apexpages.currentPage().getParameters().get('param');
        System.debug('id'+  para);
        Contact contact = [select Id, Name from Contact where Id =: para];

        if(fileBody != null && fileName !=null){
            Attachment myAttachment = new Attachment();
            myAttachment.Body = fileBody;
            myAttachment.Name = 'image';
            myAttachment.ParentId = contact.Id;
            insert myAttachment;

            List<Attachment> images = [Select id from Attachment where Name = 'image' And parentId = :contact.Id order by CreatedDate DESC];

            contact.Custom_Image__c = 'https://brave-shark-aopfgn-dev-ed--c.ap4.visual.force.com/servlet/servlet.FileDownload?file=' + images[0].Id;

            update contact;
        }
    }

    
   
}