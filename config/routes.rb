Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create] do
        get :test, on: :member
      end
      
      resource :registration, only: [:create]

      resources :bank_accounts, only: [:index, :show, :create, :update, :destroy], module: :user

      resources :organizations, only: [:index, :show, :create, :update, :destroy] do
        get :mine, on: :collection

        resources :bank_accounts, only: [:index, :show, :create, :update, :destroy]
        resources :campaigns, only: [:create, :update, :destroy]
      end

      resources :campaigns, only: [:index, :show]
    end
  end

  root 'application#index'
end
