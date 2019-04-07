gunshot = love.audio.newSource("resources/Pew.wav", "static")
gunshot:setVolume(0.3)
gunshot:setPitch(1)

oof = love.audio.newSource("resources/Oof1.wav", "static")
oof:setVolume(0.3)
oof:setPitch(1)

function playSound(source)

	local clone = source:clone()
	clone:play()

end
