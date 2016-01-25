#!/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'pry'

YARDS = {
  LKQ_RALEIGH: 1168,
  LKQ_DURHAM:  1142,
  LKQ_GREENSBORO:  1226,
  LKQ_GREENVILLE:  1227
}

YARDS_INV = YARDS.invert

def lookup_lkq(search_string, store_number)
  puts "Results for '#{search_string} from #{YARDS_INV[store_number]}"
  html = Nokogiri::HTML(open("http://www.lkqpickyourpart.com/DesktopModules/pyp_vehicleInventory/getVehicleInventory.aspx?page=0&filter=#{search_string}&sp=&cl=&carbuyYardCode=#{store_number}&pageSize=10&language=en-US"))
  html.xpath('//html/body/tr').each do |row|

    make = row.xpath('td[@class="pypvi_make"]/text()')
    model = row.xpath('td[@class="pypvi_model"]/text()')
    year = row.xpath('td[@class="pypvi_year"]/text()')
    date = row.xpath('td[@class="pypvi_date"]/text()')

    if Date.strptime(date.to_s, '%m/%d/%Y') >= Date.today-7
      puts "#{make} #{model} #{year} #{date}"
    end
  end
  puts "\n"
end


lookup_lkq('dodge', YARDS[:LKQ_RALEIGH])
lookup_lkq('mitsu', YARDS[:LKQ_RALEIGH])
lookup_lkq('dodge', YARDS[:LKQ_DURHAM])
lookup_lkq('mitsu', YARDS[:LKQ_DURHAM])
lookup_lkq('dodge', YARDS[:LKQ_GREENSBORO])
lookup_lkq('mitsu', YARDS[:LKQ_GREENSBORO])
lookup_lkq('dodge', YARDS[:LKQ_GREENVILLE])
lookup_lkq('mitsu', YARDS[:LKQ_GREENVILLE])
