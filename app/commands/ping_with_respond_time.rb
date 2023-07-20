# frozen_string_literal: true

# This example is nearly the same as the normal ping example, but rather than simply responding with "Pong!", it also
# responds with the time it took to send the message.

module PingWithRespondTime
	extend	Discordrb::Commands::CommandContainer

	bot = Discordrb::Commands::CommandBot.new(
	  token: Rails.application.credentials.dig(:discord, :token),
	  client_id: Rails.application.credentials.dig(:discord, :client_id),
	  prefix: '/'
	)

# bot = Discordrb::Bot.new token: 'B0T.T0KEN.here'

	bot.message(content: 'Ping!') do |event|
	  # The `respond` method returns a `Message` object, which is stored in a variable `m`. The `edit` method is then called
	  # to edit the message with the time difference between when the event was received and after the message was sent.
	  m = event.respond('Pong!')
	  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
	end

	bot.run
end