trigger GrandChildObjectTrigger on GrandChildObject__c (before update) {
    SendMessageTriggerHandler.sendMessage(Trigger.new, Trigger.old);
}