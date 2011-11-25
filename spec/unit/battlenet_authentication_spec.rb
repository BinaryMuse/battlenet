require 'spec_helper'

describe Battlenet::Authentication do
  let(:auth) { Battlenet::Authentication.new 'private' }

  before(:each) do
    time = Time.local 2011, 11, 4, 20, 36, 24
    Timecop.freeze(time)
  end

  after(:each) do
    Timecop.return
  end

  context "#sign" do
    it "signs the request" do
      signed = auth.sign :get, '/api/wow/test', Time.now
      signed.should == "7PaeI8+WiIMxdodL+aZz+6bA2sc=\n"
    end
  end

  context "#string_to_sign" do
    it "contains the verb, time, and path" do
      string = auth.string_to_sign :get, '/test', Time.now
      string.should =~ /GET/
      string.should =~ /Sat, 05 Nov 2011 03:36:24 GMT/
      string.should =~ /\/test/
    end
  end
end
