RailsBestpracticesCom::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users", :sessions => "sessions", :passwords => "passwords"}
  devise_scope :user do
    resources :users, :only => [:index, :show]
  end
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => redirect('/')
  resources :authentications

  resources :tags, :only => :show

  resources :posts do
    get :archive, :on => :collection
    resources :comments, :only => :create
    resources :votes, :only => [:create, :destroy]
  end
  resources :comments, :only => :index

  resources :questions do
    resources :answers
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end
  resources :answers do
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end

  scope '/blog' do
    resources :posts, :controller => :blog_posts, :as => :blog_posts, :only => [:index, :show] do
      resources :comments, :only => :create
    end
  end

  resources :notifications, :only => [:index, :destroy]

  resources :jobs do
    get :partner, :on => :collection
  end

  resources :sponsors, :only => [:show]

  match 'search' => 'search#show', :as => :search

  match 'page/:name' => 'pages#show', :as => :page

  root :to => "posts#index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
end
