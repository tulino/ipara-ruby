module Ipara
  class Bankcardinquiryrequest
    
	#Cüzdanda bulunan kartları getirmek için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :userId
    attr_accessor :cardId
    attr_accessor :clientIp
    
       
         # Nesnenin üretilmesi 
      
		#Mağazanın, cüzdanda bulunan kartları getirmek için kullandığı servisi temsil eder.
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.userId + req.cardId + req.clientIp + settings.transactionDate;
           return  JSON.parse(Core::HttpClient::post(settings.BaseUrl+"/bankcard/inquiry",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_json),req.to_json))
       
         end
   
         
   
   
end
end
