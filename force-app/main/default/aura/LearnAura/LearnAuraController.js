({
	doInit : function(component, event, helper) {
		//component.set("v.var1","This is only Testing purpose");
		
        var data ={'name':'Testing javaScript Component', 
                   'email':'testaura@gmail.com'}
        component.set("v.jsObject" ,data)
        
        component.set("v.wrapperclasss",{
            'strValue':'StringData',
            'intValue':20232
        })
	}
})