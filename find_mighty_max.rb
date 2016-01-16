#!/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'pry'

html = Nokogiri::HTML(open("http://www.lkqpickyourpart.com/DesktopModules/pyp_vehicleInventory/getVehicleInventory.aspx?store=142&page=0&filter=dodge&sp=&cl=&carbuyYardCode=1142&pageSize=15&language=en-US"))


html.xpath('//html/body/tr').each do |row|

  make = row.xpath('td[@class="pypvi_make"]/text()')
  puts make

end
