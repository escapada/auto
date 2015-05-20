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
          @all_photos = ItemPhoto.where(item_id: params[:item])
          @photo = ItemPhoto.new
          
        end

        def add_photo
          #@all_items = Array.new()    #params[:item_photo][:all]  
          @item = Item.new
          @photos = ItemPhoto.new
               
          @tmp_photo = params[:item_photo]
          @photo = ItemPhoto.new(params[:item_photo])

          respond_to do |format|
            if @photo.save
              #format.html { redirect_to refinery.items_admin_items_path, notice: 'Item saved! #{tmp_photo.count}' }
              format.js   {}
              #format.json { render json: @photo, status: :created, location: @photo }
            else
              render 'new'
            end
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