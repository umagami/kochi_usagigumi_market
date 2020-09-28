Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users, only: [:index, :show]
  resources :items, only: [:index, :show] do
    member do 
     get 'buy'
    end
 end
end
