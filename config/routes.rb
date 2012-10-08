RailsBestpracticesCom::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users", :sessions => "sessions", :passwords => "passwords"}
  devise_scope :user do
    resources :users, :only => [:index, :show]
  end
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => redirect('/')

  resources :tags, :only => :show

  resources :posts, :except => :destroy do
    get :archive, :on => :collection
    resources :comments, :only => :create
    resources :votes, :only => [:create, :destroy]
  end
  resources :comments, :only => :index

  resources :questions, :only => [:show, :new, :create, :edit, :update, :index] do
    resources :answers, :only => :create
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end
  resources :answers, :only => :create do
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end

  scope '/blog' do
    resources :posts, :controller => :blog_posts, :as => :blog_posts, :only => [:index, :show] do
      resources :comments, :only => :create
    end
  end

  resources :notifications, :only => [:index, :destroy]

  resources :jobs, :only => [:show, :new, :create, :edit, :update, :index] do
    get :partner, :on => :collection
  end

  resources :sponsors, :only => [:show]

  match 'search' => 'search#show', :as => :search

  match 'page/:name' => 'pages#show', :as => :page

  root :to => "posts#index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
