({
	getCotactData1 : function(component, event, helper) {
	

		var action =component.get("c.getContactData");
        action.setCallback(this,function(response){
        var state =response.getState();
		alert(state);
	    if(state == Success){
			var returnValue=response.getReturnValue();
			component.set("v.getContact",returnValue);
		 }
		});
		$A.enqueueAction(action);
	
	}
})