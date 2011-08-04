module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug, lastModified)
        data = @api.make_api_call 'auction/data/' +slug
        if data["files"]["lastModified"] > lastModified
          data = @api.make_api_call data["files"]["url"]
      end
    end
  end
end