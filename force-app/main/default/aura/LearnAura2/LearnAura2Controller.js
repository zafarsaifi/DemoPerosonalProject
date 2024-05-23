({
    
	doInit : function(component, event, helper) {
      //  component.set("v.Message1","This is default Code On Loading Page");
        //    component.set("v.Message2","This is default Code On Loading Page");
		
	}
    ,
	handleClick1 : function(component, event, helper) {
        component.set("v.Message1","Testing button1");
		
	},
   // handleClick2 : function(component, event, helper) {
     //   component.set("v.Message2",event.getSource().get("v.label"));
		
	//}
})