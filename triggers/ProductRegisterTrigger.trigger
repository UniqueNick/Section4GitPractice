trigger ProductRegisterTrigger on Product_Register__c (before insert, before update) {

    If (Trigger.isBefore && Trigger.isInsert){
        ProductRegisterTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    If (Trigger.isBefore && Trigger.isUpdate){
        ProductRegisterTriggerHandler.handleBeforeUpdate(Trigger.new);
    }
    
}