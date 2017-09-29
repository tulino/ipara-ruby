
class Paymentinquiryrequest
    
     attr_accessor :orderId   
       
         # Nesnenin üretilmesi 
      
       
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.orderId + settings.Mode + settings.transactionDate
       p self.to_xml(req,settings)
         return Core::HttpClient::post(settings.BaseUrl+"rest/payment/inquiry",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_xml),self.to_xml(req,settings))
          end
   
         def to_xml(req, settings)
          return "<?xml version='1.0' encoding='UTF-8' ?><inquiry><orderId>"+req.orderId+"</orderId><echo>"+settings.Echo+"</echo><mode>"+settings.Mode+"</mode></inquiry>"
         end

         
   
   end