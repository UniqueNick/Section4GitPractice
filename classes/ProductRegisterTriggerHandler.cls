public class ProductRegisterTriggerHandler {

    public static void handleBeforeInsert(List<Product_Register__c> pr){
        for (Product_Register__c p:pr){
            If (p.Arrival_Date__c == null) p.Arrival_Date__c = Date.today();//Fix old or external records
            p.In_Stock__c = p.Units_Available__c != 0;
        }
    }
    
    public static void handleBeforeUpdate(List<Product_Register__c> pr){
        handleBeforeInsert(pr);
    }

}