gunshot = love.audio.newSource("resources/Pew.wav", "static")
gunshot:setVolume(0.3)

oof = love.audio.newSource("resources/Oof1.wav", "static")
oof:setVolume(0.2)

function playSound(source)

	local clone = source:clone()
	clone:play()

end
