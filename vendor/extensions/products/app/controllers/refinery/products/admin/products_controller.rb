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
          @products = Product.search(params[:search])
          @param = params[:search]
          render :text => @param
          # respond_to do |format|
          #   format.js
          # end
        end

      end
    end
  end
end
