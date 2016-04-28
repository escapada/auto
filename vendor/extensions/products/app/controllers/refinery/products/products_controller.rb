module Refinery
  module Products
    class ProductsController < ::ApplicationController

      before_filter :find_all_products
      before_filter :find_page

      def index
        if @skip
          tmp_ids=[]
          tmpsub_ids=[]
          @products.each do |product|
            tmp_ids << product.carmodelsubtype.carmodeltype_id if !(tmp_ids.include?(product.carmodelsubtype.carmodeltype_id))
            tmpsub_ids << product.carmodelsubtype_id if !(tmpsub_ids.include?(product.carmodelsubtype_id))
            # product.carmodels.each do |m|
            #   tmpsub_ids << product.carmodelsubtype_id if !(tmpsub_ids.include?(product.carmodelsubtype_id))
            # end
          end
          logger.debug("//////////////////////// ARRAY OF IDs #{tmp_ids} ///////////////////AND SUBIDs  #{tmpsub_ids} ")

          @types=Carmodeltype.includes(:carmodelsubtypes).where(id:tmp_ids).where('carmodelsubtypes.id' => tmpsub_ids)#('carmodels.id' => params[:search])

          @car_name=@products.first.carmodels.first.car.title
          @model_name=@products.first.carmodels.first.title

        else
          @items = Refinery::Items::Item.all
          @items.select! {|e| e.photos.present?}  #rewrite
          @items.shuffle!

          @vw = Carmodel.includes(:car, :products).where('cars.title' => 'VW').order('carmodels.title asc')
          @vw.delete_if { |e| !(e.products.any?) }
          @audi = Carmodel.includes(:car, :products).where('cars.title' => 'AUDI').order('carmodels.title asc')
          @audi.delete_if { |e| !(e.products.any?) }
          @skoda = Carmodel.includes(:car, :products).where('cars.title' => 'SKODA').order('carmodels.title asc')
          @skoda.delete_if { |e| !(e.products.any?) }
          @seat = Carmodel.includes(:car, :products).where('cars.title' => 'SEAT').order('carmodels.title asc')
          @seat.delete_if { |e| !(e.products.any?) }
        end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end

      def show
        @product = Product.find(params[:id])

        @car_name=@product.carmodels.first.car.title
        @cars = []
        @product.carmodels.each do |carmodel|
          @cars << carmodel.car.title if !(@cars.include?(carmodel.car.title))
        end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        
        respond_to do |format|
          format.js
          format.html
        end

        #present(@page)
      end

      def search
        logger.debug('//////////////////////// SEARCH PRODUCT')
        
        @products=Product.includes(:carmodels, :carmodelsubtype).where('carmodels.id' => params[:model]).where(carmodelsubtype_id:params[:subtype])
        @car_name=@products.first.carmodels.first.car.title
        @model_name=@products.first.carmodels.first.title

        ############### need to build breadcrumbs (madness!!!)
        session[:model_id] = params[:model]
        session[:subtype_id] =  params[:subtype]
        session[:car_name] =  @car_name
        session[:model_name] =  @model_name
        session[:type_name] =  @products.first.carmodelsubtype.carmodeltype.title
        session[:subtype_name] =  @products.first.carmodelsubtype.title
        ###############


        respond_to do |format|
          format.js
          #format.html
        end
      end

    protected

      def find_all_products
        if (params[:search])
          @skip = true
          @model_id = params[:search]
          ##need for breadcrumbs (madness)
          session[:model_id] = @model_id
          ##
          @carmodels = Carmodel.includes(:products).where(id:@model_id)
          if (@carmodels.any? { |e| e.products.any? })
            @products=Product.includes(:carmodels, :carmodelsubtype).where('carmodels.id' => @model_id)
          else
            redirect_to refinery.products_products_path
          end

          logger.debug("//////////////////////// SEARCH PRODUCT #{@skip}")
        else
          @skip = false
          @products = Product.order('position ASC')

          logger.debug("//////////////////////// SEARCH PRODUCT #{@skip}")
        end
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/products").first
      end

    end
  end
end
