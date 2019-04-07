--[[
	Written by code monkies
]]

-- initialize game
function love.load()
	sizeScale = 1 -- default 1

	hitboxConst = 10 -- i dont know
	hitboxScale = hitboxConst / sizeScale -- based on sizeScale

	displayHitbox = false

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

	-- create player obj
	p = Player("lmao")
	e = Monster("not lmao")

	g = createWeapon("Pathfinder", 10, 0.33, 2000, 500, 6, false)
	-- set enemy start temp
	e.x = 500
	e.y = 500

	-- initialize bullet array
	bullets = {}

	--timers
	--hitmarker timer
	hit = false
	counter = 0
	hitTimer = 0.15

	--fire timer
	fireTimer = 0.2
	fire_ani = fireTimer

	--gun cd timer
	cd = p.weapon.gunCd

	--pause
	pause = false

	background = love.graphics.newImage("resources/bg.png")

	-- setting crosshair cursor
	setCursor("resources/Crosshair.png")

end

function love.update(dt)
	if not pause then

		if fire_ani <= fireTimer then
			p.weapon.image.update(dt)
			e.weapon.image.update(dt)
		else
			p.weapon.image.idle()
			e.weapon.image.idle()
		end

		g.update(dt)

		-- update data for player
		p.update(dt)
		e.update(dt)

		keyboardDown(dt)

		if hit then
			if counter > hitTimer then
				setCursor("resources/Crosshair.png")
				hit = false
			else
				counter = counter + dt
			end
		else
			counter = 0
		end

		fire_ani = fire_ani + dt

		cd = cd + dt

		-- update data for every bullet
		for i, v in ipairs(bullets) do
			v.update(dt)

			-- remove bullet from array if out of range
			if v.traveled >= v.range then
				table.remove(bullets, i)
			end

		end
	end
end

-- draw elements onto screen
function love.draw()


	love.graphics.draw(background, 0, 0, 0, 0.9, 0.9)

	if fire_ani <= fireTimer then
		p.weapon.image.draw(p.x, p.y, p.rotation)
		p.weapon.image.draw(e.x, e.y, e.rotation)
	end

	-- draw bullets to screen
	for i = 1, #bullets do
		bullets[i].draw()
	end

	g.draw(50, 50, 0)

	-- draw player
	e.draw()
	p.draw()


	if pause then
		love.graphics.print("Game is paused", 350, 280)
	end


end

-- changes cursor to specified image 'file'
function setCursor(file)
	Image = love.graphics.newImage(file)
	cursor = love.mouse.newCursor(file, Image:getWidth() / 2, Image:getHeight() / 2)
	love.mouse.setCursor(cursor)
end

function fire(x, y, r, n, speed, range)
	fire_ani = 0
	playSound(gunshot)
	b = proj(x, y, r, n, speed, range)
	table.insert(bullets, b)
end
