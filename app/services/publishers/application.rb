require 'bunny'

module Publishers
	class Application
		attr_reader :message, :exchange_name, :routing_key

		def initialize(message: 'test', exchange_name: 'book_data', routing_key: 'book_data_1')
			@message = message
			@exchange_name = exchange_name
			@routing_key = routing_key
		end

		def perform
			connection.start
			channel = connection.create_channel
			channel.direct(exchange_name)
				.publish(message.to_json, routing_key: routing_key)
			connection.close
		end

		private

		def connection_options
			{
				host: "localhost",
				port: "5672",
				vhost: "/",
				username: "guest",
				password: "guest"
			}
		end

		def connection
			@connection ||= Bunny.new(connection_options)
		end
	end
end