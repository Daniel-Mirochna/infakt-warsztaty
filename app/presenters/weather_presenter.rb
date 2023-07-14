class WeatherPresenter
	def initialize(api_response)
		@api_response = api_response
	end
	
	def description
		@description ||= api_response_current.dig("condition", "text")
	end
	
	def temperature
		api_response_current["temp_c"]
	end
	
	def icon
		api_response_current.dig("condition", "icon")
	end
	
	
	def encourage_text
		if good_to_read_outside?
			"Get some snacks and go read a book in a park!"
		else
			"It's always a good weather to read a book!"
		end
	end
	
	private
	attr_reader :api_response

	def api_response_current
		@api_response_current ||= api_response["current"]
	end
	
	def nice_weather?
		['Sunny', 'Partly cloudy'].include? description
	end
	
	def good_to_read_outside?
		nice_weather? && temperature > 15
	end

end