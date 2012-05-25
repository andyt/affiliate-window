require_relative '../../helper'

module AffiliateWindow
  module Clients
    class CategorySpec < MiniTest::Unit::TestCase

      Klass = AffiliateWindow::Clients::Category

      describe Klass do
        
        describe '.new' do
          it 'requires an account' do
            proc { Klass.new }.must_raise ArgumentError
          end
        end

        describe 'Instances' do
          before do
            @client = Klass.new(account)
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
