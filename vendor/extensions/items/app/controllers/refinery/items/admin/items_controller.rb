module Refinery
  module Items
    module Admin
      class ItemsController < ::Refinery::AdminController

      	#before_filter :find_all_photos#, :only => [:show]

      protected

        def find_all_photos
          @item_photos = Refinery::Items::ItemPhoto.all
        end

        crudify :'refinery/items/item',
                :title_attribute => 'model',
                :xhr_paging => true

      end
    end
  end
end
