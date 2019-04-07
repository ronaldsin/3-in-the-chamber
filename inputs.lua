function keyboardDown(dt)
	-- player wasd movement
	p.moving = false
	if(p.moveControl <= 0) then
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
	else
		--force movement
		p.x = p.x - 2 * p.speed * dt * p.xLock --HARDCODED 2, speedboost
		p.y = p.y - 2 * p.speed * dt * p.yLock
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


		-- possible solution: get the hitbox of all items in a "table" and check if they're in the player's hitbox
		-- need to find a way to get all hitboxes..... maybe store them in an array when they're initialized?
		-- keep measuring distance


		--[[if hitReg(
			p.x - p.width / (hitboxScale * 2),
			p.x + p.width / (hitboxScale * 2),
			p.y - p.height / (hitboxScale * 2),
			p.y + p.height / (hitboxScale * 2),
			asdf.weapon.x - asdf.weapon.width / (hitboxScale * 2),
			asdf.weapon.x + asdf.weapon.width / (hitboxScale * 2),
			asdf.weapon.y - asdf.weapon.height / (hitboxScale * 2),
		asdf.weapon.y + asdf.weapon.height / (hitboxScale * 2)) then
			p.swapWep()

		end
		]]
	end
end


-- press mouse 1 to shoot
function love.mousepressed(x, y, button, isTouch)
	if not pause then
		if cd > p.weapon.gunCd and p.shoot <= 0 then
			if button == input_player_shoot then
				fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range)
				fire(e.x, e.y, e.rotation, e.name, 2000, 500)
				cd = 0
			end
		end
		if button == input_player_secondary and p.abilityCD <= 0 then
			ability(p)
		end
	end
end
