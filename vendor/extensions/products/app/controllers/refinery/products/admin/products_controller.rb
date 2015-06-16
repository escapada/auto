module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        before_filter :find_categories, :only => [:new, :edit]
        #before_filter :set_filter#, :only => [:new, :edit]

        crudify :'refinery/products/product',
                :order => "position DESC",
                :sortable => false,
                :xhr_paging => true
                #:include => [:carmodelsubtype, :carmodels]#,
                #:conditions => {:carmodels => {:id => proc{@model}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
                #:search_conditions => {:carmodels => {:id => proc{@model}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
                #:conditions => {:carmodels => {:id => lambda {return set_filter}.call}}#{:carmodels => {:id => 2}}#, :carmodelsubtype_id => params[:filter_type]}#,
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
          @product = Product.new( :carmodel_ids => [session[:model]], :carmodelsubtype_id => session[:type])
          #@products = Product.find(:all)
          @cars = Car.includes(:carmodels).all
        end

        def create
          carmodel_ids = params[:product][:carmodel_ids].split(/,/)
          params[:product][:carmodel_ids] = carmodel_ids

          @product = Product.new(params[:product])
          if @product.save
            flash[:success] = "Item saved! Params: #{session[:model]}"
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
              flash[:success] = "Item updated! Params: #{session[:model]}"
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
          if @subtype.destroy
            render :text => "Deleted #{params[:id]}"
          end
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
          if @model.destroy
            render :text => "Deleted #{params[:id]}"
          end
        end        

        ################
        def reset_session
          session[:model] = nil
          session[:type] = nil 
          #render :text => "session[:model], session[:type] now is nil"
          redirect_to refinery.products_admin_products_path
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

        private
        ##################before filters
        # def set_filter
        #   @mmm=request.query_parameters()
        #   logger.debug("////////////////////////////////////////////////////////////////////////////////////////#{@mmm}")
        #   @model = 5
        #   #params[:model]  
        # end

        def find_categories
          @categories=Carmodeltype.includes(:carmodelsubtypes).all
          @carcategories=Car.includes(:carmodels).all
        end

        #########################here I'm going to override the default find_all_#{pluralname} method (that generated by crudify)
        #########################plus add filter variables

        def find_all_products
        #logger.debug("///////////////////////////FIND_ALL_PRODUCTS and FILTERED/////////////////////////////////////////////////////////////#{@mmm}")
          #@filter_model = session[:model] if session[:model].present?
          #@filter_type = session[:type] if session[:type].present?
          #session[:model] = nil
          #session[:type] = nil
          @carcategories=Car.includes(:carmodels) 
          if session[:model].present?||params[:model].present?
            params[:model].present? ? model=params[:model] : model=session[:model]
            if session[:type].present?||params[:type].present?
              params[:type].present? ? type=params[:type] : type=session[:type]
              logger.debug('---------------------------------------------sesion-model-type is true or params-model-type is true')
              @products = Product.includes(:carmodels, :carmodelsubtype).where('carmodels.id' => model).where(carmodelsubtype_id:type).order('position DESC') 
              ########
              ##for tmp_ids and tmpsub_ids array.
              @products_make_list_helper = Product.includes(:carmodels, :carmodelsubtype).where('carmodels.id' => model).order('position DESC') 
              ########
              session[:model] = model
              session[:type] = type
              @filter_model = Carmodel.where(id:model).first
              @filter_type = Carmodelsubtype.where(id:type).first

              tmp_ids=[]
              tmpsub_ids=[]
              @products_make_list_helper.each do |product|
                tmp_ids << product.carmodelsubtype.carmodeltype_id if !(tmp_ids.include?(product.carmodelsubtype.carmodeltype_id))
                tmpsub_ids << product.carmodelsubtype_id if !(tmpsub_ids.include?(product.carmodelsubtype_id))
              end

              @typecategories = Carmodeltype.includes(:carmodelsubtypes).where(id:tmp_ids).where('carmodelsubtypes.id' => tmpsub_ids)
            else
              logger.debug("#{model}---------------------------------------------sesion-model is true or params-model is true")
              @products = Product.includes(:carmodels, :carmodelsubtype).where('carmodels.id' => model).order('position DESC') 
              session[:model] = model
              session[:type] = nil
              @filter_model = Carmodel.where(id:model).first
              @filter_type = nil

              tmp_ids=[]
              tmpsub_ids=[]
              @products.each do |product|
                tmp_ids << product.carmodelsubtype.carmodeltype_id if !(tmp_ids.include?(product.carmodelsubtype.carmodeltype_id))
                tmpsub_ids << product.carmodelsubtype_id if !(tmpsub_ids.include?(product.carmodelsubtype_id))
              end

              @typecategories = Carmodeltype.includes(:carmodelsubtypes).where(id:tmp_ids).where('carmodelsubtypes.id' => tmpsub_ids)
            end
          else
            logger.debug('---------------------------------------------sesion-model-type is false or params-model-type is false')
            @products = Product.includes(:carmodels, :carmodelsubtype).order('position DESC')
            session[:model] = nil
            session[:type] = nil
            @filter_model = nil#session[:model]
            @filter_type = nil#session[:type]

            @typecategories = nil
          end

        end #end of find_all_products method


      end
    end
  end
end
