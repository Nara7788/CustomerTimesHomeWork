public with sharing class HomeWorkUtilities {
    //method for creating and import to DB Parents/Childs records
    public static void createParentsChilds(Integer parents, Integer childs) {
        createChilds(createParents(parents), childs);
    }

    //support method for createParentsChilds. Create Parents records, insert it to DB 
    //and return for createChilds method
    private static List<Test_Parent__c> createParents(Integer count) {
        List<Test_Parent__c> result = new List<Test_Parent__c>();

        for (Integer i = 0; i < count; i++) {
            result.add(new Test_Parent__c());
        }

        insert result;
        return result;
    }

    //support method for createParentsChilds. Create Child
    private static void createChilds(List<Test_Parent__c> parents, Integer countChilds) {
        List<Test_Child__c> result = new List<Test_Child__c>();

        for (Integer i = 0; i < parents.size(); i++) {
            for (Integer j = 0; j < countChilds; j++) {
                result.add(new Test_Child__c(Parent__c = parents.get(i).id));
            }
        }

        insert result;
    }

    public static Set<Test_Parent__c> pointTwo() {
        Set<Test_Parent__c> parentsSet = new Set<Test_Parent__c>([SELECT id, Name FROM Test_Parent__c]);

        return parentsSet;
    }

    public static List<Test_Child__c> pointThree() {
        Set<Test_Parent__c> parentsSet = pointTwo();
        List<Test_Child__c> childsList = new List<Test_Child__c>();
        for (Test_Parent__c par : parentsSet) {
            childsList.addAll([SELECT Parent__c, name, Count__c FROM Test_Child__c WHERE Parent__c = :par.id]);
        }
        return childsList;
    }

    public static void pointFour() {
        createParentsChilds(1, 4);
    }

    public static void pointFive() {
        List<Test_Child__c> children = new List<Test_Child__c>();
        List<Test_Parent__c> parents = [SELECT id, (SELECT Count__c FROM Test_Childs__r) FROM Test_Parent__c];
        for (Test_Parent__c prnt : parents) {
            Test_Child__c chld = prnt.Test_Childs__r.get(0);
            chld.Count__c = 777;
            children.add(chld);
        }
        update children;

        System.debug([SELECT Name FROM Test_Child__c WHERE NaraSmith__Count__c = 777]);
    }

    public static Map<String, List<Test_Child__c>> pointSix() {
        Map<String, List<Test_Child__c>> pcMap = new Map<String, List<Test_Child__c>>();
        List<Test_Parent__c> pList = [SELECT id, (SELECT id, name FROM Test_Childs__r) FROM Test_Parent__c];
        for (Test_Parent__c par : pList) {
            pcMap.put(par.id, par.Test_Childs__r);
        }

        /*for (String s : pcMap.keySet()) {
            System.debug(s + ' >>> ' + pcMap.get(s));
        }*/
        return pcMap;
    }

    public static void pointSeven() {
        List<Test_Child__c> children = pointThree();
        for (Test_Child__c child : children) {
            if (child.Count__c == null) {
                child.Count__c = 555;
            }
        }

        update children;
    }
}