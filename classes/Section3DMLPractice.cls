public with sharing class Section3DMLPractice {
    public static void contactsAddRemove() {
        List<Contact> toAdd = new List<Contact>();
        Contact temp;

        for (Integer i = 0; i < 5; i++) {
            temp = new Contact();
            temp.LastName = 'Name ' + String.valueOf(i);
            toAdd.add(temp);
        }

        insert toAdd;

        for (Integer i = 5; i < 10; i++) {
            temp = new Contact();
            temp.LastName = 'Name ' + String.valueOf(i);
            temp.Title = 'Developer';
            toAdd[i-5].Title = 'Developer';
            toAdd.add(temp);
        }

        upsert toAdd;

        delete toAdd;

        toAdd = [SELECT Id, LastName FROM Contact WHERE LastName LIKE 'Name _' AND isDeleted = :true ALL ROWS];

        undelete toAdd;
    }

    public static void rollBackTest() {
        List<Contact> toAdd = new List<Contact>();
        Contact temp;

        for (Integer i = 0; i < 20; i++) {
            temp = new Contact();
            if (i > 9)
                temp.LastName = 'RollBackTest ' + String.valueOf(i);
            toAdd.add(temp);
        }

        Savepoint sp = Database.setSavepoint();

        Integer successCount = 0;
        Database.SaveResult[] sr = Database.insert(toAdd, false);
        for (Database.SaveResult result : sr)
            if (result.isSuccess())
                successCount++;
        System.debug(toAdd.size() + ' ' + successCount);
        if (toAdd.size() > successCount)
            Database.rollback(sp);
    }

    public static void service() {
        List<Contact> toAdd = [SELECT Id, LastName FROM Contact WHERE LastName LIKE 'Name _' AND isDeleted = :true ALL ROWS];
        for (Contact c :toAdd) {
            System.debug(c.LastName);
        }
    }
}