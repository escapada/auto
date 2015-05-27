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

        def search
          if params[:modelsearch]
            @results = Carmodel.where('title LIKE ?', "%#{params[:modelsearch]}%")
          end
          if params[:subtypesearch]
            @results = Carmodelsubtype.where('title LIKE ?', "%#{params[:subtypesearch]}%")
          end
          respond_to do |format|
            format.js
          end
        end

      end
    end
  end
end
