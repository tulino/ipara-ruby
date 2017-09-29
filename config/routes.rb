Rails.application.routes.draw do
  get 'home/index'
  get 'home/threeDResultSuccess'
  get 'home/threeDResultFail'
  get 'home/bininqury'
  get 'home/addCardToWallet'
  get 'home/getCardFromWallet'
  get 'home/deleteCardFromWallet'
  get 'home/paymentinqury'
  get 'home/apiPayment'
  get 'home/apiPaymentWithWallet'
  
  post 'home/index'
  post 'home/bininqury'
  post 'home/addCardToWallet'
  post 'home/getCardFromWallet'
  post 'home/deleteCardFromWallet'
  post 'home/paymentinqury'
  post 'home/apiPayment'
  post 'home/apiPaymentWithWallet'
  post 'home/threeDResultSuccess'
  post 'home/threeDResultFail'
  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
