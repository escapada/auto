class CreateCarmodeltypesRemoveCarmodeltypesProducts < ActiveRecord::Migration
  def change
    create_table :carmodeltypes do |t|
      t.string :title

      t.timestamps
    end
    drop_table :carmodeltypes_products
  end
end
