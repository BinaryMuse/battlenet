module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug)
        data = @api.make_api_call 'auction/data/' +slug
        data["files"]
      end
    end
  end
end