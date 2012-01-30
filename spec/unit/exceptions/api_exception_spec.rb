require 'spec_helper'

describe Battlenet::ApiException do
  let(:response) do
    resp = stub(:response)
    resp.stub(:code).and_return(500)
    resp.stub(:[]).with('reason').and_return('Bad Juju!')
    resp
  end
  let(:ex) { Battlenet::ApiException.new(response) }

  it "gives access to the response" do
    ex.response.should == response
  end

  it "has a status code based on the HTTP response code" do
    ex.code.should == 500
  end

  it "has a reason based on the response" do
    ex.reason.should == 'Bad Juju!'
  end
end
