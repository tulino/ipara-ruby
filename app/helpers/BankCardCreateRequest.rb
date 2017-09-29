
class Bankcardcreaterequest
    
    attr_accessor :userId
    attr_accessor :cardOwnerName
    attr_accessor :cardNumber
    attr_accessor :cardAlias
    attr_accessor :cardExpireMonth
    attr_accessor :cardExpireYear
    attr_accessor :clientIp
    
       
         # Nesnenin üretilmesi 
      
       
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.userId + req.cardOwnerName + req.cardNumber + req.cardExpireMonth + req.cardExpireYear + req.clientIp + settings.transactionDate;
           return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/bankcard/create",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
       
         end
   
         
   
   
   end