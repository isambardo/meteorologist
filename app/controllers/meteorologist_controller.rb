require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url_address = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_address_data = JSON.parse(open(url_address).read)

    @latitude = parsed_address_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_address_data["results"][0]["geometry"]["location"]["lng"]

    url_weather = "https://api.forecast.io/forecast/d9b7a33e4b9608bef64694b5637c7b46/" + @latitude.to_s + "," + @longitude.to_s

    parsed_weather_data = JSON.parse(open(url_weather).read)

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]


    render("street_to_weather.html.erb")
  end
end
