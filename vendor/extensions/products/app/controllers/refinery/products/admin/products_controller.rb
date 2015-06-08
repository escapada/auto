module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        before_filter :find_categories, :only => :new

        crudify :'refinery/products/product',
                :xhr_paging => true,
                :include => [:carmodelsubtype]#,
                #:conditions => 'carmodelsubtype_id=1'

        
        def tmp_for_comment_lines
                  # tmp = Product.includes(:carmodels).all
          # if params[:filter]
          #   case params[:filter]
          #   when params[:filter][:carmodel_id]
          #     tmp.each do |product|
          #       @products << product if product.carmodel_ids.any? { |elem| elem ==  params[:filter][:carmodel_id] }
          #     end
          #   #else
          #   end
          # else
          #   @products = tmp
          # end
          #   #@products = Product.filter(params[:filter])
        end


        def new
          @product = Product.new
          #@products = Product.find(:all)
          @cars = Car.includes(:carmodels).all
        end

        def create
          carmodel_ids = params[:product][:carmodel_ids].split(/,/)
          params[:product][:carmodel_ids] = carmodel_ids

          @product = Product.new(params[:product])
          if @product.save
            flash[:success] = "Item saved!"
            redirect_to refinery.products_admin_products_path
          else
            render 'new'
          end
        end

        def update

          string_ids = params[:product][:carmodel_ids].delete("[]")
          logger.debug("/////////////////////MY LOGG: #{string_ids}")
          
          carmodel_ids = string_ids.split(/,/)
          params[:product][:carmodel_ids] = carmodel_ids

          @product = Product.find(params[:id])
            if @product.update_attributes(params[:product])
              flash[:success] = "Item updated!"
              redirect_to refinery.products_admin_products_path
            else
              render 'edit'
            end
          #@product = Product.new(params[:product])#.except(:item_photo))
        end

        def search
          logger.debug('//////////////////////// ADMIN SEARCH PRODUCT')
          if params[:modelsearch]
            @results = Carmodel.where('title LIKE ?', "%#{params[:modelsearch]}%")
            @model_type = 'modeltype'
          end
          if params[:subtypesearch]
            @results = Carmodelsubtype.where('title LIKE ?', "%#{params[:subtypesearch]}%")
            @model_type = 'subtype'
          end

          respond_to do |format|
            format.js
          end
        end

        #######block of photos handlers
        def imgs
          @id = params[:id]
          @all_photos = ProductPhoto.where(product_id: params[:id])
          @photo = ProductPhoto.new
          
        end

        def add_photo
          @photo = ProductPhoto.new(params[:product_photo])
          @photo.product_id = params[:id]
          #@photo.main = false

          if @photo.save
            redirect_to refinery.products_admin_imgs_path(params[:id]), notice: 'Деталь сохранена!'
          else
            redirect_to refinery.products_admin_imgs_path(params[:id]), notice: 'Деталь не сохранена!'
          end
        end

        def delete_img
          @attach = ProductPhoto.find(params[:id])
          @attach.image = nil
          @attach.destroy
           respond_to do |format|
             format.js
           end
        end


        ##################subtype admin ajax
        def subtype_new
          subtype = Carmodelsubtype.new(:title => params[:title], :carmodeltype_id => params[:carmodeltype_id])
          if subtype.save
            txt_append = "<li class='subtype_li' subtype-id='#{subtype.id}'><input class='subtype_update' value='#{subtype.title}' size='25' />"
            txt_append += "<img alt='Tick' class='subtype_delete' height='16' src='/assets/refinery/icons/delete.png' width='16' onclick='removesubtype(#{subtype.id})' />"
            #txt_append += "refinery_icon_tag('delete.png', :class => 'subtype_delete')</li>"

            render :text => txt_append

          end
        end

        def subtype_update
          @subtype = Carmodelsubtype.find(params[:id])
          if @subtype.update_attributes(:title => params[:title])
            render :text => "New tittle is #{params[:title]}"
          end
        end

        def subtype_delete
          @subtype = Carmodelsubtype.find(params[:id])
          @subtype.destroy
            render :text => "Deleted #{params[:id]}"
        end

        ##################car models admin ajax
        def model_new
          model = Carmodel.new(:title => params[:title], :car_id => params[:car_id])
          if model.save
            txt_append = "<li class='model_li' model-id='#{model.id}'><input class='subtype_update' value='#{model.title}' size='25' />"
            txt_append += "<img alt='Tick' class='model_delete' height='16' src='/assets/refinery/icons/delete.png' width='16' onclick='removemodel(#{model.id})' />"
            #txt_append += "refinery_icon_tag('delete.png', :class => 'model_delete')</li>"

            render :text => txt_append

          end
        end

        def model_update
          @model = Carmodel.find(params[:id])
          if @model.update_attributes(:title => params[:title])
            render :text => "New tittle is #{params[:title]}"
          end
        end

        def model_delete
          @model = Carmodel.find(params[:id])
          @model.destroy
            render :text => "Deleted #{params[:id]}"
        end        

        # def main_img
        #   @attach = ProductPhoto.find(params[:id])
        #   @attachs = ProductPhoto.where(product_id: @attach.product_id)
        #   @attachs.each do |a|
        #     if a.main
        #       @old = a.id 
        #       a.main = false
        #       a.save
        #     end 
        #   end
        #   @attach.main = true
        #   @attach.save

        #  respond_to do |format|
        #    format.js
        #  end
        # end 

        ##################before filters
        def find_categories
          @categories=Carmodeltype.includes(:carmodelsubtypes).all
          @carcategories=Car.includes(:carmodels).all
        end

        ##########filter does nothig, I guess ))) forgot what for... 
        def filter
          if params[:modelsearch]
            @results = Carmodel.where('title LIKE ?', "%#{params[:modelsearch]}%")
            @model_type = 'modeltype'
          end
          if params[:subtypesearch]
            @results = Carmodelsubtype.where('title LIKE ?', "%#{params[:subtypesearch]}%")
            @model_type = 'subtype'
          end
          respond_to do |format|
            format.js
          end
        end

      end
    end
  end
end
