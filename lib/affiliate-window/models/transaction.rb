# {:i_id=>"59330775", :s_status=>"confirmed", :s_type=>"normal", :s_ip=>"193.130.64.132", :b_paid=>false, :i_payment_id=>"0", :i_merchant_id=>"2698", :f_sale_amount=>"186.29", :f_commission_amount=>"7.45", :d_click_date=>"2011-10-31 17:36:03", :d_transaction_date=>"2011-11-01 12:37:41", :d_validation_date=>"2011-11-22 10:32:50", :s_clickref=>"1185896", :a_transaction_parts=>{:transaction_part=>{:s_commission_group_name=>"Default Commission", :f_sale_amount=>"186.29", :f_commission_amount=>"7.45", :i_commission=>"4", :s_commission_type=>"percentage"}}}
require 'hashie'

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end

module AffiliateWindow
	module Models
    class Transaction < Hashie::Mash

      include Savon::Model

      CONVERSIONS = {
        :i => :to_i,
        :a => :to_a,
        :f => :to_f,
        :d => proc { |v| Time.parse(v) },
        :s => :to_s
      }

      KEYS = %w{
        i_id s_status s_type s_ip b_paid i_payment_id i_merchant_id f_sale_amount f_commission_amount d_click_date d_transaction_date 
        d_validation_date s_clickref a_transaction_parts
        =>{:transaction_part=>{:s_commission_group_name=>"Default Commission", :f_sale_amount=>"186.29", :f_commission_amount=>"7.45", :i_commission=>"4", :s_commission_type=>"percentage"}}}

      actions :get_transaction, :get_transaction_list

      class << self

        def account=(account)
          @account = account
        end

        def account
          @account || ::AffiliateWindow.account
        end

        def client
          @client ||= ::AffiliateWindow::Clients::AffiliateService.new(account)
        end

        def today
          initialize_collection_from_hash(get_transaction_list(
            :d_start_date => Time.now - 3600 * 250,
            :d_end_date => Time.now,
            :s_date_type => 'validation'
          ))
        end

        def initialize_collection_from_xml(response)
          puts response.to_xml
          parse(response.to_xml)
        end

        def initialize_collection_from_hash(response)
          response.to_hash.deep_find(:transaction).collect do |hash|
            self.new(hash)
          end
        end

      end

      protected

      def convert_key(key)
        key.to_s.gsub(/^[#{CONVERSIONS.keys.map(&:to_s).join}]_/, '')
      end

      def xx_convert_value(val, duping=false) #:nodoc:
        case val
          when self.class
            val.dup
          when ::Hash
            val = val.dup if duping
            self.class.new(val)
          when Array
            val.collect{ |e| convert_value(e) }
          else
            val
        end
      end

      def xx_id
        attributes[:i_id].to_i
      end

    end
  end
end