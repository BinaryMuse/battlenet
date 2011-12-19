require 'spec_helper'
require 'battlenet'

describe Battlenet::Recipe do
  let(:api) { Battlenet.new }

  it "fetches recipe data" do
    VCR.use_cassette('recipe') do
      recipe = api.recipe '33994'
      recipe['name'].should == "Enchant Gloves - Precise Strikes"
      recipe['profession'].should == "Enchanting"
    end
  end
end
