require 'uri'

class Battlenet
  module Modules
    module Pvp
      def arena_ladder(battlegroup, size, options = {})
        battlegroup = URI.escape battlegroup
        size = URI.escape size

        get "/pvp/arena/#{battlegroup}/#{size}", options
      end

      def rated_bg_ladder(options = {})
        get "/pvp/ratedbg/ladder", options
      end
    end
  end
end
