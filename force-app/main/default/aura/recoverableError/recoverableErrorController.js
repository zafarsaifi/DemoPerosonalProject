({
	onClickAction : function(component, event, helper) {
			
        var testparam =false
        try{
            if(!testparam){
                throw new Error('I can not go on.This is the End');            
            }
            
        }catch(e){
            $A.createComponents([
                ["ui:message",{
                    "title":"Sample throw Error",
                    "severity":"error"
                }],
                ["ui:outputText",{
                    "value":e.message
                }]
                ],
                                function(components,status,errorMessage){
                                    if(status===SUCCESS){
                                        var message= components[0];
                                        var outputMessage=components[1];
                                        message.set("v.body",outputMessage);
                                        var div1=components.find("div1");
                                        div1.set("v.body",message);
                                        
                                    } else if(status===INCOMPLETE){
                                        console.log("NO Response from the Serever or clint");
                                    }
                                        else if(status=== ERROR){
                                            console.log("Error"+errorMessage);
                                        }
                                    
                                }
                 ); 
            
            
        }
	}
})