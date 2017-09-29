
class Bankcarddeleterequest
    
    attr_accessor :userId
    attr_accessor :cardId
    attr_accessor :clientIp
    
       
         # Nesnenin üretilmesi 
      
       
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.userId + req.cardId + req.clientIp + settings.transactionDate;
           return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/bankcard/delete",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
       
         end
   
         
   
   
   end