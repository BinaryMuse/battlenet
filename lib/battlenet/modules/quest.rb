class Battlenet
  module Modules
    module Quest
      def quest(id, options = {})
        get "/quest/#{id}", options
      end
    end
  end
end
