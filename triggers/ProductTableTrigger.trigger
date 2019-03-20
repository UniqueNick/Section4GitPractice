trigger ProductTableTrigger on Product_Table__c (before insert) {
    If (Trigger.isBefore && Trigger.isInsert){
        ProductTableTriggerHandler.handleBeforeInsert(Trigger.new);
    }
}