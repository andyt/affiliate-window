require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'affiliate-window'

class MiniTest::Unit::TestCase
  class << self
    def fixture_path
      @fixture_path ||= File.join(File.dirname(__FILE__), 'fixtures')
    end
  end

  def setup
    FakeWeb.clean_registry
  end
      
  # Returns an account we can use.
  #
  # TOD: Change these!
  def account
    AffiliateWindow::Account.new(
      :user => '34475', 
      :datafeed_password => '3ef2db0c8d9230f90e9974000d7b4ebb', 
      :api_key => 'ab3fe0c405ecf92fa8df973f5aa279cf',
      :api_password => 'dc6024ea40e16826cb75e6a7c3f08cfc6b3d500f4ee684ec'
    )
  end

  def fixture_path
    self.class.fixture_path
  end
end

 # by default HTTPI and Savon churn out debugging info.
HTTPI.log = false
Savon.log = false

require 'fakeweb'
FakeWeb.allow_net_connect = false

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::DefaultReporter.new
MiniTest::Unit.autorun
