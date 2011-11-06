# "{\r\n\"realm\":{\"name\":\"Nazjatar\",\"slug\":\"nazjatar\"},\r\n\"alliance\":{\"auctions\":[\r\n\t{\"auc\":1329311139,\"item\":42989,\"owner\":\"Price\",\"bid\":15000000,

require 'spec_helper'
require 'battlenet'

describe Battlenet::Auction do
  let(:api) { Battlenet.new }

  it "fetches auction data" do
    VCR.use_cassette('auction_files') do
      auction = api.auction 'nazjatar'
      auction['files'].first['url'].should == "http://us.battle.net/auction-data/nazjatar/auctions.json"
    end
  end

  it "fetches auction data" do
    VCR.use_cassette('auction_data') do
      data = api.auction_data 'nazjatar'
      data["alliance"]["auctions"].first["item"].should == 42989
    end
  end
end
