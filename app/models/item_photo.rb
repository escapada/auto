class ItemPhoto < ActiveRecord::Base

  attr_accessible :main, :image
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :item #, :class_name => Refinery::Items::Item
end