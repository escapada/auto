class RemoveCarmodelIdFromCarmodeltypes < ActiveRecord::Migration
  def up
  	remove_column :carmodeltypes, :carmodel_id, :integer
  end

  def down
  	add_column :carmodeltypes, :carmodel_id, :integer
  end
end
