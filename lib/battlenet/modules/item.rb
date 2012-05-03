class Battlenet
  module Modules
    module Item
      def item(id, options = {})
        get "/item/#{id}", options
      end

      def item_set(id, options = {})
        get "/item/set/#{id}", options
      end
    end
  end
end
