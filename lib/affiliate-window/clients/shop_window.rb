module AffiliateWindow
  module Clients

    class ShopWindow

      include AffiliateWindow::Helpers::Client
      include AffiliateWindow::Helpers::Account
      include AffiliateWindow::Helpers::Csv

      attr :merchants

      URL_TEMPLATE = 'http://datafeed.api.productserve.com/datafeed/download/apikey/#{api_key}/mid/#{merchant_id_list}/columns/#{column_list}/format/#{format.downcase}/compression/#{compression_parameter}/'

      DEFAULT_COLUMNS = %w{ merchant_id merchant_name aw_product_id merchant_product_id product_name description 
                            category_id category_name merchant_category aw_deep_link aw_image_url search_price 
                            delivery_cost merchant_deep_link merchant_image_url mpn rrp_price stock_quantity 
                            brand_id ean merchant_thumb_url brand_name in_stock model_number specifications upc }

      def initialize(options = {})
        parse_options(options)
      end

      def url
        @url ||= eval(%Q|"#{URL_TEMPLATE}"|)
      end

      def columns
        @columns || DEFAULT_COLUMNS
      end

      private

        def column_list
          columns.join(',')
        end

        def merchant_id_list
          merchants.collect(&:merchant_id).join(',')
        end

    end
  end
end