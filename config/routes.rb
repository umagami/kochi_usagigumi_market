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

  resources :items do
    member do
     get 'buy'
     post "purchase"
    end
  end
  resources :users, only: [:index, :show] do
    member do
      get 'out'
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy] do
    resources :users, only: [:index, :show] do
      member do
        get 'out'
      end
    end
  end
end
