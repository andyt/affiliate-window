module AffiliateWindow::Helpers

  # Helper methods for CSV handling.
  module Csv

    def csv
      @csv ||= AffiliateWindow.fetch(url)
    end

    def all
      items = [];
      each { |r| items << r }
      items
    end

    def each
      CSV.foreach(csv, :headers => true, :header_converters => :symbol) do |row|
        yield(row.to_hash)
      end
    end

  end  

end