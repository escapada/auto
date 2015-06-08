Refinery::News::Item.class_eval do

	attr_accessible :image_id
  belongs_to :preview_img, :class_name => '::Refinery::Image', :foreign_key => :image_id

  end