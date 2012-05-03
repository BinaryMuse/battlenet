require 'spec_helper'

describe Battlenet::Modules::Pvp do
  let(:api) { Battlenet.new }

  it "fetches arena ladder data" do
    VCR.use_cassette('arena_ladder') do
      ladder = api.arena_ladder 'ruin', '2v2'
      ladder['arenateam'][0]['name'].should == 'trolling brigade'
      ladder['arenateam'][0]['members'][0]['character']['name'].should == 'Meepins'
    end
  end

  it "fetches rated BG ladder data" do
    VCR.use_cassette('rated_bg_ladder') do
      ladder = api.rated_bg_ladder
      ladder['bgRecord'][0]['rank'].should == 1
      ladder['bgRecord'][0]['realm']['name'].should == "Kel'Thuzad"
    end
  end
end
