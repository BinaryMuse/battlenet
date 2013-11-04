require 'spec_helper'

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

  context "#get" do
    let(:api) { Battlenet.new :us }

    it "delegates to HTTParty" do
      Battlenet.should_receive(:get).with('/test', {})
      api.get '/test'
    end

    it "passes query string parameters to HTTParty" do
      Battlenet.should_receive(:get).with('/test', {:query => {:fields => 'talents'}})
      api.get '/test', :fields => 'talents'
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
        api.get '/test', :fields => 'talents'
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
        api.get '/test'
      end

      it "sets the Authorization and Date headers" do
        Battlenet::Authentication.any_instance.stub(:sign).and_return("signature")
        Battlenet.should_receive(:get).with('/test', :headers => { "Authorization" => "BNET public:signature", "Date" => Time.now.httpdate })
        api.get '/test'
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

      it "signs the request using the full path" do
        api.instance_variable_set(:@endpoint, "/tester/testing")
        auth = mock(:auth)
        Battlenet::Authentication.should_receive(:new).with('private').and_return(auth)
        auth.should_receive(:sign).with(:get, '/tester/testing/test', Time.now)
        api.get '/test'
      end
    end

    context "when the response does not have a status code indicating success" do
      before(:each) do
        response = stub(:response).as_null_object
        response.stub(:code).and_return(500)
        response.stub(:[]).with('reason').and_return('Server Error')
        Battlenet.should_receive(:get).and_return(response)
      end

      context "when fail_silently is off" do
        it "throws an exception with a message that contains the code and reason" do
          lambda {
            api.get '/test'
          }.should raise_error(Battlenet::ApiException, /500.*?Server Error/)
        end

        it "throws an exception with the code and reason set" do
          begin
            api.get '/test'
          rescue Battlenet::ApiException => ex
            ex.code.should == 500
            ex.reason.should == 'Server Error'
          end
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
end
