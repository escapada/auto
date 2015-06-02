
module Refinery
  module Products
    class ProductPhoto < Refinery::Core::BaseModel
      self.table_name = 'product_photos'

      attr_accessible			:title, :image, :product_id
  		has_attached_file		:image, :styles => { :thumb => "175x132/#", :big => "900x600/#" }, :default_url => "/images/:style/missing.png"#, :processors => [:watermark]
  		belongs_to					:product, :foreign_key => :product_id, :class_name => '::Refinery::Products::Product', :dependent => :destroy

  		validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
      #validates :title, :presence => true, :uniqueness => true
    end
  end
end


###default by generator
# class ProductPhoto < ActiveRecord::Base
#   attr_accessible :title
# end