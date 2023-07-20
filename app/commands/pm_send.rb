# frozen_string_literal: true

# This bot shows off PM functionality by sending a PM every time the bot is mentioned.

module PmSend
	extend	Discordrb::Commands::CommandContainer

	bot = Discordrb::Commands::CommandBot.new(
	  token: Rails.application.credentials.dig(:discord, :token),
	  client_id: Rails.application.credentials.dig(:discord, :client_id),
	  prefix: '/'
	)

# bot = Discordrb::Bot.new token: 'B0T.T0KEN.here'

	# The `mention` event is called if the bot is *directly mentioned*, i.e. not using a role mention or @everyone/@here.
	bot.mention do |event|
	  # The `pm` method is used to send a private message (also called a DM or direct message) to the user who sent the
	  # initial message.
	  event.user.pm('You have mentioned me!')
	end

	bot.run
end