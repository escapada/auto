module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        crudify :'refinery/products/product',
                :xhr_paging => true


        def new
        	@product = Product.new
        	#@products = Product.find(:all)
        	@cars = Car.includes(:carmodels).find(:all)
        end

        def create
          @product = Product.new(params[:product])#.except(:item_photo))
          
          if @product.save
            flash[:success] = "Item saved!"
            redirect_to refinery.products_admin_products_path
          else
            render 'new'
          end
        end

        def update
          params[:product][:carmodel_ids] ||= []
          @product = Product.new(params[:product])#.except(:item_photo))
          
          if @product.save
            flash[:success] = "Item saved!"
            redirect_to refinery.products_admin_products_path
          else
            render 'new'
          end
        end

        def search
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
