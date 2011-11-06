class Battlenet
  module Auction
    def auction(realm, options)
      get "/auction/data/#{realm}", options
    end
  end
end
