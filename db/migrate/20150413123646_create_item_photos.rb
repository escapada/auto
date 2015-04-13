class CreateItemPhotos < ActiveRecord::Migration
  def change
    create_table :item_photos do |t|
      t.string :image_uid
      t.string :image_name
      t.integer :image_width
      t.integer :image_height

      t.timestamps
    end
  end
end
