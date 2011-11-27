class Battlenet
  module Modules
    module Item
      def item(id, options = {})
        get "/item/#{id}", options
      end
    end
  end
end
