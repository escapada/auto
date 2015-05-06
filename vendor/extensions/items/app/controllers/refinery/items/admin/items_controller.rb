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

      end
    end
  end
end
