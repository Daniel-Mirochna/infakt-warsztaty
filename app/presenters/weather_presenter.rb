class WeatherPresenter
	attr_reader :api_response

	def initialize(api_response)
		@api_response = api_response
	end

	def description
		api_response["current"]["condition"]["text"]
	end

	def temperature
		api_response["current"]["temp_c"]
	end

	def icon
		api_response["current"]["condition"]["icon"]
	end

	def nice_weather?
		['Sunny', 'Partly cloudy'].include? description
	end

	def good_to_read_outside?
		nice_weather? && temperature > 15
	end

	def encourage_text
		if good_to_read_outside?
			"Get some snacks and go read a book in a park!"
		else
			"It's always a good weather to read a book!"
		end
	end
end