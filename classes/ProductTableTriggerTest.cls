@isTest
public class ProductTableTriggerTest {
    @isTest static void noWarehouses_ExternalSource(){

        TestDataFactory.createCustomSetting();
        List<Product_Table__c> pl = TestDataFactory.createProductTableRecords(200, new List<Date>(),'Dummy');
        
        Test.startTest();
        insert pl;
        Test.stopTest();
        
        List<Product_Table__c> resP = [SELECT Id FROM Product_Table__c WHERE Warehouse__c != null];        
        system.assertEquals(200, resP.size());
        resP = [SELECT Id FROM Product_Table__c WHERE Added_Date__c != :Date.Today()];        
        system.assertEquals(0, resP.size());
        List<Warehouse__c> resW = [SELECT Id, Period_Start__c, Period_End__c FROM Warehouse__c]; 
        system.assertEquals(1, resW.size());
        system.assertEquals(Date.Today(), resW[0].Period_Start__c);
        system.assertEquals(Date.Today().addDays(Org_Configuration__c.getValues('TheOnlySet').Period_Term__c.intValue()), resW[0].Period_End__c);
    }
    
    @isTest static void noWarehouses_SomeFromWorkflow(){
        
        TestDataFactory.createCustomSetting();
        List<Product_Table__c> pl = TestDataFactory.createProductTableRecords(6,
                                                                              new List<Date>{Date.today().addDays(-16),
                                                                                  Date.today().addDays(-14),
                                                                                  Date.today().addDays(+24)},
                                                                              'Dummy');
        Test.startTest();
        insert pl;
        Test.stopTest();

        List<Product_Table__c> resP = [SELECT Id FROM Product_Table__c WHERE Warehouse__c != null];        
        system.assertEquals(6, resP.size());
        resP = [SELECT Id FROM Product_Table__c WHERE Added_Date__c != :Date.Today()];        
        system.assertEquals(3, resP.size());
        List<Warehouse__c> resW = [SELECT Id FROM Warehouse__c]; 
        List<AggregateResult> resPagr = [SELECT COUNT(Id) FROM Product_Table__c GROUP BY Warehouse__c];        
        system.assertEquals(resPagr.size(), resW.size());
    }

    @isTest static void existWarehouses_SomeFromWorkflow(){
        
        TestDataFactory.createCustomSetting();
        List<Product_Table__c> pl = TestDataFactory.createProductTableRecords(6,
                                                                              new List<Date>{Date.today().addDays(-16),
                                                                                  Date.today().addDays(-14),
                                                                                  Date.today().addDays(+24)},
                                                                              'Dummy');
        List<Warehouse__c> lw = new List<Warehouse__c>
        {
            new Warehouse__c(
                Name = 'Dummy',
                Period_Start__c = Date.today().addDays(-15),
                Period_End__c = Date.today().addDays(-12)),   
            new Warehouse__c(
                Name = 'Dummy',
                Period_Start__c = Date.today().addDays(+22),
                Period_End__c = Date.today().addDays(+40))   
        };
        insert lw;    
                   
        Test.startTest();
        insert pl;
        Test.stopTest();

        List<Warehouse__c> resW = [SELECT Id FROM Warehouse__c]; 
        List<AggregateResult> resPagr = [SELECT COUNT(Id) FROM Product_Table__c GROUP BY Warehouse__c];        
        system.assertEquals(resPagr.size(), resW.size());
    }

}