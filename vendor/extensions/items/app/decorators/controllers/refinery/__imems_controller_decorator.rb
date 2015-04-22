Refinery::Items::ItemsController.class_eval do
	def create
		@item = Item.create( params[:item] )
	end
end