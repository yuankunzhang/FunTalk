Rails.application.routes.draw do

  # resources :topics

  root 'pages#home'
  get 'about', to: 'pages#about', as: 'about'

  post 'topics', to: 'topics#create'

  get 'saml/init'
  post 'saml/consume'
end
