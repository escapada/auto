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
    end
  end

end
