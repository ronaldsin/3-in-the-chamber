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
	require("chest")
	require ("burst")

	sizeScale = 1 -- default 1

	hitboxConst = 8 -- ratio to sizescale 5 sizeScale = 5 time smaller size
	hitboxScale = hitboxConst / sizeScale -- based on sizeScale

	density = 100

	displayHitbox = false

	displayNodes = false

	weapons = {}
	table.insert(weapons, createWeapon("PathfinderIcon", 40, 0.33, 450, 400, 6, 6, 2, false, 1, 1, 30, 100))
	table.insert(weapons, createWeapon("FrontlinerIcon", 25, 0.14, 450, 500, 30, 30, 1.75, false, 2, 2, 40, 140)) -- 171dps
	table.insert(weapons, createWeapon("PrideIcon", 60, 0.29, 600, 700, 8, 8, 1.9, false, 1, 1, 15, 120)) -- 206.896551724138dps
	table.insert(weapons, createWeapon("AccelerantIcon", 25, 0.1, 550, 200, 20, 20, 1.2, false, 2, 2, 160, 105)) -- 250dps
	table.insert(weapons, createWeapon("BoomstickVIIcon", 6, 0.75, 400, 250, 6, 6, 1, false, 1, 2, 400, 120)) -- 187dps
	table.insert(weapons, createWeapon("StrikeoutIcon", 40, 0.20, 375, 600, 80, 80, 3.3, false, 2, 2, 90, 140)) -- 200dps
	table.insert(weapons, createWeapon("TheBeartrapIcon", 170, 1, 4000, 10000, 5, 5, 2.2, false, 1, 2, 0, 145)) -- 170dps
	--table.insert(weapons, createWeapon("SirenIcon", 17, 0.3, 450, 350, 18, 18, 1.3, false, 3, 1, 35, 90)) -- 56.6666666666667dps
	--table.insert(weapons, createWeapon("LongHaulIcon", 27, 0.5, 390, 650, 100, 100, 4, false, 2, 2, 130, 145)) -- 54dps
	--table.insert(weapons, createWeapon("BacklinerIcon", 45, 0.27, 600, 800, 11, 11, 1.75, false, 1, 2, 25, 145)) -- 166.666666666667dps
	table.insert(weapons, createWeapon("HackslasherIcon", 21, 0.14, 550, 190, 24, 24, 1.5, false, 2, 2, 130, 100)) -- 150.dps
	table.insert(weapons, createWeapon("MuscleSpasmIcon", 16, 0.4, 425, 160, 15, 15, 2.1, false, 2, 2, 550, 100)) -- 40dps
	table.insert(weapons, createWeapon("BountyHunterIcon", 220, 1.35, 1500, 1200, 7, 7, 2.3, false, 1, 2, 0, 145)) -- 162.962962962963dps

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

	if p.clone == true then
		c.draw()
	end

end


-- changes cursor to specified image 'file'
function setCursor(file)

	Image = love.graphics.newImage(file)
	cursor = love.mouse.newCursor(file, Image:getWidth() / 2, Image:getHeight() / 2)
	love.mouse.setCursor(cursor)

end


function fire(x, y, r, n, speed, range, spread, length, dmg, name)

	if p.weapon.name == "BoomstickVI" or p.weapon.name == "MuscleSpasm" then
		if p.weapon.fire() then
			fire_ani = 0
			playSound(shotgun)

			local pellets = 0

			if p.weapon.name == "BoomstickVI" then
				pellets = 7
			end

			if p.weapon.name == "MuscleSpasm" then
				pellets = 6
			end

			for i = 1, pellets do
				--b = proj(x + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 10), y + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 10), r + (rng:random((p.weapon.rng) * (- 1), (p.weapon.rng)) / 800), n, speed, range, "ShotgunShell", , spread)
				b = proj(x, y, r, n, speed, range, "ShotgunShell", spread, length, dmg, name)
				--bulletTime ability
				if(p.bulletTime == true) then
					b.speed = 0
					b.xVel = 0
					b.yVel = 0
				end
				table.insert(bullets, b)

			end

		end

	elseif burstFire then
		if p.weapon.name == "Pathfinder" then

			if burstCounter == 3 and currentBurstCD <= 0 then
				b = proj(x, y, r, n, speed, range, "PistolBullet", spread, length, dmg, name)

				print("3")
				print("CD started")
				table.insert(bullets, b)
				playSound(gunshot)

				burstCounter = burstCounter - 1

				currentBurstCD = ogBurstCD
			end
		end


	elseif p.weapon.fire() then
		fire_ani = 0

		if p.weapon.name == "Strikeout" then
			b = proj(x, y, r, n, speed, range, "AssaultRifleBullet", spread, length, dmg, name)
			playSound(machineGun)

		elseif p.weapon.name == "Frontliner" or p.weapon.name == "MuscleSpasm" then
			b = proj(x, y, r, n, speed, range, "AssaultRifleBullet", spread, length, dmg, name)
			playSound(assaultRifle)

		elseif p.weapon.name == "Pride" then
			b = proj(x, y, r, n, speed, range, "SniperRifleBullet", spread, length, dmg, name)
			playSound(prideShot)

		elseif p.weapon.name == "TheBeartrap" or p.weapon.name == "BountyHunter" then
			b = proj(x, y, r, n, speed, range, "SniperRifleBullet", spread, length, dmg, name)
			playSound(sniperRifle)

		else
			b = proj(x, y, r, n, speed, range, "PistolBullet", spread, length, dmg, name)
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
