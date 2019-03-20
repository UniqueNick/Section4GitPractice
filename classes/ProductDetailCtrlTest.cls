@isTest
public class ProductDetailCtrlTest {
    @isTest static void CheckConstr(){
        TestDataFactory.createCustomSetting();
        Product_Table__c product = new Product_Table__c(Name = 'TESTPRODUCT',
                                                        Units_Available__c = 42,
                                                        Title__c = 'The Best',
                                                        Product_Description__c = 'Awesome');
        insert product; 
        System.currentPageReference().getParameters().put('Id', product.Id);
        ProductDetailCtrl ctrl = new ProductDetailCtrl();
        System.assertNotEquals(null, ctrl.product);
        System.AssertEquals('TESTPRODUCT',ctrl.product.Name);
        System.AssertEquals(42,ctrl.product.Units_Available__c);
        System.AssertEquals('The Best',ctrl.product.Title__c);
        System.AssertEquals('Awesome',ctrl.product.Product_Description__c);
    }

}