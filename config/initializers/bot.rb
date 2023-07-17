require 'discordrb'


# rubocop:disable Style/GlobalVars
ChannelID = 759414764408930326

Bot = Discordrb::Commands::CommandBot.new(
    token: Rails.application.credentials.dig(:discord, :token),
    client_id: Rails.application.credentials.dig(:discord, :client_id),
    prefix: "/"
)
Dir["#{Rails.root}/app/commands/*.rb"].each { |file| require file }