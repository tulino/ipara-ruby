module Ipara
  class Apipaymentrequest
    #3D Secure Olmadan Ödeme için gerekli olan servis girdi parametrelerini temsil eder.
      attr_accessor :Echo
      attr_accessor :Mode
      attr_accessor :ThreeD
      attr_accessor :OrderId
      attr_accessor :Amount
      attr_accessor :CardOwnerName
      attr_accessor :CardNumber
      attr_accessor :CardExpireMonth
      attr_accessor :CardExpireYear
      attr_accessor :Installment
      attr_accessor :Cvc
      attr_accessor :VendorId
      attr_accessor :UserId
      attr_accessor :CardId
      attr_accessor :ThreeDSecureCode
      attr_accessor :Products
      attr_accessor :Purchaser

      #3D Secure Olmadan Ödeme Servis çağrısını temsil eder.
          def execute(req,settings)
             settings.transactionDate=Core::Helper::GetTransactionDateString();
             settings.HashString = settings.PrivateKey + req.OrderId + req.Amount + req.Mode + req.CardOwnerName + req.CardNumber + req.CardExpireMonth + req.CardExpireYear + req.Cvc + req.UserId + req.CardId+ req.Purchaser.Name + req.Purchaser.SurName + req.Purchaser.Email + settings.transactionDate;
             result= Core::HttpClient::post(
                                  settings.BaseUrl+"rest/payment/auth",
                                  Core::Helper::GetHttpHeaders(settings,Core::Helper::Application_xml),
                                  self.to_xml(req,settings)
                                );
            if result != nil
              return Core::Helper::formatXMLOutput(result)
            else
              return "Result is NIL"
            end
          end

           def to_xml(req, settings)
              xml_data_product_part = "";
              req.Products.each { |product|
                 xml_data_product_part += "<product>\n" +
                  "	<productCode>" + product.Code + "</productCode>\n" +
                  "	<productName>" + product.Title + "</productName>\n" +
                  "	<quantity>" + product.Quantity.to_s  + "</quantity>\n" +
                  "	<price>" + product.Price.to_s  + "</price>\n" +
                  "</product>\n"
          }
          xml_string= "<?xml version='1.0' encoding='UTF-8' ?>
          <auth>
                      <cardOwnerName>"+req.CardOwnerName+"</cardOwnerName>
                      <cardNumber>"+req.CardNumber+"</cardNumber>
                      <cardExpireMonth>"+req.CardExpireMonth+"</cardExpireMonth>
                      <cardExpireYear>"+req.CardExpireYear+"</cardExpireYear>
                      <cardCvc>"+req.Cvc+"</cardCvc>
                      <userId>"+req.UserId+"</userId>
                      <cardId>"+req.CardId+"</cardId>
                      <installment>"+req.Installment+"</installment>
                       <threeD>"+req.ThreeD+"</threeD>
                      <orderId>"+req.OrderId+"</orderId>
                      <echo>"+req.Echo+"</echo>
                      <amount>"+req.Amount+"</amount>
                      <mode>"+req.Mode+"</mode>
                      <products>
                      "+xml_data_product_part+"
                         </products>
                      <purchaser>
                      <name>"+req.Purchaser.Name+"</name>
                      <surname>"+req.Purchaser.SurName+"</surname>
                      <email>"+req.Purchaser.Email+"</email>
                      <clientIp>"+req.Purchaser.ClientIp+"</clientIp>
                      <birthDate>"+req.Purchaser.BirthDate+"</birthDate>
                      <gsmNumber>"+req.Purchaser.GsmPhone+"</gsmNumber>
                      <tcCertificate>"+req.Purchaser.IdentityNumber+"</tcCertificate>
                          <invoiceAddress>
                                  <name>"+req.Purchaser.Invoiceaddress.Name+"</name>
                                  <surname>"+req.Purchaser.Invoiceaddress.SurName+"</surname>
                                  <address>"+req.Purchaser.Invoiceaddress.Address+"</address>
                                  <zipcode>"+req.Purchaser.Invoiceaddress.ZipCode+"</zipcode>
                                  <city>"+req.Purchaser.Invoiceaddress.CityCode+"</city>
                                  <tcCertificate>"+req.Purchaser.Invoiceaddress.IdentityNumber+"</tcCertificate>
                                  <country>"+req.Purchaser.Invoiceaddress.CountryCode+"</country>
                                  <taxNumber>"+req.Purchaser.Invoiceaddress.TaxNumber+"</taxNumber>
                                  <taxOffice>"+req.Purchaser.Invoiceaddress.TaxOffice+"</taxOffice>
                                  <companyName>"+req.Purchaser.Invoiceaddress.CompanyName+"</companyName>
                                  <phoneNumber>"+req.Purchaser.Invoiceaddress.PhoneNumber+"</phoneNumber>
                          </invoiceAddress>
                          <shippingAddress>
                          <name>"+req.Purchaser.Shippingaddress.Name+"</name>
                          <surname>"+req.Purchaser.Shippingaddress.SurName+"</surname>
                          <address>"+req.Purchaser.Shippingaddress.Address+"</address>
                          <zipcode>"+req.Purchaser.Shippingaddress.ZipCode+"</zipcode>
                          <city>"+req.Purchaser.Shippingaddress.CityCode+"</city>
                          <country>"+req.Purchaser.Shippingaddress.CountryCode+"</country>
                          <phoneNumber>"+req.Purchaser.Shippingaddress.PhoneNumber+"</phoneNumber>

                          </shippingAddress>
                          </purchaser>
          </auth> "
          return xml_string
          end



     end

     #Bu sınıf 3D secure olmadan ödeme kısmında müşteri bilgisinin alanlarını temsil eder.
  class Purchaser
      attr_accessor :Name
      attr_accessor :SurName
      attr_accessor :BirthDate
      attr_accessor :Email
      attr_accessor :GsmPhone
      attr_accessor :IdentityNumber
      attr_accessor :ClientIp

      attr_accessor :Invoiceaddress
      attr_accessor :Shippingaddress
    end



     #Bu sınıf 3D secure olmadan ödeme kısmında müşteri adres bilgisinin alanlarını temsil eder.

  class Purchaseraddress

          attr_accessor :Name
          attr_accessor :SurName
          attr_accessor :Address
          attr_accessor :ZipCode
          attr_accessor :CityCode
          attr_accessor :IdentityNumber
          attr_accessor :CountryCode
          attr_accessor :TaxNumber
          attr_accessor :TaxOffice
          attr_accessor :CompanyName
          attr_accessor :PhoneNumber
      end

    #Bu sınıf 3D secure olmadan ödeme kısmında ürün bilgisinin alanlarını temsil eder.

  class Product
                 attr_accessor :Code
                 attr_accessor :Title
                 attr_accessor :Quantity
                 attr_accessor :Price
      end
end
