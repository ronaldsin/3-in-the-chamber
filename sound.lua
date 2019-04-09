gunshot = love.audio.newSource("resources/Pew.wav", "static")
gunshot:setVolume(1)
gunshot:setPitch(0.9)

oof = love.audio.newSource("resources/Oof1.wav", "static")
oof:setVolume(0.3)
oof:setPitch(1)

shotgun = love.audio.newSource("resources/Shotgun.wav", "static")
shotgun:setVolume(0.6)
shotgun:setPitch(0.9)

machineGun = love.audio.newSource("resources/MachineGun.wav", "static")
machineGun:setVolume(0.3)
machineGun:setPitch(1)

assaultRifle = love.audio.newSource("resources/assaultRifle.wav", "static")
assaultRifle:setVolume(0.3)
assaultRifle:setPitch(1)

sniperRifle = love.audio.newSource("resources/SniperRifle.wav", "static")
sniperRifle:setVolume(1)
sniperRifle:setPitch(1)

reloadingStart = love.audio.newSource("resources/ReloadStart.wav", "static")
reloadingStart:setVolume(1)
reloadingStart:setPitch(1)

reloadingEnd = love.audio.newSource("resources/ReloadEnd.wav", "static")
reloadingEnd:setVolume(1)
reloadingEnd:setPitch(1)

function playSound(source)
	local clone = source:clone()
	clone:play()
end
