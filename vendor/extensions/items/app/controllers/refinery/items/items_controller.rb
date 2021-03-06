module Refinery
  module Items
    class ItemsController < ::ApplicationController

      before_filter :find_all_items
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @item in the line below:
        present(@page)
      end

      def show
        @item = Item.includes(:photos).find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @item in the line below:
        present(@page)
      end

    protected

      def find_all_items
        #@items = Item.order('position ASC').includes(:photos).where('item_photos.main = "true"')
        @items = Item.includes(:photos).order('position DESC').where('item_photos.main = ?', true)
        #User.includes(:addresses).where("addresses.country = ?", "Poland")
        
        #@photos = ItemPhoto.includes(:item).where('main = ?', true)
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/items").first
      end

    end
  end
end