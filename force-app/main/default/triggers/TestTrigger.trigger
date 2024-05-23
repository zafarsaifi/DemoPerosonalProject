trigger TestTrigger on Account (before insert,before update,before delete) {
    
    if(Trigger.isInsert){
        for(Account Ac:Trigger.New){
            if(ac.Industry=='Banking'){
                ac.Rating='hot';
            }
        }
    }
    if(Trigger.isUpdate){
        for(Account Ac:Trigger.New){
            if(ac.Industry=='Education'){
                ac.Rating='Cold';
            }
        }
    }
    if(Trigger.isDelete){
        for(Account Ac:Trigger.Old){
            if(ac.Industry=='Other'){
                ac.addError('You Can not remove this Account Because Rating is Hot');
            }
        }
    }
}