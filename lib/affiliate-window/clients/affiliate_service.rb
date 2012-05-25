module AffiliateWindow::Clients

  # SOAP client for the AffiliateWindow AffiliateService API.
  #
  # Instantiate carefully! This parses the WSDL document every time.
  class AffiliateService < Savon::Client

    include AffiliateWindow::Helpers::Account

    ENDPOINT_URL = 'http://api.affiliatewindow.com/v3/AffiliateService'
    
    WSDL_URL = ENDPOINT_URL + '?wsdl'

    CACHED_WSDL_PATH = File.join(File.dirname(__FILE__), '..', '..', '..', 'wsdl', 'affiliate_service_v3.wsdl')

    ACTIONS = [:get_transaction_list, :get_transaction_product, :get_transaction, :get_merchant_list, :get_merchant, :get_transaction_querys, :set_transaction_query, :get_impression_stats, :get_click_stats, :get_commission_group, :get_commission_group_list]

    def initialize(account = nil)
      set_account(account)
      super(CACHED_WSDL_PATH)
    end

    # Override the request method so that we can inject the authentication header.
    def request(*args, &block)
      super(*args) do        
        soap.header = header
        process &block if block
      end
    end

    private

      # We need 'UserAuthenication' as a string due to the odd capitalisation.
      def header
        {
          'UserAuthentication' => {
            :i_id => user,
            :s_password => api_password,
            :s_type => 'affiliate'
          }
        }
      end

  end
end