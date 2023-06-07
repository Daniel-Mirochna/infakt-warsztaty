class WeatherApiConnector
  API_KEY = A9n.weather_api_key

  def weather_data(latitude, longitude)
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{latitude},#{longitude}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
