module Refinery
  module Items
    module Admin
      class ItemPhotoController < ::Refinery::AdminController
        #after_save :sss

        def index
          @photos = ItemPhoto.all
        end
       
        def new
          @photo = Refinery::Items::ItemPhoto.new
        end
       
        def create
          @photo = Refinery::Items::ItemPhoto.create(item_photo_params)
          # if @photo.save
          #   flash[:success] = "Photo saved!"
          #   redirect_to item_photo_path
          # else
          #   render 'new'
          # end
        end
        
      end
    end
  end
end



# module Refinery
#   class ItemPhotoController < ::ApplicationController
#   def index
#     @photos = ItemPhoto.all
#   end
 
#   def new
#     @photo = ItemPhoto.new
#   end
 
#   def create
#     @photo = ItemPhoto.new(photo_params)
#     if @photo.save
#       flash[:success] = "Photo saved!"
#       redirect_to item_photo_path
#     else
#       render 'new'
#     end
#   end
 
# 	end
# end


# class ItemPhotosController < ::ApplicationController
#   def index
#     @photos = ItemPhoto.all
#   end
 
#   def new
#     @photo = ItemPhoto.new
#   end
 
#   def create
#     @photo = ItemPhoto.new(photo_params)
#     if @photo.save
#       flash[:success] = "Photo saved!"
#       redirect_to item_photos_path
#     else
#       render 'new'
#     end
#   end
 
# end
