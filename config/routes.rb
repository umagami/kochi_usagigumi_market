Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # get 'items/buy/:id', to: 'items#buy', as: 'buy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:index, :show] do
    member do 
     get 'buy'
    end
 end
end
