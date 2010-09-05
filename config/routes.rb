RailsBestpracticesCom::Application.routes.draw do |map|
  #match "admin/acts_as_taggable_on/tags", :to => "admin/acts_as_taggable_on/tags#index"
  Typus::Routes.draw(map)

  match "/tags/:id/posts" => redirect { |params, req| req.query_string.index('page') ? "/tags/#{params[:id]}?#{req.query_string.sub(/controller=.*?&/, '').sub(/action=.*?&/, '')}" : "/tags/#{params[:id]}?nav=posts" }
  match "/tags/:id/questions" => redirect { |params, req| req.query_string.index('page') ? "/tags/#{params[:id]}?#{req.query_string.sub(/controller=.*?&/, '').sub(/action=.*?&/, '')}" : "/tags/#{params[:id]}?nav=questions" }
  resources :tags, :only => :show

  resources :posts do
    get :archive, :on => :collection
    resources :comments, :only => :create
    resources :votes, :only => [:create, :destroy]
    resource :implementation
  end
  resources :comments, :only => :index
  resources :implementations do
    resources :comments, :only => :create
  end
  
  resources :questions do
    resources :answers
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end
  resources :answers do
    resources :votes, :only => [:create, :destroy]
    resources :comments, :only => :create
  end

  resources :notifications, :only => [:index, :destroy]

  resources :drops

  resources :users

  resource :user_session

  match 'search' => 'search#show', :as => :search
  
  match 'page/:name' => 'pages#show', :as => :page

  match 'close_broadcast' => 'broadcasts#close', :as => :close_broadcast

  root :to => "posts#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
