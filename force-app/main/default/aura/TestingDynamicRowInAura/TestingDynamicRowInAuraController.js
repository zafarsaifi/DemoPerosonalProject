({  createRows : function(component, event, helper) {
        var numRows = component.get("v.numRows");
        var rowArray = [];
        for (var i = 1; i <= numRows; i++) {
            rowArray.push({ });
        }
        component.set("v.rowData", rowArray);
    }
})