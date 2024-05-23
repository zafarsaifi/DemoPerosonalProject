({
    getAccountData: function (component, event, helper) {
        console.log('Inside_GetAccountData>');
        var action = component.get("c.getAccountData1");
        this.showSpinner(component, true);
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log("SUCCESS status" + state)
            if (state === "SUCCESS") {
                component.set("v.accountList", response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else if (state === "ERROR") {
                alert("unknown error");
            }
            this.showSpinner(component, false);
        });
        $A.enqueueAction(action);
    },

    showSpinner : function(component, spinnerState) {
        console.log('spinnerState>>'+spinnerState);
        component.set("v.showSpinner", spinnerState);
    },
    showSuccess : function(component, event, helper) {
             
    }
})