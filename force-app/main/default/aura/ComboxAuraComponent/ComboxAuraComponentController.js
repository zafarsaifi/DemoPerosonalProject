({
    doInit: function (component, event, helper) {
        var action = component.get("c.getContactData");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Success');
                console.log('Serialized Response>>>');
                console.log(JSON.stringify(response.getReturnValue()));
                var contacts = [];
                if (response.getReturnValue().length > 0) {
                    for (var i = 0; i < response.getReturnValue().length; i++) {
                        //var issueOption = issueOpt[i].toString();
                        var item = {
                            "label": response.getReturnValue()[i].FirstName.toString(),
                            "value": response.getReturnValue()[i].Id.toString(),
                        };
                        contacts.push(item);
                    }
                }
                component.set("v.contact", contacts);

            }
        });
        $A.enqueueAction(action);
    },
    handleChange: function (component,event){
        var selectId=event.getParam("value");
        component.set("v.selectedContactId",selectId);  
    }
    

})