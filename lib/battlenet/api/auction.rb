module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug, lastModified)
        puts "Requesting auction modified file for #{slug}:"
        data = @api.make_api_call 'auction/data/' +slug
        puts data
        if data["files"][0]["lastModified"] > lastModified
          auctionsFile = @api.get_file(data["files"][0]["url"])
        else 
          data["files"][0]
        end
      end
    end
  end
end