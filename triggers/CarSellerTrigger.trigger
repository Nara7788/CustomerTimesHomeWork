trigger CarSellerTrigger on Pricebook__c (before insert, before update) {
    if (Trigger.isInsert) {
        CarSellerTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isUpdate) {
        CarSellerTriggerHandler.beforeUpdate(Trigger.new, Trigger.old);
    }
}