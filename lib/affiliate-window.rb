module AffiliateWindow

  require 'csv'
  require 'net/http'
  require 'savon'
  require 'savon_model'
  require 'affiliate-window/version'
  require 'affiliate-window/helpers/account'
  require 'affiliate-window/helpers/client'
  require 'affiliate-window/helpers/csv'
  require 'affiliate-window/account'
  require 'affiliate-window/clients/category'
  require 'affiliate-window/clients/merchant'
  require 'affiliate-window/clients/affiliate_service'
  require 'affiliate-window/clients/shop_window'
  require 'affiliate-window/models/transaction'
  
  DEFAULT_USER_AGENT = "AffiliateWindow rubygem v#{Version::STRING} (http://github.com/andyt/affiliate-window)"

  def self.account
    @account
  end

  def self.account=(account)
    @account = account
  end

  def self.user_agent
    @user_agent || DEFAULT_USER_AGENT
  end

  def self.user_agent=(string)
    @user_agent = string
  end

  def self.fetch(uri, target = Tempfile.new('awin').path)
    uri = URI(uri)

    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri.request_uri, {'User-Agent' => self.user_agent}

      http.request request do |response|
        open target, 'wb' do |io|
          response.read_body do |chunk|
            io.write chunk
          end
        end
      end
    end
    target
  end

end