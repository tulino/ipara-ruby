module Ipara
  class Bankcardcreaterequest
    # Cüzdana kart ekleme servisi içerisinde kullanılacak alanları temsil etmektedir.
    attr_accessor :userId
    attr_accessor :cardOwnerName
    attr_accessor :cardNumber
    attr_accessor :cardAlias
    attr_accessor :cardExpireMonth
    attr_accessor :cardExpireYear
    attr_accessor :clientIp
    
       
         # Nesnenin üretilmesi 
      
       
=begin
	   Cüzdana kart ekleme istek metodur. Bu metod çeşitli kart bilgilerini ve settings sınıfı içerisinde bize özel olarak oluşan alanları kullanarak
       cüzdana bir kartı kaydetmemizi sağlar.
=end
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.userId + req.cardOwnerName + req.cardNumber + req.cardExpireMonth + req.cardExpireYear + req.clientIp + settings.transactionDate;
           return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/bankcard/create",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
       
         end
   
         
   
   
end
end
