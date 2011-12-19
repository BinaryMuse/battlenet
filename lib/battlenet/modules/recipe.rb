class Battlenet
  module Modules
    module Recipe
      def recipe(id, options = {})
        get "/recipe/#{id}", options
      end
    end
  end
end
