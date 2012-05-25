require File.dirname(__FILE__) + '/../../helper'

module AffiliateWindow
  module Helpers
    class CsvSpec < MiniTest::Unit::TestCase

      class ExtendedByCsvHelper
        include AffiliateWindow::Helpers::Csv
        def url; "http://example.com/"; end
      end

      describe ::AffiliateWindow::Helpers::Csv do
        before do
          @instance = ExtendedByCsvHelper.new
        end

        describe '#csv' do
          it 'should return CSV path' do
            AffiliateWindow.stubs(:fetch).returns('/path/to/file.csv')
            @instance.csv
          end
        end

        describe '#each' do
          it 'should return each item in the CSV as a hash with symbolized keys' do
            AffiliateWindow.stubs(:fetch).returns(File.join(fixture_path, 'csv', 'merchants.csv'))
            @instance.each do |r|
              r.must_be_kind_of Hash
              r.keys.map(&:class).uniq.must_equal [Symbol]
            end
          end
        end

        describe '#all' do
          it 'should return all items in the CSV' do
            AffiliateWindow.stubs(:fetch).returns(File.join(fixture_path, 'csv', 'merchants.csv'))
            @instance.all.size.must_equal 2
          end
        end
      end
    end
  end
end
