import vlc
i = vlc.Instance('--verbose 2'.split())
p = i.media_player_new()
p.set_mrl('rtp://@224.1.1.1')
p.play()
