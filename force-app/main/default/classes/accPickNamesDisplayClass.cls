public class accPickNamesDisplayClass {
    
    public List<SelectOption> dynamicOptions { get; set; }
    public String selectedOption { get; set; }
    
    public accPickNamesDisplayClass() {
        dynamicOptions = new List<SelectOption>();
    }
    
    public void loadDynamicOptions() {
        dynamicOptions.clear();
        // Simulating dynamic data retrieval
        dynamicOptions.add(new SelectOption('1', 'Option 1'));
        dynamicOptions.add(new SelectOption('2', 'Option 2'));
        dynamicOptions.add(new SelectOption('3', 'Option 3'));
    }
    
        // Perform your desired action using the selectedOption value
    //    System.debug('Selected option: ' + JSON.serializePretty(dynamicOptions));
 
    
    
}