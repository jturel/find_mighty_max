#!/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'pry'

LKQ_RALEIGH = 1168
LKQ_DURHAM = 1142

def lookup_lkq(search_string, store_number)
  puts "Results for '#{search_string} from #{store_number}"
  html = Nokogiri::HTML(open("http://www.lkqpickyourpart.com/DesktopModules/pyp_vehicleInventory/getVehicleInventory.aspx?page=0&filter=#{search_string}&sp=&cl=&carbuyYardCode=#{store_number}&pageSize=15&language=en-US"))
  html.xpath('//html/body/tr').each do |row|

    make = row.xpath('td[@class="pypvi_make"]/text()')
    model = row.xpath('td[@class="pypvi_model"]/text()')
    year = row.xpath('td[@class="pypvi_year"]/text()')
    date = row.xpath('td[@class="pypvi_date"]/text()')
    puts "#{make} #{model} #{year} #{date}"

    #binding.pry
  end
end


lookup_lkq('dodge', LKQ_RALEIGH)

puts "\n"

lookup_lkq('dodge', LKQ_DURHAM)
