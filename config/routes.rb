Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create] do
        get :test, on: :member
      end
      
      resource :registration, only: [:create]
    end
  end

  root 'application#index'
end
