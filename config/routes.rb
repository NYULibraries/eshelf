Eshelf::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # See how all your routes lay out with "rake routes"
  mount ExCite::Engine, :at => '/', :as => :ex_cite

  get "users/account", :as => :user_account
  get "users/tags", :as => :user_tags
  match 'account', :to => 'users#account', :as => :account

  resources(:records, :except => [:new, :edit]) do
    get 'print/:print_format', :to => 'records#print', :on => :collection, :as => :print
    get 'print/:print_format', :to => 'records#print', :on => :member, :as => :print
    get 'email/new(/:email_format)', :to => 'records#new_email', :on => :collection, :as => :new_email
    get 'email/new', :to => 'records#new_email', :on => :member, :as => :new_email
    post 'email', :to => 'records#create_email', :on => :collection, :as => :email
    get 'from/:external_system(/:per)', :to => 'records#from_external_system', :on => :collection
    delete 'destroy', :on => :collection
    get 'getit', :to => 'records#getit', :on => :member, :as => :getit
  end

  match 'login', :to => 'user_sessions#new', :as => :login
  match 'logout', :to => 'user_sessions#destroy', :as => :logout
  match 'validate', :to => 'user_sessions#validate', :as => :validate

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "records#index"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
