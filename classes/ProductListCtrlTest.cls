@isTest
public class ProductListCtrlTest {
    @isTest static void CheckConstr(){
        TestDataFactory.createCustomSetting(); 
        List<Product_Table__c> pL = new List<Product_Table__c>();
        for(Integer i=1; i<=10 ; i++){
            pL.add(New Product_Table__c(Name = 'TESTPRODUCT',Units_Available__c = i));
        }
        insert pl;
        ProductListCtrl ctrl = new ProductListCtrl();
        System.AssertEquals(10,ctrl.prodList.size());
        
        pl = [SELECT Id FROM Product_Table__c WHERE Units_Available__c > 3 AND Units_Available__c < 8];
        delete pl;
        ctrl = new ProductListCtrl();
        System.AssertEquals(6,ctrl.prodList.size());
    }

}