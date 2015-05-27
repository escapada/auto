class CreateCarmodelsubtypes < ActiveRecord::Migration
  def change
    create_table :carmodelsubtypes do |t|
      t.string :title
      t.integer :carmodeltype_id

      t.timestamps
    end
  end
end
