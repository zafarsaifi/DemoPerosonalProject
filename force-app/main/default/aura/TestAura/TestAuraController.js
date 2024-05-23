({
	auraFunction : function(component, event, helper) {
		var num1=component.find("num1").get("v.value");
        var num2=component.find("num2").get("v.value");
        var sum=num1+num2;
        
        component.set("v.sum",sum);
	}
})