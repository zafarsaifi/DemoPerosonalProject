({
	doInit : function(component, event, helper) {
	   var data=[];
		var action =component.get("c.getContactData");
		action.setCallback(this,function(response){
			var state =response.getState();
			console.log("State Status==>"+state);
			if(state === "SUCCESS"){
				var returnValue =response.getReturnValue();
				for(var i=0;i<returnValue.length;i++){
					var item = {
						"label": response.getReturnValue()[i].FirstName.toString(),
						"value": response.getReturnValue()[i].Id.toString(),
					};

					data.push(item);
					console.log("Show Data on Console=>"+data);
				}
				component.set("v.contact",data);
			}
		});
		$A.enqueueAction(action); 
		
	}
		,
	handleChange:function(component,event){
		var selectId=event.getParam("value");
	   component.set("v.selectedContactId",selectId);
	},

	handleClickButton:function(Component,event){
     
      Component.set("v.flag1",true);

	}
	
})