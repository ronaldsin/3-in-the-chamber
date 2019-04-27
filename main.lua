--[[
	Written by code monkies
]]

-- initialize game
function love.load()
	-- loading in other files
	require ("player")
	require ("bullet")
	require ("hitReg")
	require ("sound")
	require ("monster")
	require ("inputs")
	require ("keyBindings")
	require ("animation")
	require ("weapon")
	require ("abilities")
	require ("menu")
	require ("game")
	require ("hitbox")
	require ("walls")
	require ("wallsData")
	require ("camera")
	require ("pathNodes")
	require ("pathNodesData")
	require ("queue")
	require ("ai")
	require ("stack")
	require ("lineIntersection")

	sizeScale = 1 -- default 1

	hitboxConst = 8 -- ratio to sizescale 5 sizeScale = 5 time smaller size
	hitboxScale = hitboxConst / sizeScale -- based on sizeScale

	density = 50

	displayHitbox = false

	start()

	gameState = "menu"

	loadNodes()
	connectNodes()

end

function love.update(dt)
	if gameState == "menu" then
		menuUpdate(dt)
	elseif gameState == "game" then
		timeMod = 1
		if p.slowTime == true then
			timeMod = 0.5
		end

		camera.update(dt * timeMod)
		gameUpdate(dt * timeMod)
	end
end

-- draw elements onto screen
function love.draw()
	if gameState == "menu" then
		menuDraw()
	elseif gameState == "game" then
		camera.draw()
		gameDraw()
	end
end

-- changes cursor to specified image 'file'
function setCursor(file)
	Image = love.graphics.newImage(file)
	cursor = love.mouse.newCursor(file, Image:getWidth() / 2, Image:getHeight() / 2)
	love.mouse.setCursor(cursor)
end

function fire(x, y, r, n, speed, range, spread, length)
	if p.weapon.name == "BoomstickVI" then
		if p.weapon.fire() then
			fire_ani = 0
			playSound(shotgun)

			for i = 1, 7 do
				--b = proj(x + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 10), y + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 10), r + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 800), n, speed, range, "ShotgunShell", , spread)
				b = proj(x, y, r, n, speed, range, "ShotgunShell", spread, length)
				--bulletTime ability
				if(p.bulletTime == true) then
					b.speed = 0
					b.xVel = 0
					b.yVel = 0
				end
				table.insert(bullets, b)

			end
		end
	else

		if p.weapon.fire() then
			fire_ani = 0

			if p.weapon.name == "Strikeout" then
				b = proj(x, y, r, n, speed, range, "AssaultRifleBullet", spread, length)
				playSound(machineGun)
			elseif p.weapon.name == "Frontliner" or p.weapon.name == "MuscleSpasm" then
				b = proj(x, y, r, n, speed, range, "AssaultRifleBullet", spread, length)
				playSound(assaultRifle)

			elseif p.weapon.name == "TheBeartrap" or p.weapon.name == "BountyHunter" or p.weapon.name == "Pride" then
				b = proj(x, y, r, n, speed, range, "SniperRifleBullet", spread, length)
				playSound(sniperRifle)
			else
				b = proj(x, y, r, n, speed, range, "PistolBullet", spread, length)
				playSound(gunshot)
			end
			if(p.bulletTime == true) then
				b.speed = 0
				b.xVel = 0
				b.yVel = 0
			end
			table.insert(bullets, b)
		end
	end
end
