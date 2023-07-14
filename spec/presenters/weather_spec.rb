require 'rails_helper'

RSpec.describe WeatherPresenter do
  let(:presenter) { WeatherPresenter.new(WeatherApiConnector.new.weather_data(41.39, 2.1540)) }

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
  context 'nice_weather?' do
    it 'returns true when Sunny' do
      allow(presenter).to receive(:description).and_return("Sunny")
      expect(presenter.send(:nice_weather?)).to be true
    end

    it 'returns true when Partly cloudy' do
      allow(presenter).to receive(:description).and_return("Partly cloudy")
      expect(presenter.send(:nice_weather?)).to be true
    end

    it 'returns false when not Sunny nor Partly cloudy' do
      allow(presenter).to receive(:description).and_return("Rainy")
      expect(presenter.send(:nice_weather?)).to be false
    end
  end

  context 'good_to_read_outside?' do
    it 'returns true when weather is nice and temperature > 15' do
      allow(presenter).to receive(:temperature).and_return(15.1)
      allow(presenter).to receive(:nice_weather?).and_return(true)
      expect(presenter.send(:good_to_read_outside?)).to be true
    end

    it 'returns false when temperature <= 15' do
      allow(presenter).to receive(:temperature).and_return(15)
      allow(presenter).to receive(:nice_weather?).and_return(true)
      expect(presenter.send(:good_to_read_outside?)).to be false
    end

    it 'returns false when weather is not nice' do
      allow(presenter).to receive(:temperature).and_return(15.1)
      allow(presenter).to receive(:nice_weather?).and_return(false)
      expect(presenter.send(:good_to_read_outside?)).to be false
    end

    it 'returns false when temperature <= 15 and weather is not nice' do
      allow(presenter).to receive(:temperature).and_return(15)
      allow(presenter).to receive(:nice_weather?).and_return(false)
      expect(presenter.send(:good_to_read_outside?)).to be false
    end
  end

  context 'encourage_text' do
    it 'returns "Get some snacks and go read a book in a park!" when it is good_to_read_outside' do
      allow(presenter).to receive(:good_to_read_outside?).and_return(true)
      expect(presenter.encourage_text).to eq("Get some snacks and go read a book in a park!")
    end

    it 'returns "Its always a good weather to read a book!" when it is not good_to_read_outside' do
      allow(presenter).to receive(:good_to_read_outside?).and_return(false)
      expect(presenter.encourage_text).to eq("It's always a good weather to read a book!")
    end
  end
end
