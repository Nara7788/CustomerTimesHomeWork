trigger GrandParentObjectTrigger on GrandParentObject__c (before update) {
    SendMessageTriggerHandler.sendMessage(Trigger.new, Trigger.old);
}