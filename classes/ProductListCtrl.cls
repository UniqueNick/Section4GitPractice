public class ProductListCtrl {
    
    public List<Product_Table__c> prodList {get; set;}
    
    public ProductListCtrl(){
        prodList = [SELECT Id, Image_Url__c, Name, Title__c, Product_Description__c, Unit_Price__c FROM Product_Table__c];
    }

}