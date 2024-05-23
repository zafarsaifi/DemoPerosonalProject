({
    doInit : function(component, event, helper) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id":"findableAuraId",
                "label":"Click Me",
                "onclick":component.getReference("c.handleClick")
            }, 
            function(newButton,status,errorMessage){
            if(status === "SUCCESS"){
                var body=component.get("v.body");
                body.push(newButton);
                component.set("v.body",body);
                }
            else if(status ==="INCOMPLETE"){
                console.log("No Responce FROM THE server or Clint Side");
            }
                else if(status === "ERROR"){
                      console.log("Error: " + errorMessage);
                }
          }
        );
    },
    handleClick:function(component,event,handler){
        component.set("v.message","Button is Click");
    }
    
       
})