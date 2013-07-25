# -*- encoding : utf-8 -*-
Vzs::Application.routes.draw do

  match 'pages/:id-:slug' => 'pages#show', :as => :page_seo, :via => :get

  resources :pages
  resources :life_guarding_timespans, :path => "hlidani" do
    collection do
      get :current
    end
    member do
      get :select_modal
    end
    resources :life_guards do
      collection do
        put :subscribe
      end
      member do
        put :subscribe
        put :unsubscribe
      end
    end
  end

  resources :articles do
    collection do
      get :pending
    end
    resources :comments
    resources :attachments
  end

  resources :galleries do
    resources :photos do
      collection {post  :sort}
    end
  end

  resources :articles
  resources :galleries
  resources :events do
    collection do
      get 'old'
    end
    member do
      put :participate
      put :unparticipate
    end
  end

  get "user_sessions/new"

  resources :users do
    collection do
      get "emails"
    end
  end
  resources :user_sessions
  match 'register' => 'Users#new', :as => :register

  # vypis osob
  match 'clenove' => 'Users#index', :as => :members

  # authlogic veci
  match 'login' => 'UserSessions#new', :as => :login
  match 'logout' => 'UserSessions#destroy', :as => :logout

  root :to => 'Application#welcome'

  match '/feed' => 'Application#feed',
        :as => :feed,
        :defaults => { :format => 'atom' }

  match '/*a', :to => 'Application#welcome'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
