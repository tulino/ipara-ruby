


class Settings

=begin
Tüm çağrılarda kullanılacak ayarların tutulduğu sınıftır. 
Bu sınıf üzerinde size özel parametreler fonksiyonlar arasında taşınabilir.
 Bu sınıf üzerinde tüm sistemde kullanacağımız ayarları tutar ve bunlara göre işlem yaparız.
 Bu sınıf örnek projemizde BaseController içerisinde kullanılmıştır. Ve tüm ayarların kullanılacağı yerde karşımıza çıkmaktadır.
=end

    attr_accessor :PublicKey #Public Magaza Anahtarı - size mağaza başvurunuz sonucunda gönderilen public key (açık anahtar) bilgisini kullanınız.
    attr_accessor :PrivateKey #Private Magaza Anahtarı  - size mağaza başvurunuz sonucunda gönderilen privaye key (gizli anahtar) bilgisini kullanınız.
    attr_accessor :BaseUrl #iPara web servisleri API url'lerinin başlangıç bilgisidir.
    attr_accessor :ThreeDInquiryUrl
    attr_accessor :Mode #Test -> T, entegrasyon testlerinin sırasında "T" modunu, canlı sisteme entegre olarak ödeme almaya başlamak için ise Prod -> "P" modunu kullanınız.
    attr_accessor :Echo #3D secure işlemlerinde kullanacağımız url adresini temsil eder
    attr_accessor :Version # Kullandığınız iPara API versiyonudur. 
    attr_accessor :HashString # Kullanacağınız hash bilgisini, bağlanmak istediğiniz web servis bilgisine göre doldurulmalıdır.
    attr_accessor :transactionDate #Api çağrılarında transactionDate olarak kullanacağımız alan bilgisidir.

      # Nesnenin üretilmesi
      def initialize()

      end

end
