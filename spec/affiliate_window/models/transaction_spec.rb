require File.dirname(__FILE__) + '/../../helper'

module AffiliateWindow
  module Models
    class TransactionSpec < MiniTest::Unit::TestCase

      Klass = ::AffiliateWindow::Models::Transaction

      describe Klass do
        
        before do
          FakeWeb.register_uri(:any, AffiliateWindow::Clients::AffiliateService::ENDPOINT_URL, :response => File.join(fixture_path, 'responses', 'get_transaction_list.xml'))
          Klass.account = account
        end

        it 'stores an account' do
          Klass.account.must_be_kind_of AffiliateWindow::Account
        end

        it 'returns a transaction list' do
          method = :get_transaction_list
          Klass.get_transaction_list(
            :d_start_date => Time.now - 3600 * 250,
            :d_end_date => Time.now,
            :s_date_type => 'validation'
          ).must_be_kind_of Savon::SOAP::Response
        end

        it 'returns transactions from today' do
          collection = Klass.today
          transaction = collection.first

          collection.must_be_kind_of Array
          transaction.must_be_kind_of Klass
          transaction.id.must_equal '59330775'
          
          transaction.transaction_parts.must_be_kind_of Array
          
        end

      end
    end
  end
end