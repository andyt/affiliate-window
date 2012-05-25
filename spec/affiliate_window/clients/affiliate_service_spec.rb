

module AffiliateWindow
  module Clients

    Klass = ::AffiliateWindow::Clients::AffiliateService

    describe Klass do
      
      it 'has a local cache of the WSDL document' do
        File.exists?(Klass::CACHED_WSDL_PATH).must_equal true
      end

      describe '.new' do
        it 'requires an account' do
          proc { Klass.new }.must_raise ArgumentError
        end
      end

      describe 'Instances' do
        before do
          FakeWeb.register_uri(:any, Klass::ENDPOINT_URL, :response => File.join(fixture_path, 'responses', 'get_transaction_list.xml'))
          @client = Klass.new(account)
        end

        it 'has an array of actions' do
          @client.wsdl.soap_actions.must_equal Klass::ACTIONS
        end

        it 'returns a transaction list' do
          method = :get_transaction_list
          response = @client.request(method) do
            soap.body = {
              :d_start_date => Time.now - 3600 * 250,
              :d_end_date => Time.now,
              :s_date_type => 'validation'
            }
          end
          response.soap_fault?.must_equal false
          response.http_error?.must_equal false
          response.success?.must_equal true
          response.to_hash[:"#{method}_response"].must_be_instance_of Hash
          response.to_hash[:"#{method}_response"][:"#{method}_return"][:transaction].must_be_instance_of Array
          transaction = response.to_hash[:"#{method}_response"][:"#{method}_return"][:transaction].first
          transaction.must_be_instance_of Hash
        end
      end

    end
  end
end
