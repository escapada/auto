class CreateCarmodeltypes < ActiveRecord::Migration
  def change
    create_table :carmodeltypes do |t|
      t.string :title

      t.timestamps
    end
  end
end
