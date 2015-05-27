module Refinery
  module Products
    class Car < Refinery::Core::BaseModel
      self.table_name = 'cars'

      attr_accessible					:title
      #has_and_belongs_to_many	:products, :class_name => '::Refinery::Products::Product'
      has_many								:carmodels, :class_name => '::Refinery::Products::Carmodel', :dependent => :destroy

      #validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class Carmodel < ActiveRecord::Base
#   attr_accessible :title
# end

# class Car < ActiveRecord::Base
#   attr_accessible :title
# end
