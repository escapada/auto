class AddAttachmentImageToItemPhotos < ActiveRecord::Migration
  def self.up
    change_table :item_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :item_photos, :image
  end
end
