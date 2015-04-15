class ItemPhoto < ActiveRecord::Base
  attr_accessible :image_height, :image_name, :image_uid, :image_width, :item_id#, :image
  item_photo_accessor :image

  belongs_to :item, :class_name => Refinery::Items::Item
end