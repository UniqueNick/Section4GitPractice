public with sharing class Section3SOQLPractice {
    public static Boolean methodB() {
       return false;
    }

    public static Boolean methodA() {
       return true;
    }

    public static void queries() {
        List<Contact> contactQuery = new List<Contact>();
        List<Opportunity> opportunityQuery = new List<Opportunity>();
        List<AggregateResult> opportunityAggregateQuery;
        List<Lead> leadQuery = new List<Lead>();

        //Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name, а
        //также поле Name связанного с ним Аккаунта где LastName ‘Bond’
        contactQuery = [SELECT Id, Name, Account.Name FROM Contact WHERE LastName = 'Bond'];
        //Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name, а
        //также поле Name связанного с ним Аккаунта где LastName будет начинаться с D’
        contactQuery = [SELECT Id, Name, Account.Name FROM Contact WHERE LastName LIKE 'D%'];
        //Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name, а
        //также поле Name связанного с ним Аккаунта и отсортировать по
        //LastName(возрастание)
        contactQuery = [SELECT Id, Name, Account.Name FROM Contact ORDER BY LastName ASC];
        //Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name, а
        //также поле Name связанного с ним Аккаунта с 4 по 15 записи
        contactQuery = [SELECT Id, Name, Account.Name FROM Contact LIMIT 12 OFFSET 3];
        //Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name, а
        //также поле Name связанного с ним Аккаунта где FirstName Tim или LastName Forbes
        contactQuery = [SELECT Id, Name, Account.Name FROM Contact WHERE FirstName = 'Tim' OR LastName = 'Forbes'];
        //Написать SOQL запрос для получения таблицы из объекта Opportunity с
        //максимальными Amount
        opportunityAggregateQuery = [SELECT MAX(Amount) FROM Opportunity];
        //Написать SOQL запрос для получения таблицы из объекта Opportunity с Amount более 500.000
        opportunityQuery = [SELECT Id, Amount FROM Opportunity WHERE Amount > 500000];
        //Написать SOQL запрос для получения таблицы из объекта Lead у которой есть сотрудники
        leadQuery = [SELECT Id, Name FROM Lead WHERE NumberOfEmployees != NULL AND NumberOfEmployees > 0];

    }
}