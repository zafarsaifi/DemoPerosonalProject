public class CreateTargetRecordController {
    private final Account accountRecord;

    public CreateTargetRecordController(ApexPages.StandardController stdController) {
        this.accountRecord = (Account) stdController.getRecord();
    }

    public PageReference createTargetRecord() {
        Account newRecord = new Account();
        // Set fields for the new record based on accountRecord
        // Example: newRecord.SomeField = accountRecord.SomeField;
        insert newRecord;

        PageReference pageRef = new PageReference('/' + newRecord.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}