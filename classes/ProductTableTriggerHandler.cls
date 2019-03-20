public class ProductTableTriggerHandler {

    public static void handleBeforeInsert(List<Product_Table__c> pl){
                        
        Map<Date,List<Product_Table__c>> prodByDate = new Map<Date,List<Product_Table__c>>();
        Set<Date> fixedDates;

        //Arranging products by Added_Date__c. Very useful when products come either without specified or with equal Added_Date__c.
        for (Product_Table__c p:pl){
            If (p.Added_Date__c == null) p.Added_Date__c = Date.today();//Fix old or external records
            If (prodByDate.get(p.Added_Date__c) == null){
                prodBydate.put(p.Added_Date__c, new List<Product_Table__c>{p});
            } else {
                prodbyDate.get(p.Added_Date__c).add(p);
            }
        }
        
        //Cycling products through existing warehouses 
        for(List<Warehouse__c> whl:[SELECT Id, Period_Start__c, Period_End__c FROM Warehouse__c ]){
            for(Warehouse__c wh : whl ){
                fixedDates = new Set<Date>();
                if (prodByDate.size() == 0)  break;
                for (Date aD : prodByDate.keySet()){
                    if ((wh.Period_Start__c <= aD) && (wh.Period_End__c >= aD)){
                        for(Product_Table__c p : prodByDate.get(aD)){
                            p.Warehouse__c = wh.Id;
                        }
                        fixedDates.add(aD);
                    }
                }
                //Associated with warehouse products removed from futher consideration 
                for (Date fd : fixedDates){
                    prodByDate.remove(fd);
                }
            }
        }
        
        // Creating warehouses for remaining loose products
        Integer period = Org_Configuration__c.getValues('TheOnlySet').Period_Term__c.intValue();
        List<Warehouse__c> lnw = new List<Warehouse__c>();
        Warehouse__c nw; 
        for (Date aD : prodByDate.keySet()){
            nw = suitsFrom(aD,lnw);
            if (nw != null ) { //No need to create warehouse: here's the one, created already 
                for (Product_Table__c pt :prodbydate.get(aD)){
                    prodbydate.get(nw.Period_Start__c).add(pt);
                }
            }  else { //Only create warehouse if no suitable around
                nw = new Warehouse__c();
                nw.Period_Start__c = aD;
                nw.Period_End__c = aD.addDays(period);
                nw.Name = 'Warehouse ' + aD.format() + ' ' + nw.Period_End__c.format(); 
                lnw.add(nw);
            }
        }
        insert lnw;
        for (Warehouse__c ew : lnw){
            for (Product_Table__c pt :prodbydate.get(ew.Period_Start__c)){
                pt.Warehouse__c = ew.Id;
            }
        }
    }
    
    //Helper method. Checks if next product suits to one of newly added warehouses
    private static Warehouse__c suitsFrom(Date addDate, List<Warehouse__c> src){
        for (Warehouse__c wh : src){
            if ((wh.Period_Start__c <= addDate) && (wh.Period_End__c >= addDate)) return wh;
        }
        return null;
    }
}