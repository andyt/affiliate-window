require File.dirname(__FILE__) + '/../helper'

module AffiliateWindow
  class AccountSpec < MiniTest::Unit::TestCase

    Klass = ::AffiliateWindow::Account

    describe Klass do

      describe '#compression_parameter' do
        it 'should return an empty string if compression is :none' do
          @account = account
          @account.compression = :none
          @account.compression_parameter.must_equal ''
        end

        it 'requires a datafeed password' do
          proc { Klass.new(account.attributes.merge(:datafeed_password => nil)) }.must_raise ArgumentError
        end

        it 'requires an API password' do
          proc { Klass.new(account.attributes.merge(:api_password => nil)) }.must_raise ArgumentError
        end

        it 'requires an API key' do
          proc { Klass.new(account.attributes.merge(:api_key => nil)) }.must_raise ArgumentError
        end

      end
    end

  end
end