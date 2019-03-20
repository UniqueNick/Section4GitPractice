public class ProductDetailCtrl {

    public Product_Table__c product {get; set;}
    Id id;
    
    public ProductDetailCtrl(){
        id = ApexPages.Currentpage().getParameters().get('id');
        system.debug('ctrl ' + id);
        product = [SELECT Id, Image_Url__c, Name, Title__c, Product_Description__c, Units_Available__c
                   FROM Product_Table__c WHERE Id=:id];
    }
}