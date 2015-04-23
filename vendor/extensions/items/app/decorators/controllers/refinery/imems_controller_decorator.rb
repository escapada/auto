# Refinery::Items::ItemsController.class_eval do
# 	def create
# 		@item = Item.create(item_params)
# 	end
	
# 	def item_params
# 		params.require(:item).permit(:model, :title, :meta, :description, :position, item_photos_attributes:[:image,:id,:_destroy])
# 	end
# end