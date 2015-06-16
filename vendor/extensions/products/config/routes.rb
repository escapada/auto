Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :products do
    resources :products, :path => '', :only => [:index, :show]
    match 'search', to: 'products#search', :as => :filter, via: [:post]
    match '/', to: 'products#index', :as => :modelid, via: [:post]
  end

  # Admin routes
  namespace :products, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end

      match 'search', to: 'products#search', :as => :search, via: [:post]
      #match 'filter', to: 'products#filter', :as => :filter, via: [:post]
      match 'product_add_photo', to: 'products#add_photo', :as => :add_photo, via: [:patch, :put, :post]
      match 'product_imgs/:id', to: 'products#imgs', :as => :imgs, via: [:get]
      match 'product_delete_img/:id', to: 'products#delete_img', :as => :delete_img, via: [:post]
      #match 'main_img/:id', to: 'products#main_img', :as => :main_img, via: [:post]
      match 'subtype_new', to: 'products#subtype_new', :as => :subnew, via: [:post]
      match 'subtype_delete', to: 'products#subtype_delete', :as => :subdelete, via: [:post]
      match 'subtype_update', to: 'products#subtype_update', :as => :subupdate, via: [:post]
      ##
      match 'model_new', to: 'products#model_new', :as => :modelnew, via: [:post]
      match 'model_delete', to: 'products#model_delete', :as => :modeldelete, via: [:post]
      match 'model_update', to: 'products#model_update', :as => :modelupdate, via: [:post]
      ##to display filtered list of products in products admin index view (NOT AJAX)
      match 'set_filter', to: 'products#set_filter', :as => :setfilter, via: [:get]
      match 'reset_session', to: 'products#reset_session', :as => :resetsession, via: [:post]

      ##filter lists of models/types trees in products admin index view (NOT AJAX)
      ##match 'filter', to: 'products#filter', :as => :filter, via: [:post]

    end
  end

end
