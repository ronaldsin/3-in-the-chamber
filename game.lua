function gameUpdate(dt)
	if not pause then

		if fire_ani <= fireTimer then
			p.weapon.image.update(dt)
			--e.weapon.image.update(dt)
		else
			p.weapon.image.idle()
			--e.weapon.image.idle()
		end

		for i = 1, #gunPickUp do
			gunPickUp[i].update(30 + (i - 1) * 150, 200, 0)
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

			-- remove bullet from array if out of range
			if v.traveled >= v.range then
				table.remove(bullets, i)
			end

		end
	end
end

function gameDraw()
	love.graphics.draw(background, 0, 0, 0, 0.9, 0.9)

	for i = 1, #walls do
		walls[i].hitbox.draw()
	end

	-- draw bullets to screen
	for i = 1, #bullets do
		bullets[i].draw()
	end

	for i = 1, #gunPickUp do
		gunPickUp[i].draw()
	end

	-- draw player
	e.draw()
	p.draw()


	if pause then
		love.graphics.print("Game is paused", 350, 280)
	end
end
