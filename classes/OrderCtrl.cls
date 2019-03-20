public class OrderCtrl {

    Id productId;
    public Integer previousPageInd {get;set;}
    public Contact customerContact {get;set;}
    public Product_Table__c product {get;set;}
    public Order_Table__c order {get;set;}
    
    public OrderCtrl(){
        previousPageInd = -1;
        customerContact = new Contact();
        order = new Order_Table__c(Name='Replaced_By_Trigger');
        productId = ApexPages.Currentpage().getParameters().get('Product');
        product = [SELECT Id, Name, Unit_Price__c, Units_Available__c
                   FROM Product_Table__c WHERE Id=:productId];
    }
    
    public void checkout(){
        previousPageInd--;
        Contact contactToUpsert;
        List<Contact> cl = [SELECT Id FROM Contact WHERE LastName LIKE :customerContact.LastName];
        if (cl.size() == 1) contactToUpsert = cl.get(0);
        Savepoint sp = Database.setSavepoint();
        ApexPages.Message successMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Order placed succesfully.');
        ApexPages.Message failMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Something else terrible happened...');
        ApexPages.Message notEnoughUnitsMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Insufficient stock quantity.');
        
        order.Order_Amount__c = order.Units__c * product.Unit_Price__c;
        
        if (contactToUpsert == null) {
            customerContact.Id = null;
            contactToUpsert = customerContact;
        } else {
            contactToUpsert.FirstName = customerContact.FirstName;
            contactToUpsert.Email = customerContact.Email;
        }

        try {
            upsert contactToUpsert;
            order.Contact__c = contactToUpsert.Id;
            order.Product_Table__c = product.Id;
            order.Id = null;
            insert order;
        } catch (DmlException e) {
            Database.rollBack(sp);            
            ApexPages.addMessage(failMsg);
            return;
        }
        product = [SELECT Id, Name, Unit_Price__c, Units_Available__c
                   FROM Product_Table__c WHERE Id=:productId];
        product.Units_Available__c-=order.Units__c; 
        if (product.Units_Available__c >=0) {
            update product;
            ApexPages.addMessage(successMsg);
        } else {
            product.Units_Available__c+=order.Units__c; 
            Database.rollBack(sp);      
            ApexPages.addMessage(notEnoughUnitsMsg);
            return;
        }
    }
}