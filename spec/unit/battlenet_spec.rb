require 'spec_helper'
require 'battlenet'
require 'battlenet/authentication'

describe Battlenet do
  before(:each) do
    response = mock(:response).as_null_object
    response.stub(:code).and_return(200)
    Battlenet.stub(:get).and_return(response)
  end

  context "#initialize" do
    it "sets the domain based on the region" do
      api = Battlenet.new :us
      api.instance_variable_get(:@base_uri).should =~ /us.battle.net/

      api = Battlenet.new :eu
      api.instance_variable_get(:@base_uri).should =~ /eu.battle.net/

      api = Battlenet.new :cn
      api.instance_variable_get(:@base_uri).should =~ /battlenet.com.cn/
    end

    it "raises an error when an invalid region is given" do
      lambda {
        api = Battlenet.new :fake
      }.should raise_error
    end

    it "sets the protocol based on public/private key status" do
      api = Battlenet.new :us
      api.instance_variable_get(:@base_uri).should =~ /http:\/\//

      api = Battlenet.new :us, 'public', 'private'
      api.instance_variable_get(:@base_uri).should =~ /https:\/\//
    end
  end

  context "#fullpath" do
    it "returns the full path for the resource" do
      api = Battlenet.new
      api.instance_variable_set(:@endpoint, "/test/testing")
      api.fullpath("/thetest").should == "/test/testing/thetest"
    end
  end

  context "#get" do
    let(:api) { Battlenet.new :us }

    it "delegates to #make_request" do
      api.should_receive(:make_request).with(:get, '/test', {})
      api.get '/test'
    end
  end

  context "#make_request" do
    let(:api) { Battlenet.new :us }

    it "delegates to HTTParty" do
      Battlenet.should_receive(:get).with('/test', {})
      api.make_request :get, '/test'
    end

    it "passes query string parameters to HTTParty" do
      Battlenet.should_receive(:get).with('/test', {:query => {:fields => 'talents'}})
      api.make_request :get, '/test', :fields => 'talents'
    end

    context "when the locale is set" do
      before(:each) do
        Battlenet.locale = "es_ES"
      end

      after(:each) do
        Battlenet.locale = nil
      end

      it "adds the locale parameter to the query string" do
        Battlenet.should_receive(:get).with('/test', {:query => {:fields => 'talents', :locale => 'es_ES'}})
        api.make_request :get, '/test', :fields => 'talents'
      end
    end

    context "when the public and private key are set" do
      let(:api) { Battlenet.new :us, 'public', 'private' }

      before(:each) do
        Timecop.freeze
      end

      after(:each) do
        Timecop.return
      end

      it "signs the request if the public and private key are present" do
        api.should_receive(:sign_request).with(:get, '/test', Time.now)
        api.make_request :get, '/test'
      end

      it "sets the Authorization and Date headers" do
        Battlenet::Authentication.any_instance.stub(:sign).and_return("signature")
        Battlenet.should_receive(:get).with('/test', :headers => { "Authorization" => "BNET public:signature", "Date" => Time.now.httpdate })
        api.make_request :get, '/test'
      end
    end

    context "when the response does not have a 200 status code" do
      before(:each) do
        response = mock(:response).as_null_object
        response.should_receive(:code).at_least(:once).and_return(500)
        Battlenet.should_receive(:get).and_return(response)
      end

      context "when fail_silently is off" do
        it "throws an exception" do
          lambda {
            api.get '/test'
          }.should raise_error
        end
      end

      context "when fail_silently is on" do
        before(:each) do
          Battlenet.fail_silently = true
        end

        it "does not throw an exception" do
          lambda {
            api.get '/test'
          }.should_not raise_error
        end
      end
    end
  end

  context "#sign_request" do
    let(:api) { Battlenet.new :us, 'public', 'private' }

    before(:each) do
      Timecop.freeze
    end

    after(:each) do
      Timecop.return
    end

    it "delegates to a Battlenet::Authentication" do
      auth = mock(:auth)
      Battlenet::Authentication.should_receive(:new).with('private').and_return(auth)
      auth.should_receive(:sign).with(:get, api.fullpath('/test'), Time.now)
      api.sign_request :get, '/test', Time.now
    end
  end
end
