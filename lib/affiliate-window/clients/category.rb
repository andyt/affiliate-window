module AffiliateWindow::Clients

  class Category

    include AffiliateWindow::Helpers::Account
    include AffiliateWindow::Helpers::Csv

    URL_TEMPLATE = 'http://datafeeds.productserve.com/datafeed_category.php?user=#{user}&password=#{datafeed_password}&format=#{format}&compression=#{compression_parameter}'
    
    def initialize(account = nil)
      set_account(account)
    end

    def url
      @url ||= eval(%Q|"#{URL_TEMPLATE}"|)
    end

  end
end