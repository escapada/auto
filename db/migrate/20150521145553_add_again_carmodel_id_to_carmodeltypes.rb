class AddAgainCarmodelIdToCarmodeltypes < ActiveRecord::Migration
  def change
  	add_column :carmodeltypes, :carmodel_id, :integer
  end
end
