class ItemPhoto < ActiveRecord::Base
  attr_accessible :image_height, :image_name, :image_uid, :image_width
  item_photo_accessor :image
end
