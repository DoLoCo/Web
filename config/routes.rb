Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create] do
        get :test, on: :member
      end
      
      resource :registration, only: [:create]

      resources :organizations, only: [:index, :show, :create, :update, :delete] do
        get :mine, on: :collection

        resources :campaigns, only: [:create, :update, :destroy]
      end

      resources :campaigns, only: [:index, :show]
    end
  end

  root 'application#index'
end
