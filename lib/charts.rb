require 'net/http'
require 'json'
require_relative 'extensions'

SPREADSHEET_ID = 't024bMoRiDPIDialGnuKPsg'
VC_SPREADSHEET_ID = '14kHrnKbX6WOCx26ieE2sPAqMCKiM-kSC22VNhatnW9k'
VC_SPREADSHEET_COPY_ID = '132yNUwXYyu_YmtNMWpM6-YLdYZ5VcLK_cJKLklnSqNI'
API_KEY = 'AIzaSyBZCSyQ4hpeiRGo4lVSR9rU_SwrAsclcMU'

module Google
  class SpreadSheet
    def initialize(sheet_id, api_key)
      @uri = lambda {|path| URI('https://sheets.googleapis.com/v4/spreadsheets/' + sheet_id + "#{path}")}
      @api_key = api_key
    end

    def read_single_range(range)
      uri =  @uri.call("/values/#{range}")
      add_params(uri)
      Net::HTTP.get_response(uri).body
    end

    def read_multiple_ranges(*ranges)
      uri = @uri.call("/values:batchGet?")
      add_params(uri, ranges)
      Net::HTTP.get_response(uri).body
    end

    private

    def add_api_key(uri)
      uri.query = URI.encode_www_form(key: API_KEY)
    end

    def add_params(uri, ranges = nil)
      if ranges.nil?
        uri.query = URI.encode_www_form(key: API_KEY)
      else
        params = {key: API_KEY, ranges: []}
        ranges.each do |range|
          params[:ranges] << range
        end
        uri.query = URI.encode_www_form(params)
      end
    end
  end
end
