Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :items do
    resources :items, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :items, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :items, :except => :show do
        collection do
          post :update_positions
        end
      end
      #get 'add_photo', :to => 'item_photo#add_photo', :as => :add_photo
      match 'add_photo', to: 'items#add_photo', :as => :add_photo, via: [:patch, :put, :post]
    end
  end

end

# get 'news/more' => 'news::items#view_more', as: :news_view_more