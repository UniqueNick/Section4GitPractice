public class ProductManagementCtrl {
    
    public Integer directPage {get;set;}
    public Integer recordsTotal {get;set;}
    public Integer pagesTotal {get;set;}
    public String searchCriteria {get;set;}
    public Boolean showCRUDDialog {get;set;}
    public String crudDialogRecordId {get;set;}
    public Product_Register__c dateFilterBegin {get;set;}
    public Product_Register__c dateFilterEnd {get;set;}
    public Product_Register__c crudDialogRecord {get;set;}
    public List<Integer> pagesFastNavLeftPart {get;set;}
    public List<Integer> pagesFastNavRightPart {get;set;}
    List<String> sortColumns; 
    Map<String,String> sortDirectionByField;
    Integer pageSize = 10;
    Boolean filterRecordsByDateInterval = false;
    String CRUDDialogMode = '';
    String toastType;
    Integer toastIndex = 1;
    String writeResult;
    string baseQueryString = 'SELECT Id, Name, Unit_Price__c, Units_Available__c, Product_Type__c, Arrival_Date__c, Production_Date__c, In_Stock__c  FROM Product_Register__c';

    public Integer getToastIndex(){
        return toastIndex;
    }
    
    public String getToastType(){
        return toastType;
    }
    
    public String getWriteResult(){
        return writeResult;
    }
    
    public String getCRUDDialogMode(){
        return CRUDDialogMode;
    }
    
    public Integer getPageNumber(){
        return setCtrl.getPageNumber();
    }
    
    public Boolean getHasPrevious(){
        return setCtrl.getHasPrevious();
    }
    
    public Boolean getHasNext(){
        return setCtrl.getHasNext();
    }
    
    public String getNameStage(){
        if (sortColumns.indexOf('Name') == -1) return '';
        return String.valueOf(sortColumns.indexOf('Name')+1);
    }
    
    public String getPriceStage(){
        if (sortColumns.indexOf('Unit_Price__c') == -1) return '';
        return String.valueOf(sortColumns.indexOf('Unit_Price__c')+1);
    }
    
    public String getArrivalStage(){
        if (sortColumns.indexOf('Arrival_Date__c') == -1) return '';
        return String.valueOf(sortColumns.indexOf('Arrival_Date__c')+1);
    }
    
    public String getAvailabilityStage(){
        if (sortColumns.indexOf('In_Stock__c') == -1) return '';
        return String.valueOf(sortColumns.indexOf('In_Stock__c')+1);
    }
    
    public Integer getPageSize() {
        return pageSize;
    } 
    
    public void setPageSize(Integer pageSize) {
        directPage = (this.pageSize * (setCtrl.getPageNumber() - 1) + 1) / pageSize + 1;
        this.pageSize = pageSize; 
        setCtrl.setPageSize(pageSize);
        rebuildIndexes();
        toPage();
    }
    
    public String getNameOrder(){
        return sortDirectionByField.get('Name');
    } 
    
    public String getPriceOrder(){
        return sortDirectionByField.get('Unit_Price__c');
    } 
    
    public String getArrivalDateOrder(){
        return sortDirectionByField.get('Arrival_Date__c');
    } 
    
    public String getAvailabilityOrder(){
        return sortDirectionByField.get('In_Stock__c');
    } 

    public List<Product_Register__c> pageSet {
        get{
            return (List<Product_Register__c>) setCtrl.getRecords();
        }
        set;
    }
    
    public ApexPages.StandardSetController setCtrl {
        get{
            if(setCtrl == null){
                String fullQueryString = baseQueryString;
                if (filterRecordsByDateInterval || (searchCriteria != null && searchCriteria.length() != 0))
                    fullQueryString += ' WHERE ';
                if (searchCriteria != null && searchCriteria.length() != 0) 
                    fullQueryString += ' Name LIKE \'%' + searchCriteria + '%\'';
                if (filterRecordsByDateInterval && searchCriteria != null && searchCriteria.length() != 0)
                    fullQueryString += ' AND ';
                if (filterRecordsByDateInterval) {
                    fullQueryString += 'Arrival_Date__c >= ' +
                        String.valueOf(dateFilterBegin.Arrival_Date__c.year()).leftPad(4,'0') + '-' +
                        String.valueOf(dateFilterBegin.Arrival_Date__c.month()).leftPad(2,'0') + '-' + 
                        String.valueOf(dateFilterBegin.Arrival_Date__c.day()).leftPad(2,'0') + 
                        ' AND Arrival_Date__c <= ' + 
                        String.valueOf(dateFilterEnd.Arrival_Date__c.year()).leftPad(4,'0') + '-' +
                        String.valueOf(dateFilterEnd.Arrival_Date__c.month()).leftPad(2,'0') + '-' + 
                        String.valueOf(dateFilterEnd.Arrival_Date__c.day()).leftPad(2,'0'); 
                }
                if (sortColumns.size() != 0){
                    fullQueryString += ' ORDER BY ';  
                    for(integer i = 0; i < sortColumns.size(); i++){
                        fullQueryString += ((i > 0)?', ':'') + sortColumns.get(i) + ' ' + sortDirectionByField.get(sortColumns.get(i));
                    }
                } 
                setCtrl = new ApexPages.StandardSetController(Database.getQueryLocator(fullQueryString));
                recordsTotal = setCtrl.getResultSize();
                setCtrl.setPageSize(pageSize);
                rebuildIndexes();
            }
            return setCtrl;
        }set;
    }
    
    public void toPage(){
        if(directPage <= pagesTotal) setCtrl.setPageNumber(directPage);
    }
    
    public void prevPage(){
        if (setCtrl.getHasPrevious()) setCtrl.previous();
    }
    
    public void nextPage(){
        if (setCtrl.getHasNext()) setCtrl.next();
    }
    
    public void deleteRecord(){
        toastIndex = 3;
        Product_Register__c toDelete; 
        for(Product_Register__c pr : (List<Product_Register__c>) setCtrl.getRecords()){
            if (pr.Id == crudDialogRecordId){
                toDelete = pr;
                break;
            }
        }
        try {
            delete toDelete;
            writeResult = 'was deleted succesfully.';
            toastType = 'success';
        } catch (DmlException e) {
            writeResult = 'was failed to delete.';
            toastType = 'error';
        }
        showCRUDDialog = false;
        CRUDDialogMode = '';
        updateSet();
    }
    
    public void saveRecord(){
        toastIndex = 3;
        if (crudDialogRecord.Id == null)
            writeResult = 'was created succesfully.';
        else 
            writeResult = 'was updated succesfully.';
        toastType = 'success';
        try {
            upsert crudDialogRecord;
        } catch (DmlException e) {
            if (crudDialogRecord.Id == null)
                writeResult = 'failed to create.';
            else 
                writeResult = 'failed to update.';
            toastType = 'error';
            return;
        }
        
        showCRUDDialog = false;
        CRUDDialogMode = '';
        updateSet();
    }
    
    public void askForDeleteCurrentRecord(){
        toastIndex = 1;
        crudDialogRecord = new Product_Register__c();
        crudDialogRecordId = ApexPages.currentPage().getParameters().get('delId');
        for(Product_Register__c pr : (List<Product_Register__c>) setCtrl.getRecords()){
            if (pr.Id == crudDialogRecordId){
                crudDialogRecord.Id = crudDialogRecordId;
                crudDialogRecord.Name = pr.Name;
                break;
            }
        }
        CRUDDialogMode = 'delete';
        showCRUDDialog = true;
    }
    
    public void showCurrentRecord(){
        toastIndex = 1;
        crudDialogRecord = new Product_Register__c();
        crudDialogRecordId = ApexPages.currentPage().getParameters().get('showId');
        for(Product_Register__c pr : (List<Product_Register__c>) setCtrl.getRecords()){
            if (pr.Id == crudDialogRecordId){
                crudDialogRecord.Id = crudDialogRecordId;
                crudDialogRecord.Name = pr.Name;
                crudDialogRecord.Unit_Price__c = pr.Unit_Price__c;
                crudDialogRecord.Units_Available__c = pr.Units_Available__c;
                crudDialogRecord.Product_Type__c = pr.Product_Type__c;
                crudDialogRecord.Arrival_Date__c = pr.Arrival_Date__c;
                crudDialogRecord.Production_Date__c = pr.Production_Date__c;
                crudDialogRecord.In_Stock__c = pr.In_Stock__c;
                break;
            }
        }
        CRUDDialogMode = 'show';
        showCRUDDialog = true;
    }
    
    public void editCurrentRecord(){
        toastIndex = 1;
        crudDialogRecord = new Product_Register__c();
        for(Product_Register__c pr : (List<Product_Register__c>) setCtrl.getRecords()){
            if (pr.Id == crudDialogRecordId){
                crudDialogRecord.Id = crudDialogRecordId;
                crudDialogRecord.Name = pr.Name;
                crudDialogRecord.Unit_Price__c = pr.Unit_Price__c;
                crudDialogRecord.Units_Available__c = pr.Units_Available__c;
                crudDialogRecord.Product_Type__c = pr.Product_Type__c;
                crudDialogRecord.Arrival_Date__c = pr.Arrival_Date__c;
                crudDialogRecord.Production_Date__c = pr.Production_Date__c;
                break;
            }
        }
        CRUDDialogMode = 'edit';
        showCRUDDialog = true;
    }
    
    public void editNewRecord(){
        toastIndex = 1;
        crudDialogRecord = new Product_Register__c();
        crudDialogRecord.Arrival_Date__c = Date.today();
        CRUDDialogMode = 'new';
        showCRUDDialog = true;
    }
    
    public void applyDateFilter(){
        filterRecordsByDateInterval = true;
        updateSet();
    }
    
    public void resetDateFilter(){
        filterRecordsByDateInterval = false;
        updateSet();
    }
    
    public PageReference updatePageSize(){
        return null;
    }
    
    public PageReference updateSet(){
        setCtrl = null;
        return null;
    }
    
    void updateSortOrder(String col){
        If (sortColumns.indexOf(col) == -1){
            sortColumns.add(col);
            sortDirectionByField.put(col,'ASC');
        } else {
            switch on sortDirectionByField.get(col).length(){
                when 3 {sortDirectionByField.put(col,'DESC');}
                when 4 {
                    sortDirectionByField.put(col,'');
                    sortColumns.remove(sortColumns.indexOf(col));
                }
            }
        }
    }
    
    public PageReference flipNameOrder(){
        updateSortOrder('Name');
        return updateSet(); 
    }
    
    public PageReference flipPriceOrder(){
        updateSortOrder('Unit_Price__c');
        return updateSet();  
    }
    
    public PageReference flipArrivalDateOrder(){
        updateSortOrder('Arrival_Date__c');
        return updateSet();
    }
    
    public PageReference flipAvailabilityOrder(){
        updateSortOrder('In_Stock__c');
        return updateSet();
    }
    
    void rebuildIndexes(){
        pagesTotal = recordsTotal / pageSize;
        pagesTotal += (Math.mod(recordsTotal, pageSize) != 0)?1:0;
        // hell knows why it doesn't simply allow this:
        // pagesTotal = recordsTotal / pageSize + (Math.mod(recordsTotal, pageSize) != 0)?1:0;
        pagesFastNavLeftPart = new List<Integer>();
        pagesFastNavRightPart = new List<Integer>();
        Integer rulerSideCnt = (pagesTotal/2 < 6)?(pagesTotal/2):5;
        if (pagesTotal>1){
            for (Integer i=1; i <= rulerSideCnt; i++){
                pagesFastNavLeftPart.add(i);  
                if (pagesTotal < 12) 
                    pagesFastNavRightPart.add(pagesTotal-(pagesTotal/2 - i));
                else
                    pagesFastNavRightPart.add(pagesTotal - (5 - i));
            } 
            if (pagesTotal < 12 && Math.mod(pagesTotal,2)==1) pagesFastNavLeftPart.add(pagesFastNavLeftPart.size()+1);
        }
    } 
    
    public ProductManagementCtrl(){
        dateFilterBegin = new Product_Register__c();
        dateFilterEnd = new Product_Register__c();
        crudDialogRecord = new Product_Register__c();
        sortColumns = new List<String>();
        sortDirectionByField = new Map<String,String>();
        showCRUDDialog = false;
        directPage = 1;
    }
}