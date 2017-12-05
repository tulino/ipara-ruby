module Core

require "rexml/document"

class Helper

    TransactionDate = "transactionDate";
    Version = "version";
    Token = "token";
    Accept = "Accept";
    Application_xml = "application/xml";
    Application_json = "application/json";

	
=begin
	Doğru formatta tarih döndüren yardımcı sınıftır. Isteklerde tarih istenen noktalarda bu fonksiyon sonucu kullanılır. 
	Servis çağrılarında kullanılacak istek zamanı için istenen tarih formatında bu fonksiyon kullanılmalıdır.
	Bu fonksiyon verdiğimiz tarih değerini iParanın bizden beklemiş olduğu tarih formatına değiştirmektedir.
=end
	
    def self.GetTransactionDateString()
         return DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    end

	#parametre olarak verilen key bilgisini Sha1 algoritmasıyla hasleyerek geri döndürür.
    def self.Sha1Creator(key)
    p Digest::SHA1.hexdigest(key)

    end

=begin
	Çağrılarda kullanılacak Tokenları oluşturan yardımcı metotdur. 
	İstek güvenlik bilgisi kullanılacak tüm çağrılarda token oluşturmamız gerekmektedir.
	Token oluştururken hash bilgisi ve public key alanlarının parametre olarak gönderilmesi gerekmektedir.
	hashstring alanı servise ait birden fazla alanın birleşmesi sonucu oluşan verileri ve public key mağaza açık anahtarını 
    kullanarak bizlere token üretmemizi sağlar.
=end

def self.CreateToken(publicKey, hashString)
        return publicKey+ ":" +Digest::SHA1.base64digest(hashString)
     end
	
=begin
	Verilen string i SHA1 ile hashleyip Base64 formatına çeviren fonksiyondur. 
	CreateToken dan farklı olarak token oluşturmaz sadece hash hesaplar
=end
     def self.ComputeHash(hashString)
        return Digest::SHA1.base64digest(hashString)
     end

	 #Bir çok çağrıda kullanılan HTTP Header bilgilerini otomatik olarak ekleyen fonksiyondur. 
     def self.GetHttpHeaders(settings, acceptType)
        # header = {:accept =>acceptType, :'' => acceptType}
        header={}
        header[:'accept'] = acceptType
        header[:'content-type'] = acceptType
        header[:'Token'] = Core::Helper::CreateToken(settings.PublicKey,settings.HashString)
        # p Core::Helper::CreateToken(settings.PublicKey,settings.HashString)
        header[:'Version'] = settings.Version
        header[:'transactionDate'] = settings.transactionDate
        return header
    end
	
=begin
	3D akışının ilk adımında yapılan işlemin ardından gelen cevabın doğrulanması adına kullanılacak fonksiyondur.
	Ödeme cevabı için response içerisinde hash bilgisine bakılarak işlem yapılır.
	hash bilgisi boş değilse çeşitli parametrelerle hashtext oluşturulur ve hash bilgisi hesaplanır.
	Hesaplanan hash bilgisi ile cevap sonucunda oluşan istek bilgisinin doğruluğu burada kontrol edilir.
=end
 
    def self.Validate3DReturn(paymentResponse,settings)

        if paymentResponse.Hash ==nil

            throw :Exception,
            'Ödeme cevabı hash bilgisi boş. '
        end
         hashText = paymentResponse.OrderId + paymentResponse.Result + paymentResponse.Amount + paymentResponse.Mode + paymentResponse.ErrorCode +
        paymentResponse.ErrorMessage + paymentResponse.TransactionDate + settings.PublicKey + settings.PrivateKey
         hashedText = Core::Helper::ComputeHash(hashText)
        if (hashedText != paymentResponse.Hash)
            throw :Exception,
            'Ödeme cevabı hash doğrulaması hatalı. '
        end
        return true

    end
	#Verilen input değerinin xml şeklinde çıktısının alınmasını sağlar.
    def self.formatXMLOutput(input)
      xml = REXML::Document.new(input)
      formatter = REXML::Formatters::Pretty.new
      formatter.compact = true
      output = ""
      formatter.write(xml, output);
      return output
    end

end


class HttpClient
	#parametre olarak verilen url ve header bilgisiyle istenen url adresine istekte bulunan fonksiyonu temsil eder.
    def self.get(url, header={})
        puts "---IN HTTP GET---";
        puts "URL: " + url;
        RestClient.get(url, header);
        puts "---HTTP GET OUT---";
      end

	  #parametre olarak verilen url,header ve content bilgilerini kullanarak ilgili url adresine post işleminde bulunmasını sağlayan fonksiyonu temsil eder.
      def self.post(url, header, content)
        puts "---IN HTTP POST---"
        puts "URL: " + url
        puts "HEADER.accept: " + header[:'accept']
        puts "HEADER.content-type: " + header[:'content-type']
        puts "HEADER.Token: " + header[:'Token']
        puts "HEADER.Version: " + header[:'Version']
        puts "HEADER.transactionDate: " + header[:'transactionDate']
        puts "REQUEST\n"
        puts content
          response = RestClient.post(url, content, header)
        if response == nil
          puts "RESPONSE IS NIL";
        else
          puts "RESPONSE\n" + response;
        end
        puts "---HTTP POST OUT---"
        return response.force_encoding("UTF-8")
      end
 end

end
