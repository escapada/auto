module Refinery
  module Products
    class Carmodel < Refinery::Core::BaseModel
      self.table_name = 'carmodels'

      attr_accessible					:title, :car_id
      has_and_belongs_to_many	:products, :class_name => '::Refinery::Products::Product'
      #has_many								:carmodeltypes, :class_name => '::Refinery::Products::Carmodeltype', :dependent => :destroy

      belongs_to 							:car, :class_name => '::Refinery::Products::Car'

      validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class Carmodel < ActiveRecord::Base
#   attr_accessible :title
# end
