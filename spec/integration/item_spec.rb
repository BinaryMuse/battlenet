require 'spec_helper'

describe Battlenet::Item do
  let(:api) { Battlenet.new }

  it "fetches item data" do
    VCR.use_cassette('item_hooooooooooo') do
      item = api.item '12784'
      item['name'].should == "Arcanite Reaper"
    end
  end
end
