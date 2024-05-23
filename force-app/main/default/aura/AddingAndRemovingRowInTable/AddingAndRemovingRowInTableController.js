({
	addRow : function(component, event, helper) {
        /*let accountData=[{Name:'Nazim',Phone:'12345678'},{Name:'Nazim',Phone:'12345678'},
                        {Name:'Nazim',Phone:'12345678'},{Name:'Nazim',Phone:'12345678'}];*/
        
        var addData =component.get('v.AccontDetailList');
         addData.push({
            name: '',
            Phone: ''
            
        });
        
        component.set("v.AccontDetailList",addData);
        
         component.set("v.AccontDetailList", accountData);
		
	},
        removeRecord: function(component, event, helper) {
     
        var accountList = component.get("v.AccontDetailList");
    
        var selectedItem = event.currentTarget;
        
        var index = selectedItem.dataset.record;
       
        accountList.splice(index, 1);
       
        component.set("v.AccontDetailList", accountList);
    },
})