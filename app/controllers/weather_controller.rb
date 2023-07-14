class WeatherController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    latitude = weather_show_params[:latitude].to_f
    longitude = weather_show_params[:longitude].to_f
    @data = WeatherApiConnector.new.weather_data(latitude, longitude)
    @weather_presenter = WeatherPresenter.new(@data)
  end

  private

  def weather_show_params
    params.permit(:latitude, :longitude)
  end
end
