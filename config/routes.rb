Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # resources :topics

  root 'pages#home'
  get 'about', to: 'pages#about', as: 'about'
  get 'archives', to: 'pages#archives', as: 'archives'

  post 'topics', to: 'topics#create'
  get 'topic/:id', to: 'topics#show', as: 'topic'
  get 'topics/pending', to: 'topics#get_pending'
  get 'topics/archived', to: 'topics#get_archived'

  get 'saml/init'
  post 'saml/consume'
end
