class CreateCarmodelsProducts < ActiveRecord::Migration
  def change
  	create_table :carmodels_products, id: false do |t|
      t.integer :carmodel_id
      t.integer :product_id
    end
  end
end
