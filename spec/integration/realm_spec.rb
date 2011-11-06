# encoding: utf-8

require 'spec_helper'
require 'battlenet'

describe Battlenet::Realm do
  let(:api) { Battlenet.new }

  it "fetches realm data" do
    VCR.use_cassette('realm') do
      realm = api.realm
      realm['realms'].find { |r| r['name'] == 'Nazjatar' }['population'].should == 'low'
    end
  end
end
