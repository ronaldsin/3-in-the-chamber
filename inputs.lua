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

	-- monster movement
	e.moving = false
	if love.keyboard.isDown(input_monster_down) then
		e.y = e.y + e.speed * dt
		e.moving = true
	end

	if love.keyboard.isDown(input_monster_right) then
		e.x = e.x + e.speed * dt
		e.moving = true
	end

	if love.keyboard.isDown(input_monster_up) then
		e.y = e.y - e.speed * dt
		e.moving = true
	end

	if love.keyboard.isDown(input_monster_left) then
		e.x = e.x - e.speed * dt
		e.moving = true
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
		-- probably gonna have an array("table") of dropped items later in the future(tm to not break encoding)
		if not(g.pickedUp) then
			if hitReg(g.left, g.right, g.top, g.bottom, p.x - p.width / hitboxScale, p.x + p.width / hitboxScale, p.y - p.height / hitboxScale, p.y + p.height / hitboxScale ) then
				-- name1 is the ground weapon name with Icon removed from it's name
				-- name2 is player weapon name but Icon concatenated
				-- temp1 is a new weapon with name1 and the equivalent stats of the ground item
				-- temp2 is the same as temp1 but for playear weapon
				print(g.name .. " " .. p.weapon.name)
				local name1 = string.sub(g.name, 1, - 5)
				local name2 = p.weapon.name .. "Icon"
				local temp1 = createWeapon(name1, g.damage, g.gunCd, g.speed, g.range, g.magazine, true)
				local temp2 = createWeapon(name2, p.weapon.damage, p.weapon.gunCd, p.weapon.speed, p.weapon.range, p.weapon.magazine, false)
				g = temp2
				p.weapon = temp1
			end
		end
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
