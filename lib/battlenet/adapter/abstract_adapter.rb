module Battlenet
  module Adapter
    class NotImplementedException < Exception; end

    class AbstractAdapter
      def get(url)
        raise NotImplementedException.new("Please implement #get in your adapter")
      end
    end
  end
end
