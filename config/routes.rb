Communitymarket::Application.routes.draw do
  resources :schools


  resources :dresses


  # mount Monologue::Engine, at: '/blog'
  resources :messages


  # resources :contacts


  match "/404", to: "exceptions#not_found", via: [:get, :post]
 
  
  
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  get '/auth/stripe_connect/callback', to: 'stripe_connect#create'

  # :registrations => "registrations", 
  resources :email_settings
  resources :followships
  
  
  # resources :assets do
  #    collection do
  #      post :post_create
  #    end
  #  end
  

  # resources :posts do
  #   resources :transactions
  # end
  
  resources :transactions do
    collection do
      post :customer_purchase
    end
  end
  resources :memberships do
    collection do
      put :update_individual
      post :join
    end
  end
  resources :followships do
    collection do
      post :follow
    end
  end
  resources :tags

  resources :users do
    collection do
      get :new_modal
    end
    resources :posts
    resources :groups
  end
  resources :pages do
    collection do
      # get :textbooks
      get :dorm_furniture
    end
  end
  # get 'users/new_modal'
  
  # member do
  #   get :new_modal
  # end
  
  resources :images
  resources :group_categories
  resources :post_categories
  #resources :sessions, :only => [:new, :create, :destroy]
  resources :groups do
    collection do
      put :bulk_update
      put :private
    end
  end



  #resource :session, controller: 'sessions'

  resources :posts do
    collection do
      get :sort_name
    end
    member do
      get :deactivate
      get :reactivate
      get :complete
      get :undo_completed
    end
    resources :assignments
  end
  
  match '/textbooks', to: "pages#textbooks"
  match '/admin', to: "pages#admin"
  match '/feed', :to =>"pages#feed"
  match '/bulk_update', :to => "groups#bulk_update"
  match '/for_sale', :to => "pages#for_sale"
  match '/borrow_rent', :to => "pages#borrow_rent"
  match '/services', to: "pages#services"
  match '/wanted', :to => "pages#wanted"
  match '/transactions/customer_purchase', :to => "transactions#customer_purchase"
  match '/memberships/join', :to => "memberships#join"
  match '/followships/follow', :to => "followships#join"
  match '/followships/leave', :to => "followships#leave", :via => :delete
  match '/groups/nearby', :to => "groups#nearby"
  match '/search', :to => 'search#index'
  match '/search_tags', :to => 'tags#search'
  match '/about', :to => 'pages#about'
  match '/jobs', to: 'pages#jobs'
  match '/landing', :to => 'pages#landing'
  match '/marketplace', to: 'pages#marketplace'
 # match '/facebook_update_and_post', :to => "users/omniauth_callbacks#facebook_update_and_post"
  # match '/signout', :to => 'sessions#destroy'
  # match '/sign_in', :to => 'sessions#new'
  # match '/signin', :to => 'sessions#new'
  match '/invites', :to => 'invites#new', via: :post
  match '/contacts', :to => 'contacts#new', via: :post

  mount CommunityMarket::API =>'/'
  get "/docs" => 'docs#index'

  root :to => 'pages#index'
  
  
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
