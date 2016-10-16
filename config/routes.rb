Rails.application.routes.draw do

  resources :topics

  root "pages#home"
end
