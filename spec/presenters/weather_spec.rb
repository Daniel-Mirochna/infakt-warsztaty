require 'rails_helper'

RSpec.describe WeatherPresenter do
  let(:presenter) { WeatherPresenter.new(WeatherApiConnector.new.weather_data) }

  it 'is not nil' do
    expect(presenter).not_to be_nil  
  end

  context 'description' do
    it 'is a string' do
      expect(presenter.description).to be_instance_of String
    end
  end

  context 'temperature' do
    it 'is a float' do
      expect(presenter.temperature).to be_instance_of Float
    end
  end
  
  context 'icon' do
    it 'is not nil' do
      expect(presenter.icon).not_to be_nil
    end
  end

  # dodać mockowanie wyniku metody description w metodzie nice_weather?
  context 'nice_weather' do
    context 'returns true' do
      it 'when Sunny' do
        expect(presenter.nice_weather?).to be true
      end

      it 'when Partly Cloudy' do
        expect(presenter.nice_weather?).to be true
      end
    end

    context 'returns false' do
      it 'when not Sunny nor Partly Cloudy' do
        expect(presenter.nice_weather?).to be false
      end
    end
  end
end
