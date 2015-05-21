class AddCarIdToCarmodels < ActiveRecord::Migration
  def change
  	add_column :carmodels, :car_id, :integer
  end
end
