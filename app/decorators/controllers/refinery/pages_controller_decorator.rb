Refinery::PagesController.class_eval do
	def home
		@items = Refinery::Items::Item.all
    @items.shuffle!

    @vw = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'VW')
    @vw.delete_if { |e| !(e.products.any?) }
    @audi = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'AUDI')
    @audi.delete_if { |e| !(e.products.any?) }
    @skoda = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'SKODA')
    @skoda.delete_if { |e| !(e.products.any?) }
    @seat = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'SEAT')
    @seat.delete_if { |e| !(e.products.any?) }
	end

end