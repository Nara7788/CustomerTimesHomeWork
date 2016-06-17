global with sharing class CarSellerTriggerHandler {
    //if isInsert
    public static void beforeInsert (List<Pricebook__c> triggerNew) {
        for (Pricebook__c pbNew : triggerNew) {
            //and if Holder field was set from null to something, set status to 'sold'
            if (pbNew.Holder__c != null) {
                pbNew.Status__c = 'Sold';
                updateCar(pbNew);
            }
        }
    }

    //if isUpdate
    public static void beforeUpdate (List<Pricebook__c> triggerNew, List<Pricebook__c> triggerOld) {
        for (Pricebook__c pbOld : triggerOld) {
            for (Pricebook__c pbNew : triggerNew) {
                //and if Holder was still null after insert, set status to 'sold'
                if (pbOld.Holder__c == null && pbNew.Holder__c != null) {
                    pbNew.Status__c = 'Sold';
                    updateCar(pbNew);
                }

                //else Holder was set and then changed, set status to 'Previously used'
                else if (pbOld.Holder__c != pbNew.Holder__c) {
                    pbNew.Status__c = 'Previously used';
                    updateCar(pbNew);
                }
            }
        }
    }

    private static void updateCar (Pricebook__c pb) {
        //get car object to update
        Car__c carToUpdate = [SELECT id, Holder__c FROM Car__c WHERE Model__c = :pb.Model__c LIMIT 1];

        //take account objects name and put it in car object holder field
        carToUpdate.Holder__c = [SELECT Name FROM Account WHERE id = :pb.Holder__c LIMIT 1].Name;

        update carToUpdate;
    }
}