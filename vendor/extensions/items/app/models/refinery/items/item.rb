module Refinery
  module Items
    class Item < Refinery::Core::BaseModel
      self.table_name = 'refinery_items'
      
      #has_many :item_photos
      has_many :item_photos, :class_name => '::Refinery::Items::ItemPhoto'
      accepts_nested_attributes_for :item_photos, :allow_destroy => true #, allow_destroy: true

      attr_accessible :model, :title, :meta, :description, :position, :item_photos_attributes

      validates :model, :presence => true#, :uniqueness => true


    end
  end
end
