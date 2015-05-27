class CreateCarmodeltypesProducts < ActiveRecord::Migration
  def change
  	create_table :carmodeltypes_products, id: false do |t|
      t.integer :carmodeltype_id
      t.integer :product_id
    end
  end
end
