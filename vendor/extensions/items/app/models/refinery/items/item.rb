module Refinery
  module Items
    class Item < Refinery::Core::BaseModel
      self.table_name = 'refinery_items'

      attr_accessible :model, :title, :meta, :description, :position

      validates :model, :presence => true#, :uniqueness => true

      has_many :item_photos
    end
  end
end
