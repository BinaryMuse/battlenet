require 'spec_helper'

describe Battlenet::Modules::Item do
  let(:api) { Battlenet.new }

  it "fetches item data" do
    VCR.use_cassette('item_hooooooooooo') do
      item = api.item '12784'
      item['name'].should == "Arcanite Reaper"
    end
  end

  it "fetches item set data" do
    VCR.use_cassette('item_set_1060') do
      set = api.item_set '1060'
      set['name'].should == "Deep Earth Vestments"
      set['setBonuses'][0]['threshold'].should == 2
    end
  end
end
