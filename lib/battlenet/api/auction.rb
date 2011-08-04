module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug, lastModified, options = {})
        data = @api.make_api_call 'auction/data/' +slug, options
        if data["files"][0]["lastModified"] > lastModified
          file = @api.get_file data["files"][0]["url"]
        else 
          logger.info "Realm " +slug+ " is up to date."
          data
        end
      end
    end
  end
end