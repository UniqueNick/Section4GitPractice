@isTest
public class OrderCtrlTest {
    @isTest static void checkoutTest(){
        
        TestDataFactory.createCustomSetting();
        Product_Table__c product  = new Product_Table__c(Name = 'Smartphone Y',
                                                         Unit_Price__c = 1000,
                                                         Units_Available__c = 10);
        insert product;
        Contact contact  = new Contact(FirstName = 'Sidor',
                                       LastName = 'Sidoroff',
                                       Email = 's.sidoroff@mailserver.dom');
                                                        
        insert contact;
		System.currentPageReference().getParameters().put('Product', product.Id);
        OrderCtrl ctrl = new OrderCtrl();
        
        ctrl.order.Units__c = 12;
        ctrl.order.Order_Amount__c = 0;
        ctrl.checkout();//test
        Integer resultOrders = [SELECT COUNT() From Order_Table__c WHERE Product_Table__c=:product.Id];
        Integer resultContacts = [SELECT COUNT() From Contact WHERE LastName != 'Sidoroff'];
		System.assertEquals(0, resultOrders);
        System.assertEquals(0, resultContacts);
        
        ctrl.order.Units__c = 2;
        ctrl.order.Order_Amount__c = 0;
        ctrl.checkout();//test
        resultOrders = [SELECT COUNT() From Order_Table__c WHERE Product_Table__c=:product.Id];
        resultContacts = [SELECT COUNT() From Contact];
		System.assertEquals(0, resultOrders);
        System.assertEquals(1, resultContacts);
        
        ctrl.order.Units__c = 2;
        ctrl.order.Order_Amount__c = 0;
        ctrl.customerContact.FirstName = 'Piotr';
        ctrl.customerContact.LastName = 'Petroff';
        ctrl.customerContact.Email = 'p.petroff@mailserver.dom';
        ctrl.checkout();//test
        resultOrders = [SELECT COUNT() From Order_Table__c 
                        WHERE Product_Table__c=:product.Id 
                        AND Units__c = 2 
                        AND Order_Amount__c = 2000
                        AND Contact__c = :ctrl.customerContact.Id];
        resultContacts = [SELECT COUNT() From Contact WHERE LastName != 'Sidoroff' AND Id != :contact.Id];
		System.assertEquals(1, resultOrders);
        System.assertEquals(1, resultContacts);

        ctrl.order.Units__c = 3;
        ctrl.order.Order_Amount__c = 0;
        Id id = [SELECT Id FROM Contact WHERE LastName = 'Sidoroff'].Id;
        ctrl.customerContact.FirstName = 'Changed';
        ctrl.customerContact.LastName = 'Sidoroff';
        ctrl.customerContact.Email = 'ch@changed.dom';
        ctrl.checkout();//test
        resultOrders = [SELECT COUNT() From Order_Table__c 
                        WHERE Product_Table__c=:product.Id 
                        AND Units__c = 3 
                        AND Order_Amount__c = 3000
                        AND Contact__c = :id];
        System.assertEquals(1, resultOrders);
        resultContacts = [SELECT COUNT() From Contact
                         WHERE FirstName = 'Changed'
                         AND Email = 'ch@changed.dom'];
        System.assertEquals(1, resultOrders);
        System.assertEquals(1, resultContacts);
       
        ctrl.order.Units__c = 50;
        ctrl.order.Order_Amount__c = 0;
        ctrl.checkout();//test
        resultOrders = [SELECT COUNT() From Order_Table__c 
                        WHERE Product_Table__c=:product.Id 
                        AND Units__c = 50];
        System.assertEquals(0, resultOrders);
    }

}