trigger ParentObjectTrigger on ParentObject__c (before update) {
    SendMessageTriggerHandler.sendMessage(Trigger.new, Trigger.old);
}