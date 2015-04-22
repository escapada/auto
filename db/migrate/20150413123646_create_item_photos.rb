class CreateItemPhotos < ActiveRecord::Migration
  def change
    create_table :item_photos do |t|
      t.boolean :main

      t.timestamps
    end
  end
end
