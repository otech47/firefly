Rails.application.routes.draw do
  resources :teams

  resources :observers

  devise_for :users, :path => '', :path_names => { :sign_in => "signin", :sign_out => "logout", :sign_up => "registration" }, :controllers => { :registrations => "registrations" }

  get 'dashboard' => 'dashboard#welcome'
  get 'hacker/:id' => 'dashboard#profile', :as => 'hacker_profile'

  get 'foreveralone' => 'dashboard#foreveralone'
  get 'participants' => 'dashboard#participants'

  get 'rules' => 'page#rules'
  get 'land' => 'page#land'

  namespace :api, :path => "api", :defaults => {:format => :json} do
    namespace :v1 do
      get 'validate/observer' => 'validate#observer'
      get 'validate/team' => 'validate#team'
      get 'qrcode/generate' => 'qrcode#generate'
      get 'attendees/checkin' => 'attendees#check_in'
      post 'process/cameratag' => 'process#cameratag'
      get 'process/lookup/hacker' => 'attendees#hacker_look_up'

      get 'team/all' => 'team#all'
      get 'team/:id' => 'team#team'
      get 'team/invite/:by_who/:hacker_id' => 'team#invite', :as => 'team_invite_sis'
      get 'team/invite/join/:hacker_id/:team_id' => 'team#join', :as => 'team_join_sis'
      get 'team/currently/presenting' => 'team#currently_presenting', :as => 'currently_presenting'
    end
  end

  namespace :admin, :path => "admin" do
    get 'hackers' => 'admin#hackers'
    get 'observers' => 'admin#observers'
    get 'checkin' => 'admin#checkin'
    get 'presenting' => 'admin#presenting'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  root 'page#home'

  #mount Sidekiq::Web, at: '/sidekiq'

end
