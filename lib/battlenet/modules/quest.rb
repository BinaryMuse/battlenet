class Battlenet
  module Quest
    def quest(id, options = {})
      get "/quest/#{id}", options
    end
  end
end
