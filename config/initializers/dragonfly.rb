require 'dragonfly'

myuploader = Dragonfly[:item_photos]
myuploader.configure_with(:imagemagick)
myuploader.configure_with(:rails)

myuploader.define_macro(ActiveRecord::Base, :item_photo_accessor)
