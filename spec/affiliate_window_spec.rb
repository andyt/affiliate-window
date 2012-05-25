require 'helper'

class AffiliateWindowSpec < MiniTest::Unit::TestCase

    describe ::AffiliateWindow do

    it "should store an account" do
      @account = account
      AffiliateWindow.account = @account
      AffiliateWindow.account.must_be_same_as @account
      AffiliateWindow.account = nil # teardown
    end

    it "should have a default user agent string" do
      AffiliateWindow.user_agent.must_match /AffiliateWindow/
    end

    it "should store a custom user agent string" do
      AffiliateWindow.user_agent = 'AffiliateWindow test'
      AffiliateWindow.user_agent.must_equal 'AffiliateWindow test'
    end

    it "should fetch files and return the local filename" do
      FakeWeb.register_uri(:any, 'http://affiliatewindow.com/merchants.csv', :response => File.join(fixture_path, 'responses', 'merchants.csv'))
      AffiliateWindow.fetch('http://affiliatewindow.com/merchants.csv', '/tmp/test').must_equal '/tmp/test'
    end
  end
end