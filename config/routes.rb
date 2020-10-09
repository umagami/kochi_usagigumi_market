Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end

  resources :items, only: [:index, :show, :new, :create] do
    member do
     get 'buy'
    end
  end
  resources :users, only: [:index, :show] do
    member do
      get 'out'
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy] do
    member do
      get 'payment_method'
      # post 'show', to: 'cards#show'
      # post 'pay', to: 'cards#pay'
      # post 'delete', to: 'cards#delete'
    end
  end
end
