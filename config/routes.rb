RailsBestpracticesCom::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users", :sessions => "sessions", :passwords => "passwords"}
  devise_scope :user do
    resources :users, :only => [:index, :show]
  end
  get '/auth/:provider/callback' => 'authentications#create'
  post '/auth/:provider/callback' => 'authentications#create'
  get '/auth/failure' => redirect('/')

  resources :tags, :only => :show

  concern :voteable do
    resources :votes, only: [:create, :destroy]
  end

  resources :posts, :except => :destroy do
    concerns :voteable
    get :archive, :on => :collection
  end

  resources :questions, :only => [:show, :new, :create, :edit, :update, :index] do
    concerns :voteable
    resources :answers, :only => :create
  end

  resources :answers, :only => [:show, :create] do
    concerns :voteable
  end

  scope '/blog' do
    resources :posts, :controller => :blog_posts, :as => :blog_posts, :only => [:index, :show]
  end

  resources :notifications, :only => [:index, :destroy]

  resources :jobs, :only => [:show, :new, :create, :edit, :update, :index] do
    get :partner, :on => :collection
  end

  resources :sponsors, :only => [:show]

  get 'search' => 'search#show', :as => :search

  get 'page/:name' => 'pages#show', :as => :page

  root :to => "posts#index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
