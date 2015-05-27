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
          @product = Product.search(params[:search])
        end

      end
    end
  end
end
