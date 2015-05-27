class CreateItemsItems < ActiveRecord::Migration

  def up
    create_table :refinery_items do |t|
      t.string :model
      t.string :title
      t.string :meta
      t.text :description
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-items"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/items/items"})
    end

    drop_table :refinery_items

  end

end
