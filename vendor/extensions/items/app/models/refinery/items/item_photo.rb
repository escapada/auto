module Refinery
  module Items
    class ItemPhoto < Refinery::Core::BaseModel
    	self.table_name = 'item_photos'

      attr_accessible :main, :image, :item_id
  
  		has_attached_file :image, :styles => { :medium => "293x170/#", :thumb => "100x100/#>", :big => "620x373/#" }#, :processors => [:watermark]#, :default_url => "/images/:style/missing.png"
  		validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  		belongs_to :item, :foreign_key => :item_id, :class_name => 'Refinery::Items::Item'
    end
  end
end
