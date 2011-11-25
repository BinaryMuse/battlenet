require 'battlenet'

require 'timecop'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.stub_with :webmock
end
