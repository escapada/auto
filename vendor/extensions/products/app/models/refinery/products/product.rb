module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible					:title, :carmodelsubtype_id, :condition, :status, :price, :position, :car_id, :carmodel_id

      has_many 								:photos, :class_name => 'Refinery::Products::ProductPhoto', :dependent => :destroy
      #has_and_belongs_to_many :cars, :class_name => '::Refinery::Products::Car'
      has_and_belongs_to_many :carmodels, :class_name => 'Refinery::Products::Carmodel'

      belongs_to 							:carmodelsubtype, :class_name => '::Refinery::Products::Carmodelsubtype'

      validates :title, :presence => true, :uniqueness => true

      # def self.search(search)
      #   if search
      #     where('title LIKE ?', "%#{search}%")
      #   else
      #     scoped
      #   end
      # end

    end
  end
end
