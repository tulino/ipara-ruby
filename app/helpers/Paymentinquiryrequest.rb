
class Paymentinquiryrequest

	# Ödeme sorugulama servisi için gerekli olan servis girdi parametrelerini temsil eder.
     attr_accessor :orderId

         # Nesnenin üretilmesi

		#Bu servise sorgulanmak istenen ödemenin mağaza sipariş numarası ve mode değeri iletilerek, ödemenin durumu ve ödemenin tutarı öğrenilebileceği servisi temsil eder.
         def execute(req,settings)
           settings.transactionDate=Core::Helper::GetTransactionDateString()
           settings.HashString = settings.PrivateKey + req.orderId + settings.Mode + settings.transactionDate
           p self.to_xml(req,settings)
           result =  Core::HttpClient::post(settings.BaseUrl+"rest/payment/inquiry",Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_xml),self.to_xml(req,settings))
           if result != nil
             return Core::Helper::formatXMLOutput(result)
           else
            return "Result is NIL"
            end
        end

         def to_xml(req, settings)
          return "<?xml version='1.0' encoding='UTF-8' ?><inquiry><orderId>"+req.orderId+"</orderId><echo>"+settings.Echo+"</echo><mode>"+settings.Mode+"</mode></inquiry>"
         end



   end
