module Battlenet
  module API
    module Item
      extend self

      @api = Battlenet::API

      def with_id(itemId)
        @api.make_api_call "item/#{itemId}"
      end
    end
  end
end
