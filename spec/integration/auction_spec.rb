require 'spec_helper'

describe Battlenet::Modules::Auction do
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
