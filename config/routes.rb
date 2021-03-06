Rails.application.routes.draw do
  post "/users" => "users#create"
  # clearance routes --> have to be commented out to avoid two-time-redefine
  # resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  # resource :session, controller: "clearance/sessions", only: [:create]

  # resources :users, controller: "clearance/users", only: [:create] do
  #   resource :password,
  #     controller: "clearance/passwords",
  #     only: [:create, :edit, :update]
  # end
  root to: "application#index"
  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out_v2"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  resource :sessions, only: [:create]
  resources :users, only: [:edit, :show]
  
  resources :listings
  resources :bookings, only: [:create, :edit, :destroy]
  # get '/users/:id', :to => 'users#show', :as => :user
  # get '/listings/:id', :to => 'listings#show', :as => :listing
  # omniauth-facebook
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get '/search', to: 'listings#search'
  
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  # clearance


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
