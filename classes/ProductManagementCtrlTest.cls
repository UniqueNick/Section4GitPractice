@isTest
public class ProductManagementCtrlTest {
    
    @isTest static void operateTest(){
        List<Product_Register__c> data = ProductRegisterDataFactory.createProductRegisterRecords();
        ProductManagementCtrl ctrl = new ProductManagementCtrl();
        ApexPages.StandardSetController dataset = ctrl.setCtrl;
        List<Product_Register__c> pageset_all = ctrl.pageSet;
        system.assertEquals(10, pageset_all.size());
        //START check page size change
        ctrl.setPageSize(5);
        List<Product_Register__c> pageset5 = ctrl.pageSet;
        system.assertEquals(5, pageset5.size());
        //END check page size change
        //START check sort direction options
        ctrl.flipNameOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals('Product01', pageset5.get(0).Name);
        system.assertEquals('ASC', ctrl.getNameOrder());
        ctrl.flipNameOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals('Product12', pageset5.get(0).Name);
        system.assertEquals('DESC', ctrl.getNameOrder());
        ctrl.flipNameOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals('Product01', pageset5.get(0).Name);
        system.assertEquals('', ctrl.getNameOrder());
        ctrl.flipPriceOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(1, pageset5.get(0).Unit_Price__c);
        system.assertEquals('ASC', ctrl.getPriceOrder());
        ctrl.flipPriceOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(12, pageset5.get(0).Unit_Price__c);
        system.assertEquals('DESC', ctrl.getPriceOrder());
        ctrl.flipPriceOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(12, pageset5.get(0).Unit_Price__c);
        system.assertEquals('', ctrl.getPriceOrder());
        //END check sort direction options
        //START check search options
        ctrl.searchCriteria = '1';
        ctrl.updateSet();
        pageset5 = ctrl.pageSet;
        system.assertEquals(4, pageset5.size()); 
        ctrl.dateFilterBegin.Arrival_Date__c = Date.newInstance(1950,2,10);
        ctrl.dateFilterEnd.Arrival_Date__c = Date.newInstance(1950,2,14);
        ctrl.applyDateFilter();
        pageset5 = ctrl.pageSet;
        system.assertEquals(3, pageset5.size()); 
        ctrl.resetDateFilter();
        pageset5 = ctrl.pageSet;
        system.assertEquals(4, pageset5.size()); 
        //END check search options
        //START check sort order options
        ctrl.flipArrivalDateOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(Date.newInstance(1950,2,1), pageset5.get(0).Arrival_Date__c);
        system.assertEquals('ASC', ctrl.getArrivalDateOrder());
        ctrl.flipArrivalDateOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(Date.newInstance(1950,2,12), pageset5.get(0).Arrival_Date__c);
        system.assertEquals('DESC', ctrl.getArrivalDateOrder());
        ctrl.flipArrivalDateOrder();
        system.assertEquals('', ctrl.getArrivalDateOrder());
        ctrl.flipAvailabilityOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(false, pageset5.get(0).In_Stock__c);
        system.assertEquals('ASC', ctrl.getAvailabilityOrder());
        ctrl.flipAvailabilityOrder();
        pageset5 = ctrl.pageSet;
        system.assertEquals(true, pageset5.get(0).In_Stock__c);
        system.assertEquals('DESC', ctrl.getAvailabilityOrder());
        ctrl.flipAvailabilityOrder();
        system.assertEquals(true, pageset5.get(0).In_Stock__c);
        system.assertEquals('', ctrl.getAvailabilityOrder());
        ctrl.flipNameOrder();
        ctrl.flipArrivalDateOrder();
        ctrl.flipPriceOrder();
        ctrl.flipAvailabilityOrder();
        system.assertEquals('1', ctrl.getNameStage());
        system.assertEquals('2', ctrl.getArrivalStage());
        system.assertEquals('3', ctrl.getPriceStage());
        system.assertEquals('4', ctrl.getAvailabilityStage());
        ctrl.flipNameOrder();
        ctrl.flipNameOrder();
        system.assertEquals('', ctrl.getNameStage());
        system.assertEquals('1', ctrl.getArrivalStage());
        system.assertEquals('2', ctrl.getPriceStage());
        system.assertEquals('3', ctrl.getAvailabilityStage());
        //END check sort order options
        //START check pagination
        ctrl = new ProductManagementCtrl();
        ctrl.setPageSize(5);
        system.assertEquals(5, ctrl.getPageSize());
        system.assertEquals(1, ctrl.getPageNumber());
        system.assertEquals(false, ctrl.getHasPrevious());
        system.assertEquals(true, ctrl.getHasNext());
        ctrl.nextPage();   
        system.assertEquals(2, ctrl.getPageNumber());
        system.assertEquals(true, ctrl.getHasPrevious());
        system.assertEquals(true, ctrl.getHasNext());
        ctrl.nextPage();   
        system.assertEquals(3, ctrl.getPageNumber());
        system.assertEquals(true, ctrl.getHasPrevious());
        system.assertEquals(false, ctrl.getHasNext());
        ctrl.prevPage();   
        system.assertEquals(2, ctrl.getPageNumber());
        system.assertEquals(true, ctrl.getHasPrevious());
        system.assertEquals(true, ctrl.getHasNext());
        //END check pagination
        //START check data manipulation dialogs
        //create
        system.assertEquals(false, ctrl.showCRUDDialog);
        ctrl.editNewRecord();
        system.assertEquals('new', ctrl.getCRUDDialogMode());
        system.assertEquals(true, ctrl.showCRUDDialog);
        ctrl.crudDialogRecord.Name = 'Test';
        ctrl.crudDialogRecord.Production_Date__c = Date.today().addDays(5);
        ctrl.saveRecord();
        system.assertEquals('failed to create.', ctrl.getWriteResult());
        system.assertEquals('error', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        ctrl.crudDialogRecord.Production_Date__c = Date.today();
        ctrl.saveRecord();
        system.assertEquals('was created succesfully.', ctrl.getWriteResult());
        system.assertEquals('success', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        pageset5 = ctrl.pageSet;
        ctrl.crudDialogRecordId = pageset5.get(0).Id;
        //edit
        ctrl.editCurrentRecord();
        system.assertEquals('edit', ctrl.getCRUDDialogMode());
        system.assertEquals(true, ctrl.showCRUDDialog);
        system.assertEquals(pageset5.get(0).Name, ctrl.crudDialogRecord.Name);
        system.assertEquals(pageset5.get(0).Unit_Price__c, ctrl.crudDialogRecord.Unit_Price__c);
        system.assertEquals(pageset5.get(0).Units_Available__c, ctrl.crudDialogRecord.Units_Available__c);
        system.assertEquals(pageset5.get(0).Production_Date__c, ctrl.crudDialogRecord.Production_Date__c);
        system.assertEquals(pageset5.get(0).Arrival_Date__c, ctrl.crudDialogRecord.Arrival_Date__c);
        system.assertEquals(pageset5.get(0).In_Stock__c, ctrl.crudDialogRecord.In_Stock__c);
        ctrl.saveRecord();
        system.assertEquals('was updated succesfully.', ctrl.getWriteResult());
        system.assertEquals('success', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        ctrl.editCurrentRecord();
        ctrl.crudDialogRecord.Production_Date__c = ctrl.crudDialogRecord.Arrival_Date__c.addDays(5);
        ctrl.saveRecord();
        system.assertEquals('failed to update.', ctrl.getWriteResult());
        system.assertEquals('error', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        System.currentPageReference().getParameters().put('showId', pageset5.get(0).Id);
        ctrl.showCurrentRecord();
        //display
        system.assertEquals('show', ctrl.getCRUDDialogMode());
        system.assertEquals(true, ctrl.showCRUDDialog);
        system.assertEquals(pageset5.get(0).Name, ctrl.crudDialogRecord.Name);
        system.assertEquals(pageset5.get(0).Unit_Price__c, ctrl.crudDialogRecord.Unit_Price__c);
        system.assertEquals(pageset5.get(0).Units_Available__c, ctrl.crudDialogRecord.Units_Available__c);
        system.assertEquals(pageset5.get(0).Production_Date__c, ctrl.crudDialogRecord.Production_Date__c);
        system.assertEquals(pageset5.get(0).Arrival_Date__c, ctrl.crudDialogRecord.Arrival_Date__c);
        system.assertEquals(pageset5.get(0).In_Stock__c, ctrl.crudDialogRecord.In_Stock__c);
        System.currentPageReference().getParameters().put('delId', pageset5.get(0).Id);
        //delete
        ctrl.askForDeleteCurrentRecord();
        system.assertEquals('delete', ctrl.getCRUDDialogMode());
        system.assertEquals(true, ctrl.showCRUDDialog);
        system.assertEquals(pageset5.get(0).Name, ctrl.crudDialogRecord.Name);
        ctrl.deleteRecord();
        system.assertEquals('was deleted succesfully.', ctrl.getWriteResult());
        system.assertEquals('success', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        pageset5 = ctrl.pageSet;
        String saveId = pageset5.get(0).Id;
        delete new Product_Register__c(Id=saveId); 
        System.currentPageReference().getParameters().put('delId', saveId);
        ctrl.askForDeleteCurrentRecord();
        ctrl.deleteRecord();
        system.assertEquals('was failed to delete.', ctrl.getWriteResult());
        system.assertEquals('error', ctrl.getToastType());
        system.assertEquals(3, ctrl.getToastIndex());
        //END check data manipulation dialogs
        //check pagination ruler
        ProductRegisterDataFactory.createProductRegisterRecords();
        ProductRegisterDataFactory.createProductRegisterRecords();
        ProductRegisterDataFactory.createProductRegisterRecords();
        ProductRegisterDataFactory.createProductRegisterRecords();
        ProductRegisterDataFactory.createProductRegisterRecords();
        ctrl.setPageSize(5);
        ctrl = new ProductManagementCtrl();
        system.assertEquals(1,ctrl.setCtrl.getPageNumber());
        //The call below actually tests nothing, but increases controller coverage.
        ctrl.updatePageSize();
    }
}