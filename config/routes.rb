# -*- encoding : utf-8 -*-
Vzs::Application.routes.draw do

  match 'pages/:id-:slug' => 'pages#show', :as => :page_seo, :via => :get

  resources :pages

  resources :articles do
    collection do
      get :pending
    end
    resources :comments
    resources :attachments
  end

  resources :galleries do
    resources :photos
  end

  resources :articles
  resources :galleries
  resources :events do
    collection do
      get 'old'
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
