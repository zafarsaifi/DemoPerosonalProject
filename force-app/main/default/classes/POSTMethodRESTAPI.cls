public class POSTMethodRESTAPI {
    
    public static void postBarCodeRecords(){
        String barcodeapi='https://test-apiservices.aah.co.uk/ukb2b/dev/sfdc-ea/api/v1/book-collection-mock';
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint(barcodeapi); 
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody('{"key1":"value1","key2":"value2"}');
        request.setBody('{ "reference": "ABC2408858014", "orderType": 42, "branch": "406P", "orderingAccount": "406P14301999Q", "deliveryAccount": "406P18035215M", "barcodes": [{ "barcode": "123456789", "numOfParcels": 1, "specialHandlingFlag": "CD" }, { "barcode": "123456788", "numOfParcels": 1, "specialHandlingFlag": "FL" } ] }');
        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() == 200) {
            // Successful response
            System.debug('Response Body: ' + response.getBody());
        } else {
            // Handle errors
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
        }
        
        
    }
    
}