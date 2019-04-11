public with sharing class ContactControllerExtension {

	private final Contact contact;
    public final Document t;
    public String fileName {get; set;}
    public Blob fileBody {get; set;}
    //public Id contactId {get; set;}


    public Boolean con {get; set;}
    public String textName {get; set;}
    public String FileId {get; set;}
    public String getFileId;
    public Id folderId {get; set;}
    Document doc ;



    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public ContactControllerExtension(ApexPages.StandardController stdController) {
        this.contact = (Contact)stdController.getRecord();
        //contactId = ApexPages.CurrentPage().getParameters().get('Id');
        //contact.folderId = UserInfo.getUserId(); 
    }

     public PageReference save(){
        System.debug('contact' + contact);
        contact.Level__c = 'Secondary';
        contact.LeadSource = 'Web';
        try{
            upsert(contact);
        }catch(System.DMLException e){
            ApexPages.addMessages(e);
            return null;

        }
        PageReference redirectSuccess = new ApexPages.StandardController(Contact).view();
        return redirectSuccess;
    }


    public void UploadAttachment(){
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

    public void UploadToDocument(){
        Document d = new Document();
        d.name = textName;
        d.body = fileBody;
        d.folderId = '00l6F000003BJOB'; // ID folder created in document saleforce classic
        insert d;
         doc = d;
        con = true;
        List<Document> attachedFiles = [select d.Id,d.body,d.Name from Document d order by Id Desc limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
        fileId = attachedFiles[0].Id;

        }

    }
    public Id getImageId(){
        Id result = null;
        List<Attachment> images = [Select id from Attachment where Name = 'image' And parentId = :contact.Id order by CreatedDate DESC];

        if(images.size() > 0){
            result = images[0].Id;
        }
        return result;
    }


}