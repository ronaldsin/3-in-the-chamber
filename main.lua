--[[
	Written by code monkies
]]

-- initialize game
function love.load()
	sizeScale = 1

	hitboxScale = 8

	displayHitbox = false

	-- loading in other files
	require ("player")
	require ("bullet")
	require ("hitReg")
	require ("sound")

	hit = false
	counter = 0
	hitTimer = 0.15

	background = love.graphics.newImage("bg.png")

	-- setting crosshair cursor
	setCursor("Crosshair.png")

	-- create player obj
	p = Player()
	e = Player()
	e.name = "not lmao"
	-- set enemy start temp
	e.x = 500
	e.y = 500--
	-- create sound object

	-- initialize bullet array
	bullets = {}
end

function love.update(dt)
	-- update data for player
	p.update(dt)
	e.update(dt)

	if hit then
		if counter > hitTimer then
			setCursor("Crosshair.png")
			hit = false
		else
			counter = counter + dt
		end
	else
		counter = 0
	end

	-- update data for every bullet
	for i, v in ipairs(bullets) do
		v.update(dt)

		-- remove bullet from array if out of range
		if v.traveled >= v.range then
			table.remove(bullets, i)
		end

	end
end

-- draw elements onto screen
function love.draw()
	love.graphics.draw(background, 0, 0, 0, 0.9, 0.9)

	-- draw bullets to screen
	for i, v in ipairs(bullets) do
		v.draw()
	end

	-- draw player
	e.draw()
	p.draw()
end

-- press mouse 1 to shoot
function love.mousepressed(x, y, button, isTouch)
	if button == 1 then
		gunshot:play()
		b = proj(p.x, p.y, p.rotation, "lmao")
		table.insert(bullets, b)
	end
end

-- changes cursor to specified image 'file'
function setCursor(file)
	Image = love.graphics.newImage(file)
	cursor = love.mouse.newCursor(file, Image:getWidth() / 2, Image:getHeight() / 2)
	love.mouse.setCursor(cursor)
end
