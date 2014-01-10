require 'wunder_markdown'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :webmock # or :fakeweb
end
