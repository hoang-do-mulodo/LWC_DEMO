public class AccountEditController {

    public String closePopup { get; set; }

    accountwrapper1 makeEdit;
    List<accountwrapper1> listAccount = new List<accountwrapper1>();
    List<Account> selectableAccount = new List<Account>();
    //set<Account> selectableAccount2 = new set<Account>();
    //public Boolean showPanel {get; set;}
    public Boolean showPopup { get; set; }
   
   public AccountEditController() {
          showPopup = False;
         //showPanel = False;
   }
    
    public List<accountwrapper1> getAccounts() {
        if(listAccount == Null){
            for(Account a: [SELECT Id, Name, BillingCountry, Phone FROM Account])
            listAccount.add(new accountwrapper1(a));
            return listAccount; }
        else{
            listAccount.clear();
            for(Account a: [SELECT Id, Name, BillingCountry, Phone FROM Account])
            listAccount.add(new accountwrapper1(a));
            return listAccount;            
            }           
    }
    
     public PageReference showToPopup() {
   // public PageReference showToPanel() {
        showPopUp = True;
        return Null;
        //showPanel  = True;
        }
        
     public PageReference getSelectable() {
         system.debug('Hello');
        selectableAccount.clear();
        for(accountwrapper1 accwrapper : listAccount)
        if(accwrapper.selected == True)
        selectableAccount.add(accwrapper.acc);
        system.debug(selectableAccount);
        return Null;              
    }
    
    public string BillingCountry {
        get; 
        set;
    }
    
    
    /*public PageReference Savemeth() {
        for(account acc :selectableAccount ) {
                acc.BillingCountry = BillingCountry;
                selectableAccount2.add(acc);
                 
        }    
    update selectableAccount2;
    showPopup = False;
    return Null;
    
    }*/
    
    public PageReference Savemeth() 
    {
        map<Id, Account> mapAccountForUpdate = new map<Id, Account>();
        for(account acc :selectableAccount ) 
        {
            system.debug('BillingCountry: '+BillingCountry);
            acc.BillingCountry = BillingCountry;
            mapAccountForUpdate.put(acc.Id, acc);
        }    
        update mapAccountForUpdate.values();
        selectableAccount = new List<Account>();
        showPopup = Null;
        BillingCountry = '';
        //showPopup = False;
        return null;
    }
    
    public PageReference cancelmeth() {        
        return Null;
    }
    
    public PageReference closePopup() {
        showPopup = Null;
        BillingCountry = '';
        //showPopup = False;   
        return Null;
    }

    public PageReference GetSelectedAccounts()
    {
       if(selectableAccount.size()>0) {
        system.debug(selectableAccount.size());
        system.debug(selectableAccount);
        showPopup = Null;
        return Null;
        }
        else
        showPopup = Null;
        return Null;
    } 
    
    
     public class accountwrapper1
    {             
        public Account acc{get; set;}      
        public Boolean selected {get; set;}
        public accountwrapper1(Account a)
        {
            acc = a;
            selected = False;
        }
    }
}