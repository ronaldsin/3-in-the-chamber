function keyboardDown(dt)
	-- player wasd movement
	p.moving = false
	if love.keyboard.isDown(input_player_down) then
		p.y = p.y + p.speed * dt
		p.moving = true
	end

	if love.keyboard.isDown(input_player_right) then
		p.x = p.x + p.speed * dt
		p.moving = true
	end

	if love.keyboard.isDown(input_player_up) then
		p.y = p.y - p.speed * dt
		p.moving = true
	end

	if love.keyboard.isDown(input_player_left) then
		p.x = p.x - p.speed * dt
		p.moving = true
	end


	-- wasd movement
	if love.keyboard.isDown(input_monster_down) then
		e.y = e.y + e.speed * dt
	end

	if love.keyboard.isDown(input_monster_right) then
		e.x = e.x + e.speed * dt
	end

	if love.keyboard.isDown(input_monster_up) then
		e.y = e.y - e.speed * dt
	end

	if love.keyboard.isDown(input_monster_left) then
		e.x = e.x - e.speed * dt
	end
end

function love.keypressed(key)
	if key == input_debug_toggleHitbox then
		displayHitbox = not(displayHitbox)
	end

	if key == input_debug_sizeScaleUp then
		sizeScale = sizeScale + 0.2
		hitboxScale = hitboxConst / sizeScale
	end

	if key == input_debug_sizeScaleDown then
		sizeScale = sizeScale - 0.2
		hitboxScale = hitboxConst / sizeScale
	end

	if key == input_game_pause then
		pause = not pause
	end

	if key == input_player_interact then
		-- check hitbox around Player
		-- interact depending on the hitbox
		-- ie npc -> talk for shop or something
		-- gun to change weapon
		-- interact w/ environment like doors
	end

end

-- press mouse 1 to shoot
function love.mousepressed(x, y, button, isTouch)
	if not pause then
		if cd > p.weapon.gunCd then
			if button == input_player_shoot then
				fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range)
				fire(e.x, e.y, e.rotation, e.name, 2000, 500)
				cd = 0
			end
		end
	end
end
