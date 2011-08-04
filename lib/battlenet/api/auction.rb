module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug, lastModified, options = {})
        data = @api.make_api_call 'auction/data/' +slug, options
        if data["files"][0]["lastModified"] > lastModified
          puts "getting: " +data["files"][0]["url"]
          file = @api.get_file data["files"][0]["url"]
        else 
          puts "Your auction data is up to date"
        end
      end
    end
  end
end