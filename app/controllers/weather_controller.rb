class WeatherController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @data = WeatherApiConnector.new.weather_data(geo_value(:latitude), geo_value(:longitude))
    @weather_presenter = WeatherPresenter.new(@data)
  end

  private

  def geo_value(name)
    weather_show_params[name].to_f
  end

  def weather_show_params
    params.permit(:latitude, :longitude)
  end
end
