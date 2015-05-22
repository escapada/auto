module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible					:title, :carmodelsubtype_id, :condition, :status, :price, :position, :car_id, :carmodel_id

      has_many 								:photos, :class_name => 'Refinery::Products::ProductPhoto', :dependent => :destroy
      has_and_belongs_to_many :cars, :class_name => '::Refinery::Products::Car'
      has_and_belongs_to_many :carmodels, :class_name => '::Refinery::Products::Carmodels'

      belongs_to 							:carmodelsubtype, :class_name => '::Refinery::Products::Carmodelsubtype'

      validates :title, :presence => true, :uniqueness => true
    end
  end
end
