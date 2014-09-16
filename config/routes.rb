Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get 'heartbeat', to: 'heartbeat#index'

      resource :session, only: [:create] do
        get :test, on: :member
      end
      
      resource :registration, only: [:create]

      resources :bank_accounts, only: [:index, :show, :create, :destroy], module: :personal do
        resources :verifications, only: [:create]
      end
      
      resources :donations, only: [:index], module: :personal

      resources :organizations, only: [:index, :show, :create, :update, :destroy] do
        get :mine, on: :collection

        resources :bank_accounts, only: [:index, :show, :create, :destroy] do
          resources :verifications, only: [:create]
        end

        resources :campaigns, only: [:create, :update, :destroy] do
          resources :donations, only: [:index, :create]
        end
      end

      resources :campaigns, only: [:index, :show]
    end
  end

  root 'application#index'
end
