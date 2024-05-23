({
    myAction : function(component, event, helper) {

    }
    ,
    onCheck :function(component,event,helper){
     var checkboxValue = event.getSource().get("v.value");
     var sendButton1 = component.find("sendButton1");
    console.log(event.detail.checked);
    if(event.detail.checked===true)
    {
        component.set("v.isSendActive",false);
    }
    else 
    component.set("v.isSendActive",true);
    },
    quantityHandler:function(component,event ,helper){
        var quantity=component.get("v.QauntityNumber");
        console.log("Quantity"+event.target.value);
        var rowArray=[];
        for(var i=0;i<=quantity-1;i++){
            rowArray.push({});
        }
       componet.set("v.rowData",rowArray);
    }
})