
class Binnumberrequest
 
  attr_accessor :binNumber
   
    
      # Nesnenin üretilmesi 
   
    
      def execute(req,settings)
        settings.transactionDate=Core::Helper::GetTransactionDateString()
        settings.HashString = settings.PrivateKey + req.binNumber + settings.transactionDate;
        return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/rest/payment/bin/lookup",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
    
      end

      

end