module Refinery
  module Items
    class Item < Refinery::Core::BaseModel
      self.table_name = 'refinery_items'
      
      attr_accessible :model, :title, :meta, :description, :position#, :photos_attributes
      #has_many :item_photos
      has_many :photos, :foreign_key => :item_id, :class_name => '::Refinery::Items::ItemPhoto'
      
      #accepts_nested_attributes_for :photos, :allow_destroy => true #, allow_destroy: true

      validates :model, :presence => true#, :uniqueness => true


    end
  end
end
