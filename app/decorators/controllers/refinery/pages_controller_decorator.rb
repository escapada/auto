Refinery::PagesController.class_eval do
	def home
		@items = Refinery::Items::Item.all
    @items.select! {|e| e.photos.present?}  #rewrite
    @items.shuffle!

    @vw = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'VW').order('carmodels.title asc')
    @vw.delete_if { |e| !(e.products.any?) }
    @audi = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'AUDI').order('carmodels.title asc')
    @audi.delete_if { |e| !(e.products.any?) }
    @skoda = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'SKODA').order('carmodels.title asc')
    @skoda.delete_if { |e| !(e.products.any?) }
    @seat = Refinery::Products::Carmodel.includes(:car, :products).where('cars.title' => 'SEAT').order('carmodels.title asc')
    @seat.delete_if { |e| !(e.products.any?) }
	end

end