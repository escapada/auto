module Refinery
  module Items
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Items

      engine_name :refinery_items

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "items"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.items_admin_items_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/items/item',
            :title => 'model'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Items)
      end
    end
  end
end
