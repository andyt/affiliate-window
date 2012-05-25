module AffiliateWindow::Helpers

  # Helper methods for client classes.
  module Client

    def parse_options(options)
      set_account(options.delete(:account))
      options.each do |k, v|
        if respond_to?(k)
          instance_variable_set("@#{k}", v)
        else
          raise ArgumentError, "Unknown option #{k}."
        end
      end
    end

    def fetch(target = Tempfile.new('awin').path)
      AffiliateWindow.fetch(url, target)
    end

  end

end