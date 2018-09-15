Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  # devise_for :users, only: [:sessions]

  namespace :api, :defaults => { :format => 'json' } do
    # resources :musicians, only: [:index, :show]

    resources :plans
    get "my-plan", to: 'plans#my_plan'
    post "update-plan", to: 'plans#update_plan'
    resources :measurements
    get 'public-profile/:id', to: 'plans#public_profile'
    get 'my-profile', to: 'profile#my_profile'
    get 'public-measurements/:id/:page', to: 'measurements#public_measurements'
    post 'upload-image', to: 'measurements#image_upload'
    post 'change-avatar', to: 'profile#change_avatar'
    get 'active-plans', to: 'plans#active_plans'

    post 'auth', to: 'auths#create'

      post 'auth', to: 'auths#create'
    namespace :admin do
      # as :user do
      #   get 'sign_out', to: '/devise/sessions#destroy'
      # end
      # resources :dashboard, only: :index
      # resources :users, except: :show
      # resources :musicians, except: :show
    end
  end

  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
end