class ApplicationController < ActionController::Base
    require_dependency "ipara"
    include Ipara
    @@settings=Settings.new
    @@settings.PublicKey = "" #//"Public Magaza Anahtarı - size mağaza başvurunuz sonucunda gönderilen public key (açık anahtar) bilgisini kullanınız.",
    @@settings.PrivateKey = "" #"Private Magaza Anahtarı  - size mağaza başvurunuz sonucunda gönderilen privaye key (gizli anahtar) bilgisini kullanınız.",
    @@settings.BaseUrl = "https://api.ipara.com/" #iPara web servisleri API url'lerinin başlangıç bilgisidir. Restful web servis isteklerini takip eden kodlar halinde bulacaksınız.
                                        # Örneğin "https://api.ipara.com/" + "/rest/payment/auth"  = "https://api.ipara.com/rest/payment/auth"
    @@settings.ThreeDInquiryUrl = "https://www.ipara.com/3dgate"
    @@settings.Version = "1.0" # Kullandığınız iPara API versiyonudur.
    @@settings.Mode = "T" #Test -> T, entegrasyon testlerinin sırasında "T" modunu, canlı sisteme entegre olarak ödeme almaya başlamak için ise Prod -> "P" modunu kullanınız.
    @@settings.HashString = "" #// Kullanacağınız hash bilgisini, bağlanmak istediğiniz web servis bilgisine göre doldurulmalıdır. Bu bilgileri Entegrasyon rehberinin ilgili web servise ait bölümde bulabilirsiniz.
    @@settings.Echo=""
end
