class AddDescriptionToItem < ActiveRecord::Migration
  def change
  	change_column :refinery_items, :description, :string
  end
end
