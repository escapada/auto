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
      ##
      match 'set_filter', to: 'products#set_filter', :as => :setfilter, via: [:post]


    end
  end

end
