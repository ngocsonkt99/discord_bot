module Ping
	extend	Discordrb::Commands::CommandContainer

	bot = Discordrb::Commands::CommandBot.new(
	  token: Rails.application.credentials.dig(:discord, :token),
	  client_id: Rails.application.credentials.dig(:discord, :client_id),
	  prefix: '/'
	)
	
	bot.message do |event|
  if event.message.content.start_with?('/')
    # Handle command
    command = event.message.content[1..-1].split(' ').first
    case command
    when 'ping'
      event.respond 'Ping poong!'
    when 'lenh'
      event.respond 'Opps!'
    else
      event.respond 'Lệnh không hợp lệ!'
    end
  else
    # Handle message
    case event.message.content
    when 'Hi'
      event.respond 'Chào bạn'
    when 'Hello'
      event.respond 'Xin chào'
    else
      event.respond 'Bot đã nhận được tin nhắn từ bạn!'
    end
  end
  end

	bot.run(true)
end