class Battlenet
  module Item
    def item(id, options)
      get "/item/#{id}", options
    end
  end
end
