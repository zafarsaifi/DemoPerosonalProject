trigger ContentDocumentObject on ContentDocumentLink (After insert,after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            ContentDocumentLinkHandler.addAFileIntoAccount(Trigger.New);
        }
    } 

}