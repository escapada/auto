Refinery::Items::ItemsController.class_eval do
	#before_filter :get_photos
	#after_filter :get_photos

	def cry
		#@photo = Refinery::Items::ItemPhoto.new		
	end

	#after_save :save_attach
	#after_update :

	protected

	def get_photos
		@item.item_photos.build	
	end

	def save_attach
				
	end

	# def create
	# 	@item = Item.create(item_params)
	# end
	
	# def item_params
	# 	params.require(:item).permit(:model, :title, :meta, :description, :position, item_photos_attributes:[:image,:id,:_destroy])
	# end
end