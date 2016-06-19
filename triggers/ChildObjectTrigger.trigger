trigger ChildObjectTrigger on ChildObject__c (before update) {
    SendMessageTriggerHandler.sendMessage(Trigger.new, Trigger.old);
}