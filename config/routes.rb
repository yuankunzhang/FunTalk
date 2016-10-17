Rails.application.routes.draw do

  resources :topics

  root "pages#home"

  get 'saml/init'
  post 'saml/consume'
end
