module Refinery
  module Products
    class Carmodeltype < Refinery::Core::BaseModel
      self.table_name = 'carmodeltypes'

      attr_accessible					:title
      has_many 								:carmodelsubtypes, :class_name => '::Refinery::Products::Carmodelsubtype', :dependent => :destroy

      #validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class Carmodeltype < ActiveRecord::Base
#   attr_accessible :title
# end
