require 'discordrb'
# require 'ffmpeg'

# rubocop:disable Style/GlobalVars
CHANNEL_ID = 759414764408930326

bot = Discordrb::Commands::CommandBot.new(
  token: Rails.application.credentials.dig(:discord, :token),
  client_id: Rails.application.credentials.dig(:discord, :client_id),
  prefix: '/'
)

Dir["#{Rails.root}/app/commands/ping.rb"].each { |file| require file }

# Dir["#{Rails.root}/app/commands/music.rb"].each { |file| require file }

bot.run
