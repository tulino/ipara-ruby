module Ipara

  AppRoute = Rails.application.routes.url_helpers
  # require_dependency 'db_variables'

  require_dependency 'ipara/Apipaymentrequest'
  require_dependency 'ipara/Threedpaymentrequest'
  require_dependency 'ipara/Threedinitresponse'
  require_dependency 'ipara/Threedpaymentcompleterequest'
  require_dependency 'ipara/Paymentinquiryrequest'
  require_dependency 'ipara/Binnumberrequest'
  require_dependency 'ipara/BankCardCreateRequest'
  require_dependency 'ipara/BankCardInquiryRequest'
  require_dependency 'ipara/BankCardDeleteRequest'

end
