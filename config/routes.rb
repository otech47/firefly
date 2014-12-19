Rails.application.routes.draw do
  require 'sidekiq/web'

  resources :observers

  devise_for :users, :path => '', :path_names => { :sign_in => "signin", :sign_out => "logout", :sign_up => "registration" }, :controllers => { :registrations => "registrations" }

  get 'dashboard' => 'dashboard#welcome'

  get 'rules' => 'page#rules'
  get 'land' => 'page#land'

  namespace :api, :path => "api", :defaults => {:format => :json} do
    namespace :v1 do
      get 'validate/observer' => 'validate#observer'
    end
  end

  namespace :admin, :path => "admin" do
    get 'dashboard' => 'admin#dashboard'
    get 'observer' => 'admin#observer'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  root 'page#home'

  mount Sidekiq::Web, at: '/sidekiq'

end
