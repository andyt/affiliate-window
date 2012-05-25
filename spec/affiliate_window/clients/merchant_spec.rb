require_relative '../../helper'

module AffiliateWindow
  module Clients
    class MerchantSpec < MiniTest::Unit::TestCase

      Klass = ::AffiliateWindow::Clients::Merchant

      describe Klass do
        
        describe '.new' do
          it 'requires an account' do
            proc { Klass.new }.must_raise ArgumentError
          end

          it 'sets a default filter' do
            client = Klass.new(nil, account)
            client.filter.wont_be_empty
          end

          it 'raises an error if filter is invalid' do
            proc { Klass.new('DUFF_FILTER', account) }.must_raise ArgumentError
          end
        end

        describe 'Instances' do
          before do
            @client = Klass.new(nil, account)
          end

          it 'handles CSV files' do
            @client.must_respond_to :csv
            @client.must_respond_to :each
            @client.must_respond_to :all
          end
          
          describe '#url' do
            it 'returns a completed URL template' do
              @client.url.must_match /#{account.user}/
              @client.url.must_match /#{account.datafeed_password}/
            end
          end
        end

      end
    end
  end
end
