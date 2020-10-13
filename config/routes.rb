Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'user_profiles', to: 'users/registrations#new_user_profile'
    post 'user_profiles', to: 'users/registrations#create_user_profile'
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
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
