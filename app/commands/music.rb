module Music
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

  bot.command :user do |event|
    # Commands send whatever is returned from the block to the channel. This allows for compact commands like this,
    # but you have to be aware of this so you don't accidentally return something you didn't intend to.
    # To prevent the return value to be sent to the channel, you can just return `nil`.
    event.user.name
  end

	# bot.command(:play_music) do |event|
	#   channel = event.user.voice_channel
	#   next "You're not in any voice channel!" unless channel

	#   bot.voice_connect(channel) # Kết nối vào voice channel

	#   audio_file_path = 'data/data_music.mp3'

	#   # Tạo một đối tượng FFMPEG::Movie từ file âm thanh
	#   audio = FFMPEG::Movie.new(audio_file_path)

	#   # Chuyển đổi file âm thanh thành định dạng DCA
	#   dca_file_path = 'data/music.dca'
	#   audio.transcode(dca_file_path, { audio_codec: 'libmp3lame' })

	#   # Phát nhạc từ file DCA
	#   bot.voice(event.server).play_dca(dca_file_path)

	#   nil # Đảm bảo không gửi giá trị trả về lên kênh
	# end

  bot.command :connect do |event|
    # The `voice_channel` method returns the voice channel the user is currently in, or `nil` if the user is not in a
    # voice channel.
    channel = event.user.voice_channel
    # Here we return from the command unless the channel is not nil (i. e. the user is in a voice channel). The `next`
    # construct can be used to exit a command prematurely, and even send a message while we're at it.
    next "You're not in any voice channel!" unless channel
    # The `voice_connect` method does everything necessary for the bot to connect to a voice channel. Afterwards the bot
    # will be connected and ready to play stuff back.
    bot.voice_connect(channel)
    "Connected to voice channel: #{channel.name}"
  end

  # A simple command that plays back an mp3 file.
  bot.command(:play_mp3) do |event|
    # `event.voice` is a helper method that gets the correct voice bot on the server the bot is currently in. Since a
    # bot may be connected to more than one voice channel (never more than one on the same server, though), this is
    # necessary to allow the differentiation of servers.
    #
    # It returns a `VoiceBot` object that methods such as `play_file` can be called on.
    voice_bot = event.voice
    voice_bot.play_file('data/data_music.mp3')
  end
  # DCA is a custom audio format developed by a couple people from the Discord API community (including myself, meew0).
  # It represents the audio data exactly as Discord wants it in a format that is very simple to parse, so libraries can
  # very easily add support for it. It has the advantage that absolutely no transcoding has to be done, so it is very
  # light on CPU in comparison to `play_file`.
  #
  # A conversion utility that converts existing audio files to DCA can be found here: https://github.com/RaymondSchnyder/dca-rs
  bot.command(:play_dca) do |event|
    voice_bot = event.voice
    # Since the DCA format is non-standard (i.e. ffmpeg doesn't support it), a separate method other than `play_file` has
    # to be used to play DCA files back. `play_dca` fulfills that role.
    voice_bot.play_dca('data/music.dca')
  end
	bot.run(true)
end