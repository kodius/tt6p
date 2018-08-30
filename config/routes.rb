Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  localized do
    devise_for :users, only: [:sessions]

    namespace :api, :defaults => { :format => 'json' } do
      resources :musicians, only: [:index, :show]

      resources :plans
      get "my-plan", to: 'plans#my_plan'
      resources :measurements
      post 'entry', to: 'entry#show'
      get 'public-profile/:id', to: 'plans#public_profile'
      get 'public-measurements/:id', to: 'measurements#public_measurements'
      post 'upload-image', to: 'measurements#image_upload'

      namespace :admin do
        as :user do
          delete 'sign_out', to: '/devise/sessions#destroy'
        end
        resources :dashboard, only: :index
        resources :users, except: :show
        resources :musicians, except: :show
      end
    end

    root :to => "application#index"
    match "*path", to: "application#index", format: false, via: :get
  end

end
