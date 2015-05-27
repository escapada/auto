class AddItemIdToItemPhoto < ActiveRecord::Migration
  def change
    add_column :item_photos, :item_id, :integer
  end
end
