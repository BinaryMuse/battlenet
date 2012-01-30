require 'spec_helper'

describe Battlenet::ApiException do
  let(:api) { Battlenet.new }

  it "raises an exception with the reason and code set" do
    VCR.use_cassette('not_found') do
      begin
        item = api.item '1234567890'
      rescue Battlenet::ApiException => e
        e.code.should == 404
        e.reason.should == 'unable to get item information.'
      end
    end
  end
end
