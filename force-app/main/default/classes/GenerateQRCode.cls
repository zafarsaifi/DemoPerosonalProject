public class GenerateQRCode {

     public  string imageurl{get;set;}
    public GenerateQRCode(){
        string data = uniquecode();// each time we create unique code for barcode to generate unique barcode each time.
        imageurl = 'https://barcode.tec-it.com/barcode.ashx?data='+data+'&code=Code39&multiplebarcodes=false&translate-esc=false&unit=Fit&dpi=96&imagetype=Gif&rotation=0&color=%23000000&bgcolor=%23ffffff&qunit=Mm&quiet=0';
}
   public static string uniquecode()
    {
       final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
       String guid = '';
       while (guid.length() < 9) {
       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
       guid += chars.substring(idx, idx+1);
      }
        System.debug('guid----->'+guid);
    return guid;
   }
    
}