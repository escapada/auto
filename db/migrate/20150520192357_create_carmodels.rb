class CreateCarmodels < ActiveRecord::Migration
  def change
    create_table :carmodels do |t|
      t.string :title

      t.timestamps
    end
  end
end
