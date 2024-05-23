({
    doInit: function(component, event, helper) {
        // Populate the options attribute
        var options = [
            { value: "option1", label: "Option 1" },
            { value: "option2", label: "Option 2" },
            { value: "option3", label: "Option 3" },
            // Add more options if needed
        ];
        component.set("v.options", options);
    },

    handleSelectionChange: function(component, event, helper) {
        var selectedOption = component.find("selectId").get("v.value"); // Get the selected value

        var conditionMappings = {
            option1: { showContent: false, iterationList: [] },
            option2: { showContent: true, iterationList: ["Item 1", "Item 2", "Item 3"] },
            option3: { showContent: true, iterationList: ["Item A", "Item B", "Item C"] },
            // Add more condition mappings if needed
        };

        var condition = conditionMappings[selectedOption];

        if (condition) {
            component.set("v.showContent", condition.showContent);
            component.set("v.iterationList", condition.iterationList);
        } else {
            // Handle default condition or set default values if needed
            component.set("v.showContent", false);
            component.set("v.iterationList", []);
        }
    }
})