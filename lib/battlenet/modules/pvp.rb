require 'uri'

class Battlenet
  module Modules
    module Pvp
      def arena_ladder(battlegroup, size, options = {})
        battlegroup = URI.escape battlegroup
        size = URI.escape size

        get "/pvp/arena/#{battlegroup}/#{size}", options
      end
    end
  end
end
