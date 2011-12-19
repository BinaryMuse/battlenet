class Battlenet
  module Recipe
    def recipe(id, options = {})
      get "/recipe/#{id}", options
    end
  end
end
