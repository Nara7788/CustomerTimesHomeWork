public with sharing class SendMessageTriggerHandler {
    public static void sendMessage(List<sObject> newObjList, List<sObject> oldObjList) {
        //we don't have brothers, so get just first object
        sObject newObject = newObjList.get(0);
        sObject oldObject = oldObjList.get(0);

        // if message before and after update is different
        if (oldObject.get('Message__c') != newObject.get('Message__c')) {
            //checking which instance of our updated sObject, getting its parent by id, and changing parent message
            if (newObject instanceof GrandChildObject__c) {
                GrandChildObject__c gc = (GrandChildObject__c) newObject;
                ChildObject__c c = [SELECT Message__c FROM ChildObject__c WHERE id = :gc.Parent__c];
                c.Message__c = gc.Message__c;
                update c;
            } else if (newObject instanceof ChildObject__c) {
                ChildObject__c c = (ChildObject__c) newObject;
                ParentObject__c p = [SELECT Message__c FROM ParentObject__c WHERE id = :c.Parent__c];
                p.Message__c = c.Message__c;
                update p;
            } else if (newObject instanceof ParentObject__c) {
                ParentObject__c p = (ParentObject__c) newObject;
                GrandParentObject__c gp = [SELECT Message__c FROM GrandParentObject__c WHERE id = :p.Parent__c];
                gp.Message__c = p.Message__c;
                update gp;
            }
        }
    }
}