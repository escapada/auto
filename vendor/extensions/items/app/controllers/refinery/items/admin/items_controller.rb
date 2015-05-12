module Refinery
  module Items
    module Admin
      class ItemsController < ::Refinery::AdminController

        crudify :'refinery/items/item',
                :title_attribute => 'model',
                :xhr_paging => true


        def new
					@item = Item.new
					@photos = ItemPhoto.new
				end
				def create
					@item = Item.new(params[:item].except(:item_photo))
					
					if @item.save
            tmp_photo = params[:item][:item_photo]
						
            @photo = ItemPhoto.new(params[:item][:item_photo])
            @photo.item_id = @item.id
            @photo.save
            flash[:success] = "Item saved! #{tmp_photo	}"
            redirect_to refinery.items_admin_items_path
          else
            render 'new'
          end

					# if @item.save
					# 	render
					# end
				end

        def add_photo       
            tmp_photo = params[:item][:item_photo]
            
            @photo = ItemPhoto.new(params[:item][:item_photo])
            @photo.save
            flash[:success] = "Item saved! #{tmp_photo  }"
            redirect_to refinery.items_admin_items_path
        end

        def before_attach(photos)
          up_photos = Array.new()
          photos.each do |photo|
            one = ItemPhoto.create(photo)
            up_photos << one
          end
          render :list => up_photos
        end 

      end
    end
  end
end
