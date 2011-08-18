module Battlenet
  module API
    module Auction
      extend self

      @api = Battlenet::API

      def data(slug, lastModified)
        puts "Requesting auction modified file for #{slug}:"
        data = @api.make_api_call 'auction/data/' +slug
        if data["files"][0]["lastModified"] > lastModified
          JSON::parse(@api.get_file(data["files"][0]["url"])[1])
        else 
          data["files"][0]
        end
      end

      def Horde(auctions)
        auctions['horde']["auctions"]
      end

      def Neutral(auctions)
        auctions['neutral']["auctions"]
      end

      def Alliance(auctions)
        auctions['alliance']["auctions"]
      end

    end
  end
end