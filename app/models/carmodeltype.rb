module Refinery
  module Products
    class Carmodeltype < Refinery::Core::BaseModel
      self.table_name = 'carmodeltypes'

      attr_accessible					:title, :carmodel_id
      has_many 								:carmodelsubtypes, :class_name => '::Refinery::Products::Carmodelsubtype', :dependent => :destroy

      belongs_to 							:carmodel

      #validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class Carmodeltype < ActiveRecord::Base
#   attr_accessible :title
# end
