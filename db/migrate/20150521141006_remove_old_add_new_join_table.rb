class RemoveOldAddNewJoinTable < ActiveRecord::Migration
  def change
  	drop_table :carmodeltypes

  	create_table :cars_products, id: false do |t|
      t.integer :car_id
      t.integer :product_id
    end
  end

  def down
  end
end