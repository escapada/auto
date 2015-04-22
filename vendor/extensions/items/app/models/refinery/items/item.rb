module Refinery
  module Items
    class Item < Refinery::Core::BaseModel
      self.table_name = 'refinery_items'

      attr_accessible :model, :title, :meta, :description, :position, :item_photos_attributes

      validates :model, :presence => true#, :uniqueness => true

      has_many :item_photos

      accepts_nested_attributes_for :item_photos, allow_destroy: true
    end
  end
end
