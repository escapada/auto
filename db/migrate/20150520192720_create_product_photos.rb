class CreateProductPhotos < ActiveRecord::Migration
  def change
    create_table :product_photos do |t|
      t.integer :product_id
      t.attachment :image

      t.timestamps
    end
  end
end
