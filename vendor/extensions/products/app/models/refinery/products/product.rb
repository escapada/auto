module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible					:title, :carmodelsubtype_id, :condition, :status, :price, :position, :car_id, :carmodel_ids

      has_many 								:photos, :class_name => '::Refinery::Products::ProductPhoto', :dependent => :destroy
      #has_and_belongs_to_many :cars, :class_name => '::Refinery::Products::Car'
      has_and_belongs_to_many :carmodels, :class_name => '::Refinery::Products::Carmodel'

      belongs_to 							:carmodelsubtype, :class_name => '::Refinery::Products::Carmodelsubtype'

      validates :title, :presence => true, :uniqueness => true
      validates :carmodel_ids, :presence => true
      validates :carmodelsubtype_id, :presence => true

      # def self.search(search)
      #   case search
      #   when search[:carmodel_id]
      #     tmp = self.includes(:carmodels).all
      #     tmp.each do |variable|
            
      #     end
      #   else
      #     scoped
      #   end
      # end
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
