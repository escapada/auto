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

        def imgs
          @id = params[:id]
          @all_photos = ItemPhoto.where(item_id: params[:id])
          @photo = ItemPhoto.new
          
        end

        def add_photo
          #@all_items = Array.new()    #params[:item_photo][:all]  
               
          #@tmp_photo = params[:item_photo]
          @photo = ItemPhoto.new(params[:item_photo])
          @photo.item_id = params[:id]

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
            a.main = false
          end
          @attach.main = true
           respond_to do |format|
             format.js
           end
        end

        def add_photo_
          @all_items = params[:item_photo][:all]       
          @tmp_photo = params[:item_photo].except(:all)

          @photo = ItemPhoto.new(@tmp_photo)
          if @photo.save
            flash[:success] = "Item saved! #{tmp_photo.count  }"
            @all_items << @tmp_photo
            #render :all_items => @all_items
          end
          #redirect_to refinery.items_admin_items_path
        end

        def delete_photo                   
            #@photo = ItemPhoto.new(params[:item_photo])
            #@photo.save
            #flash[:success] = "Item saved! #{tmp_photo.count  }"

            #redirect_to refinery.items_admin_items_path
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
