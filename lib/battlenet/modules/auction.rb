require 'uri'

class Battlenet
  module Auction
    def auction(realm, options = {})
      realm = URI.escape realm

      get "/auction/data/#{realm}", options
    end

    def auction_data(realm, options = {})
      data = auction(realm, options)
      files = data["files"].first
      url = files["url"]
      get url
    end
  end
end
