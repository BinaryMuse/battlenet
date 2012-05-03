class Battlenet
  module Modules
    module Achievement
      def achievement(id, options = {})
        get "/achievement/#{id}", options
      end
    end
  end
end
