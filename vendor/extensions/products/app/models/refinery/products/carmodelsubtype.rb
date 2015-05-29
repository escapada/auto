module Refinery
  module Products
    class Carmodelsubtype < Refinery::Core::BaseModel
      self.table_name = 'carmodelsubtypes'

      attr_accessible :title, :carmodeltype_id
      has_many				:products, :class_name => '::Refinery::Products::Product', :dependent => :destroy

      belongs_to			:carmodeltype, :class_name => '::Refinery::Products::Carmodeltype'

      #validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class Carmodelsubtype < ActiveRecord::Base
#   attr_accessible :title
# end
