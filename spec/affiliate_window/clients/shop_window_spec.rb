require_relative '../../helper'

module AffiliateWindow
  module Clients
    class ShopWindowSpec < MiniTest::Unit::TestCase

      Klass = ::AffiliateWindow::Clients::ShopWindow

      describe Klass do
        
        describe '.new' do
          it 'requires an account' do
            proc { Klass.new }.must_raise ArgumentError
          end
        end

        describe 'Instances' do
          before do
            @merchants = 3.times.map { |id| stub(:id => id) }
            @client = Klass.new(:account => account, :merchants => @merchants)
          end

          it 'handles CSV files' do
            @client.must_respond_to :csv
            @client.must_respond_to :each
            @client.must_respond_to :all
          end
          
          describe '#url' do
            it 'returns a completed URL template' do
              @client.url.must_match /#{account.api_key}/
              @client.url.must_match /#{@merchants.collect{|m| m.id}.join(',')}/
              @client.url.must_match /#{Klass::DEFAULT_COLUMNS.join(',')}/
            end
          end
        end

      end
    end
  end
end
