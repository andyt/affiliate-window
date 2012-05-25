module AffiliateWindow::Clients

  class Merchant

    include AffiliateWindow::Helpers::Account
    include AffiliateWindow::Helpers::Csv

    attr :filter

    URL_TEMPLATE = 'https://www.affiliatewindow.com/affiliates/shopwindow/datafeed_metadata.php?user=#{user}&password=#{datafeed_password}&format=#{format}&filter=#{filter}&compression='

    VALID_FILTERS = %w{SUBSCRIBED_ALL SUBSCRIBED_ENABLED ALL_ALL ALL_ENABLED}

    def initialize(filter = nil, account = nil)
      set_account(account)
      self.filter = filter || VALID_FILTERS.first
    end

    def url
      @url ||= eval(%Q|"#{URL_TEMPLATE}"|)
    end

    private

      def filter=(value)
        value = value.to_s.upcase
        raise ArgumentError unless VALID_FILTERS.include?(value)
        @filter = value
      end

  end
end