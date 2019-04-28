function gameUpdate(dt)
	if not pause then

		if fire_ani <= fireTimer then
			p.weapon.image.update(dt)
			--e.weapon.image.update(dt)
		else
			p.weapon.image.idle()
			--e.weapon.image.idle()
		end


		local counter = 0
		for j = 1, 3 do
			for i = 1, 3 do
				if counter > #gunPickUp then
					break
				end
				counter = counter + 1
				gunPickUp[counter].update(1320 + (i - 1) * 200, 1920 - (j * 200), 0)
			end
		end

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


			if checkWallCollision(v.hitbox) then
				table.remove(bullets, i)

			end

			-- remove bullet from array if out of range
			if v.traveled >= v.range then
				table.remove(bullets, i)
			end

		end
	end
end

function gameDraw()
	love.graphics.draw(background)

	chests.draw()

	for i = 1, #walls do
		walls[i].draw()
	end

	-- draw bullets to screen
	for i = 1, #bullets do
		bullets[i].draw()
	end

	for i = 1, #gunPickUp do
		gunPickUp[i].draw()
	end

	-- nodes and paths
	for i = 1, #pathNodes do
		pathNodes[i].draw()
	end
	drawPaths()

	-- draw player
	e.draw()
	p.draw()

	love.graphics.print("Current ability: " .. p.ability, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 8 * camera.yScale + camera.y))

	love.graphics.print("Current weapon: " .. p.weapon.name, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 5 * camera.yScale + camera.y))
	love.graphics.print("Ammo: " .. p.weapon.currentAmmo .. " / " .. p.weapon.magazine, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 3.5 * camera.yScale + camera.y))

	if pause then
		local font = love.graphics.getFont()
		local width = font:getWidth("Game is paused, press Q to quit")
		love.graphics.print("Game is paused, press Q to quit", (camera.width * camera.xScale + camera.x - width / 2), (camera.height * camera.yScale + camera.y))
	end
end
