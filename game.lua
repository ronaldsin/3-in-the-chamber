function gameUpdate(dt)

	if not pause then

		if p.weapon.name == "Pathfinder" then
			burstFire = true
		else
			burstFire = false
		end

		if p.clone == true then
			c.weapon.currentAmmo = c.weapon.magazine

			c.update(dt)
			clone_counter = clone_counter + dt


			if clone_counter >= 100 then
				p.clone = false
				c.shoot = 1
				clone_counter = 0
			end
		end

		if p.shield then
			for i, v in ipairs(bullets) do
				if(v.name == c.name) then
					local r = (math.atan2(v.y - p.y, v.x - p.x) + (math.pi / 2))

					if distanceF(p.x, p.y, v.x, v.y) <= 200 then

						if r < p.rotation + (math.pi / 4) and r > p.rotation - (math.pi / 4) then

							table.remove(bullets, i)
						end
					end
				end
			end
		end

		if fire_ani <= fireTimer then
			--e.weapon.image.update(dt)
			p.weapon.image.update(dt)
		else
			--e.weapon.image.idle()
			p.weapon.image.idle()
		end

		local counter = 0

		for j = 1, 3 do
			for i = 1, 3 do
				if counter > #gunPickUp then
					break
				end
				counter = counter + 1
				gunPickUp[counter].update(2752.96 + (i - 1) * 300, 350.12 + (j * 200), 0)
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

		currentBurstCD = currentBurstCD - dt

		if burstCounter < 3 then
			if p.weapon.currentAmmo > 0 then
				burstUpdate()
			else
				burstCounter = 3
			end
		end

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

	if p.shield then

		local sX = p.x + (200) * math.sin(p.rotation + (math.pi / 4))
		local sY = p.y - (200) * math.cos(p.rotation + (math.pi / 4))
		love.graphics.line(p.x, p.y, sX, sY)

		local sX2 = p.x + (200) * math.sin(p.rotation - (math.pi / 4))
		local sY2 = p.y - (200) * math.cos(p.rotation - (math.pi / 4))
		love.graphics.line(p.x, p.y, sX2, sY2)

		love.graphics.line(sX, sY, sX2, sY2)
	end

	love.graphics.print("Current ability: " .. p.ability, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 8 * camera.yScale + camera.y))

	love.graphics.print("Current weapon: " .. p.weapon.name, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 5 * camera.yScale + camera.y))
	love.graphics.print("Ammo: " .. p.weapon.currentAmmo .. " / " .. p.weapon.magazine, (camera.width / 20 * camera.xScale + camera.x), (camera.height / 3.5 * camera.yScale + camera.y))

	if pause then
		local font = love.graphics.getFont()
		local width = font:getWidth("Game is paused, press Q to quit")
		love.graphics.print("Game is paused, press Q to quit", (camera.width * camera.xScale + camera.x - width / 2), (camera.height * camera.yScale + camera.y))
	end

end
