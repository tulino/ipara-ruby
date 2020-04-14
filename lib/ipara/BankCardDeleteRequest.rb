module Ipara
  class Bankcarddeleterequest
    
	#Cüzdanda kayıtlı olan kartı silmek için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :userId
    attr_accessor :cardId
    attr_accessor :clientIp
    
       
         # Nesnenin üretilmesi 
      
       # Mağazanın, kullanıcının bir kartını veya kayıtlı olan tüm kartlarını silmek istediği zaman kullanabileceği servisi temsil eder.
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.userId + req.cardId + req.clientIp + settings.transactionDate;
           return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/bankcard/delete",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
       
         end
   
         
   
   
end
end
