@isTest
public class TestDataFactory {
    public static void createCustomSetting(){
        User thisUser = [ Select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs( thisUser ){
            Org_Configuration__c ocfg = Org_Configuration__c.getValues('TheOnlySet');            
            if(ocfg == null) {
                ocfg = new Org_Configuration__c(Name = 'TheOnlySet');
                ocfg.Period_Term__c = 30;
                insert ocfg;
            }
        }
    }
    public static List<Product_Table__c> createProductTableRecords(Integer quantity, List<Date> aDList, String name ){
        List<Product_Table__c> pl = new List<Product_Table__c>();        
        for (Integer i=0; i < quantity; i++ ){
            Product_Table__c p =  new Product_Table__c();
            p.Name = name;
            if (i < aDList.size()){
                p.Added_Date__c = adList.get(i);
            } else 
                p.Added_Date__c = null;
            pl.add(p);
        }
        return pl;
    }
}