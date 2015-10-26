require 'uri'

class HomeController < ApplicationController #The name of this controller does not matter
  def index # This is the page that displays the search field
  end

  def search
    weather_url = 'http://api.openweathermap.org/data/2.5/weather' #Remote weather API that returns JSON (Reference: http://openweathermap.org/current)
    request_url = 'http://rpc.geocoder.us/service/json?address=' #Remote 'geocoder' API that returns JSON (Reference: http://geocoder.us/help/)
    address  = params[:query]
    puts address.inspect
    response = HTTParty.get(request_url + URI.escape(address))
    hash_response = JSON.parse(response)
    puts hash_response.inspect   #<< Having to puts out the response to the log helps figure out what keys I need to look at.
    lat  = hash_response[0]["lat"]
    long = hash_response[0]["long"]

    weather_response = HTTParty.get(weather_url + "?lat=#{lat}&lon=#{long}&appid=bd82977b86bf27fb59a04b61b657fb6f")

    @weather_data = JSON.parse(weather_response.body)
  end
end
