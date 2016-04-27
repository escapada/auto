class AddCountToProducts < ActiveRecord::Migration
  def change
  	add_column :refinery_products, :count, :integer, :default => 1
  end
end
