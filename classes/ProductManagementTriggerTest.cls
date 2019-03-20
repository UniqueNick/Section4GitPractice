@isTest
public class ProductManagementTriggerTest {
    @isTest static void for_ExternalSource(){
        Product_Register__c testrec = new Product_Register__c(Production_Date__c = Date.today(),
                                                              Units_Available__c = 5);
        insert testrec;
        testrec = [SELECT In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(true, testrec.In_Stock__c);
        delete testrec;
        
        testrec = new Product_Register__c(Production_Date__c = Date.today(),
                                          Units_Available__c = 0);
        insert testrec;
        testrec = [SELECT Units_Available__c, In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(false, testrec.In_Stock__c);
        
        testrec.Units_Available__c = 6;
        testrec.Arrival_Date__c = null;
        update testrec;
        testrec = [SELECT Units_Available__c, In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(true, testrec.In_Stock__c);
        
        testrec.Units_Available__c = 0;
        testrec.Arrival_Date__c = null;
        update testrec;
        testrec = [SELECT Units_Available__c, In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(false, testrec.In_Stock__c);
        delete testrec;
    }
    
    @isTest static void for_RegularWorkflow(){
        Product_Register__c testrec = new Product_Register__c(Production_Date__c = Date.today(),
                                                              Arrival_Date__c = Date.today(),
                                                              Units_Available__c = 5);
        insert testrec;
        testrec = [SELECT In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(true, testrec.In_Stock__c);
        delete testrec;
        
        testrec = new Product_Register__c(Production_Date__c = Date.today(),
                                          Arrival_Date__c = Date.today(),
                                          Units_Available__c = 0);
        insert testrec;
        testrec = [SELECT In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(false, testrec.In_Stock__c);
        
        testrec.Units_Available__c = 6;
        update testrec;
        testrec = [SELECT Units_Available__c, In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(true, testrec.In_Stock__c);
        
        testrec.Units_Available__c = 0;
        update testrec;
        testrec = [SELECT Units_Available__c, In_Stock__c FROM Product_Register__c].get(0);
        system.assertEquals(false, testrec.In_Stock__c);
        delete testrec;
    }
}