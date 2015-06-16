module Refinery
  module Items
    module Admin
      class ItemsController < ::Refinery::AdminController

        crudify :'refinery/items/item',
                :title_attribute => 'title',
                :order => "position DESC",
                :sortable => false,
                :xhr_paging => true

        def imgs
          @id = params[:id]
          @all_photos = ItemPhoto.where(item_id: params[:id])
          @photo = ItemPhoto.new
          
        end

        def add_photo
          @photo = ItemPhoto.new(params[:item_photo])
          @photo.item_id = params[:id]
          @photo.main = false

          if @photo.save
            redirect_to refinery.items_admin_imgs_path(params[:id]), notice: 'Item saved!'
          else
            redirect_to refinery.items_admin_imgs_path(params[:id]), notice: 'Not saved!'
          end
        end

        def delete_img
          @attach = ItemPhoto.find(params[:id])
          @attach.image = nil
          @attach.destroy
           respond_to do |format|
             format.js
           end
        end

        def main_img
          @attach = ItemPhoto.find(params[:id])
          @attachs = ItemPhoto.where(item_id: @attach.item_id)
          @attachs.each do |a|
            if a.main
              @old = a.id 
              a.main = false
              a.save
            end 
          end
          @attach.main = true
          @attach.save

         respond_to do |format|
           format.js
         end
        end



    #     def new
				# 	@item = Item.new
				# 	@photos = ItemPhoto.new
				# end
				# def create
				# 	@item = Item.new(params[:item].except(:item_photo))
					
				# 	if @item.save
    #         flash[:success] = "Item saved!"
    #         redirect_to refinery.items_admin_items_path
    #       else
    #         render 'new'
    #       end

				# 	# if @item.save
				# 	# 	render
				# 	# end
				# end

      end
    end
  end
end
