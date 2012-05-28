module AffiliateWindow
  class Account
    attr_reader :user, :api_password, :api_key, :datafeed_password, :format, :compression

    VALID_FORMATS = %w{CSV} # XML not yet supported.

    # Unzipping is not supported for portability, but you can specify it to download a zipped file.
    # CSV helper methods won't work with zipped downloads.
    VALID_COMPRESSIONS = %w{none zip}

    def initialize(options)
      @user ||= options[:user] || raise(ArgumentError, ":user option is required.")
      @api_password ||= options[:api_password] || raise(ArgumentError, ":api_password option is required.")
      @api_key ||= options[:api_key] || raise(ArgumentError, ":api_key option is required.")
      @datafeed_password ||= options[:datafeed_password] || raise(ArgumentError, ":datafeed_password option is required.")
      self.format = options[:format] || VALID_FORMATS.first
      self.compression = options[:compression] || VALID_COMPRESSIONS.first
    end

    def format=(value)
      value = value.upcase.to_s
      raise ArgumentError, "Invalid format #{value} - use #{VALID_FORMATS.join(', ')}." unless VALID_FORMATS.include?(value)
      @format = value
    end

    def compression=(value)
      value = value.downcase.to_s
      raise ArgumentError, "Invalid compression #{value} - use #{VALID_COMPRESSIONS.join(', ')}." unless VALID_COMPRESSIONS.include?(value)
      @compression = value
    end

    def compression_parameter
      @compression == 'none' ? '' : @compression
    end

    def attributes
      {
        :user => user,
        :api_password => api_password,
        :api_key => api_key,
        :datafeed_password => datafeed_password,
        :format => format,
        :compression => compression
      }
    end

  end
end