Issues::Application.routes.draw do
  root :to => "pages#home"

  get '/home', to: redirect('/')

  match "/home" => "pages#home" , via: [:get, :post]
  match "/about" => "pages#about" , via: [:get, :post]
  match "/contact" => "pages#contact" , via: [:get, :post]
  match "/signup" => "users#new" , via: [:get, :post]
  match "/signin" => "sessions#new", via: [:get, :post]
  match "/signout" => "sessions#destroy", via: [:get, :post]

  get "timeline/index"

  resources :microposts
  resources :users
  resources :issues
  resources :projects
  resources :sessions, :only => [:new, :create, :destroy]

  resources :projects do
    resources :issues
  end


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
