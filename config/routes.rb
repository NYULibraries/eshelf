Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'users/account', :as => :user_account
  get 'users/account/show' => 'users#account_render', :as => :user_account_render
  get 'users/tags', :as => :user_tags
  get 'account' => 'users#account', :as => :account

  resources :records, :except => [:new, :edit, :destroy] do
    get 'print/:print_format' => 'records#print', :on => :collection, :as => :print
    get 'print/:print_format' => 'records#print', :on => :member, :as => :print
    get 'email/new(/:email_format)' => 'records#new_email', :on => :collection, :as => :new_email
    get 'email/new' => 'records#new_email', :on => :member, :as => :new_email
    post 'email' => 'records#create_email', :on => :collection, :as => :email
    get 'from/:external_system(/:per)' => 'records#from_external_system', :on => :collection
    get 'getit' => 'records#getit', :on => :member, :as => :getit
  end
  delete 'records' => 'records#destroy', :as => :destroy_records
  delete 'records.json' => 'records#destroy'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    # Force the HTTPS version of this url because doorkeeper requires it
    get 'login', to: redirect { |params, request| "#{Rails.application.config.relative_url_root}/users/auth/nyulibraries?#{request.query_string}" }, as: :login
  end

  get '/healthcheck' => 'application#healthcheck'

  root 'records#index'
end
