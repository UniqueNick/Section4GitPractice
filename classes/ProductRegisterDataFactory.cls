public class ProductRegisterDataFactory {

    public static List<Product_Register__c> createProductRegisterRecordsFromSource(Integer quantity, Integer groupsize){
        List<Product_Table__c> pt = [SELECT Name, Unit_Price__c, Units_Available__c FROM Product_Table__c];   
        system.Debug(pt);
        List<Product_Register__c> pl = new List<Product_Register__c>();        
        Integer groupindex = 10;
        for (Integer i=0; i < (quantity / groupsize); i++ ){
            for (Integer j=0; j < groupsize; j++){
                Product_Register__c p =  new Product_Register__c();
                Integer src = (Integer)(Math.random() * pt.size());           
                p.Name = pt.get(src).Name + '_' + groupindex.format();
                p.Unit_Price__c = pt.get(src).Unit_Price__c;
                p.Units_Available__c = pt.get(src).Units_Available__c;
                if (Math.random() < 0.2) p.Units_Available__c = 0;
                p.Product_Type__c = 'Some Type';
                p.Production_Date__c = randomdate(1950,2018);
                p.Arrival_Date__c = p.Production_Date__c.addDays((Integer)(Math.random() * 1000)); 
                p.In_Stock__c = (p.Units_Available__c != 0);
                pl.add(p);
            }
            groupindex++;
        }
        insert pl;
        return pl;
    }

    public static List<Product_Register__c> createProductRegisterRecords(){
        List<Product_Register__c> pl = new List<Product_Register__c>();        
        pl.add(new Product_Register__c(
            Name='Product01', Unit_Price__c = 12,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,1)));
        pl.add(new Product_Register__c(
            Name='Product02', Unit_Price__c = 11,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,2)));
        pl.add(new Product_Register__c(
            Name='Product03', Unit_Price__c = 10,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c = Date.newInstance(1950,2,3)));
        pl.add(new Product_Register__c(
            Name='Product04', Unit_Price__c = 9,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,4)));
        pl.add(new Product_Register__c(
            Name='Product05', Unit_Price__c = 8,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,5)));
        pl.add(new Product_Register__c(
            Name='Product06', Unit_Price__c = 7,Units_Available__c = 0,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,6)));
        pl.add(new Product_Register__c(
            Name='Product07', Unit_Price__c = 6,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,7)));
        pl.add(new Product_Register__c(
            Name='Product08', Unit_Price__c = 5,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,8)));
        pl.add(new Product_Register__c(
            Name='Product09', Unit_Price__c = 4,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,9)));
        pl.add(new Product_Register__c(
            Name='Product10', Unit_Price__c = 3,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,10)));
        pl.add(new Product_Register__c(
            Name='Product11', Unit_Price__c = 2,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,11)));
        pl.add(new Product_Register__c(
            Name='Product12', Unit_Price__c = 1,Units_Available__c = 2,
            Production_Date__c = Date.newInstance(1950,1,1),
            Arrival_Date__c =  Date.newInstance(1950,2,12)));
        insert pl;
        return pl;
    }
    
    public static void flushProductRegisterRecords(){
        
        List<Product_Register__c> pl = [SELECT Id FROM Product_Register__c];        
        delete pl;
    }
    
    public static Date randomDate(Integer yearStart,Integer YearEnd)
    {
        Date result = Date.newInstance((Integer)(Math.random() * (YearEnd - YearStart))+YearStart,(Integer)(Math.random() * 10)+1,(Integer)(Math.random() * 26)+1);
        system.debug(result);
        return result;
    }
        
    
}