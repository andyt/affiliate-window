module AffiliateWindow::Helpers

  # Helper methods for account delegation and using a default account.
  module Account

    attr_accessor :account

    # Some delegation methods (avoids having a delegation dependency).
    def user; account.user; end
    def datafeed_password; account.datafeed_password; end
    def api_password; account.api_password; end
    def api_key; account.api_key; end

    def format; account.format; end
    def compression_parameter; account.compression_parameter; end

    # Sets @account to the passed account, or a defined default.
    def set_account(account)
      @account = account || AffiliateWindow.account
      raise ArgumentError, "Pass the account parameter, or set AffiliateWindow.account." unless @account
    end

  end

end