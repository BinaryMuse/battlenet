require 'spec_helper'
require 'battlenet'

describe Battlenet::Quest do
  let(:api) { Battlenet.new }

  it "fetches quest data" do
    VCR.use_cassette('quest') do
      quest = api.quest '28096'
      quest['title'].should == "Welcome to the Machine"
    end
  end
end
