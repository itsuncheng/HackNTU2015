local lfs = require "lfs"
local logger = require("logger")
local config = require("gameConfig")
local TAG = "audio"
local sfx = {}

sfx.CHANNEL_BG = 1
sfx.CHANNEL_UI = 2
sfx.CHANNEL_CH1_LASER = 3

sfx.bg = {
  handle = audio.loadSound( "sounds/Juhani Junkala [Retro Game Music Pack] Level 1.mp3" ),
  channel = sfx.CHANNEL_BG
}

sfx.playerDead = {
  handle = audio.loadSound("sounds/sfx_exp_odd3.mp3")
}

sfx.scoreUp = {
  handle = audio.loadSound( "sounds/sfx_coin_single1.mp3" )
}

sfx.bgBoss = {
  handle = audio.loadSound( "sounds/Juhani Junkala [Retro Game Music Pack] Level 2.mp3" ),
  channel = sfx.CHANNEL_BG
}

sfx.bash ={
  handle = audio.loadSound( "sounds/sfx_sounds_falling6.mp3" ),
}

sfx.title = {
  handle = audio.loadSound( "sounds/Juhani Junkala [Retro Game Music Pack] Title Screen.mp3"),
  channel = sfx.CHANNEL_BG
}

sfx.button = {
  handle = audio.loadSound("sounds/sfx_sounds_button7.mp3"),
  channel = sfx.CHANNEL_UI
}

sfx.shot = {
  handle = audio.loadSound("sounds/sfx_weapon_singleshot9.mp3"),
}

sfx.laser = {
  handle = audio.loadSound("sounds/sfx_wpn_laser2.mp3"),
  --channel = sfx.CHANNEL_CH1_LASER
}

sfx.hurt = {
  handle = audio.loadSound("sounds/sfx_sounds_impact1.mp3"),
}

sfx.explosion = {
  handle = audio.loadSound("sounds/sfx_exp_short_hard11.mp3"),
}

sfx.scream = {
  handle = audio.loadSound("sounds/sfx_deathscream_human9.mp3"),
}

sfx.start = {
  handle = audio.loadSound("sounds/sfx_sounds_pause7_in.mp3"),
  channel = sfx.CHANNEL_UI
}

sfx.split = {
  handle = audio.loadSound("sounds/sfx_sound_nagger2.mp3"),
}


sfx.warning = {
  handle = audio.loadSound("sounds/sfx_alarm_loop3.mp3"),
  --channel = sfx.CHANNEL_BG
}

sfx.surround = {
  handle = audio.loadSound("sounds/sfx_sound_depressurizing.mp3"),
}

sfx.seek = {
  handle = audio.loadSound("sounds/sfx_wpn_missilelaunch.mp3"),
}

sfx.fallingLaser = {
  handle = audio.loadSound("sounds/sfx_sounds_falling11.mp3"),
}

sfx.burst = {
  handle = audio.loadSound("sounds/sfx_sounds_impact9.mp3"), 
}

sfx.explosion2 = {
  handle = audio.loadSound("sounds/sfx_exp_short_soft9.mp3"), 
}

sfx.click = {
  handle = audio.loadSound("sounds/click.mp3"),  
}

function sfx:initVolumn()
  --local masterVolume = audio.getVolume()  
  --print( "volume "..masterVolume )
  audio.setVolume( 0.7, { channel = self.CHANNEL_BG } )  --music track
  audio.setVolume( 0.8, { channel = self.CHANNEL_UI } )  --ui
  audio.setVolume( 0.8, { channel = self.CHANNEL_CH1_LASER } )
  --audio.setVolume( 0.8,  { channel = 3 } )  --Lesser
end

function sfx:init()
  audio.reserveChannels(3)
  self:initVolumn()
end

function sfx:play(name, options)
    if not config.soundOn then
      return
    end
    self:initVolumn()

    if not options then
      options = {}
    end

    local reservedChannel = self[name].channel

    if reservedChannel and reservedChannel ~= 0 then
      audio.stop(reservedChannel)
      options.channel = reservedChannel
    else
      local availableChannel = audio.findFreeChannel( 4 )
      audio.setVolume( 1, { channel=availableChannel } )
      options.channel = availableChannel
    end

    local currentVolumn = audio.getVolume( { channel = options.channel } )

    --logger:debug(TAG, "Play sound %s at channel %d with volume %d", name, options.channel, currentVolumn)


    return audio.play(self[name].handle, options)
    
end

function sfx:fadeOut(channel, time)
  audio.fadeOut(channel, time)
end

function sfx:pause(channel)
    audio.pause(channel)
end

function sfx:stop(channel)
    if not channel then
      audio.stop()
    else
      audio.stop(channel)
    end
end

function sfx:pause(channel)
  audio.pause(channel)
end

function sfx:resume(channel)
  audio.resume(channel)
end

sfx:init()

return sfx