Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create] do
        get :test, on: :member
      end
      
      resource :registration, only: [:create]

      resources :bank_accounts, only: [:index, :show, :create, :destroy], module: :user do
        resources :verifications, only: [:create]
      end
      # TODO:
      # resources :donations, only: [:index] # User's donations

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
