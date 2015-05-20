module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible :title, :carmodelsubtype_id, :condition, :status, :price, :position

      validates :title, :presence => true, :uniqueness => true
    end
  end
end
