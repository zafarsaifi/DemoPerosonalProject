({
	doInIt : function(component, event, helper) {
        var action = component.get("c.fetchRecord");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
          //  alert('state : ' + state);
            if (state === "SUCCESS") {
                var fetchRecords = response.getReturnValue();
                console.log("fetchRecords From server: " + JSON.stringify(fetchRecords));
            component.set('v.conOption',fetchRecords);      
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
 
        $A.enqueueAction(action);
		
	},
    changeAction : function(component, event, helper) {
        var conId = event.find("con").get('v.value');
        alert(conId);
        component.set('v.selectedContact',conId);
    }
})