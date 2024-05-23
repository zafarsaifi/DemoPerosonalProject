({
   /* generateBarcode: function(component, event, helper) {
        var canvas = component.find("barcodeCanvas").getElement();
        component.barcodeCanvas
        
        
        JsBarcode(canvas, component.get("v.barcodeValue"), {
            format: "ITF"  // You can change the format as needed
        });
        
        // If you want to save the barcode record and get the image URL
        var action = component.get("c.saveBarcode");
        action.setParams({
            "barcodeValue": component.get("v.barcodeValue"),
            "additionalData": component.get("v.additionalData")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var barcodeId = response.getReturnValue();
                component.set("v.barcodeImageUrl", "/servlet/servlet.FileDownload?file=" + barcodeId);
                console.log("Barcode record saved successfully");
            } else {
                console.error("Error saving barcode record");
            }
        });
        $A.enqueueAction(action);
    }*/
})