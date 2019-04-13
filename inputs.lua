
function keyboardDown(dt)
	-- player wasd movement

	if checkWallCollision() then
		p.x = p.lx
		p.y = p.ly
	else
		p.lx = p.x
		p.ly = p.y
	end

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

		p.update(dt)

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

	if love.mouse.isDown(input_player_shoot) then
		if cd >= p.weapon.gunCd and p.shoot <= 0 and p.weapon.counter <= 0 then
			if p.weapon.mode == 2 then
				-- local spread = ((rng:random((p.weapon.rng) * (- 1), (p.weapon.rng))) / 1000)
				-- constant = 10
				-- print(p.x - spread * constant * math.cos(spread))
				-- print(p.y + spread * constant * math.sin(spread))
				-- fire(p.x + spread * constant * math.tan(spread), p.y - spread * constant * math.tan(spread), p.rotation + spread, p.name, p.weapon.speed, p.weapon.range)
				fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range, p.weapon.rng, p.weapon.length)
				--fire(e.x, e.y, e.rotation + ((rng:random((p.weapon.rng) * (- 1), (p.weapon.rng))) / 1000), e.name, 2000, 500)
				cd = 0
			end
		end
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

	if key == input_player_abilitySwap then
		if p.ability == "roll" then
			p.ability = "bulletTime"
		else
			p.ability = "roll"
		end

	end

	if key == input_debug_resetHealth then
		e.health = 100
	end

	if key == input_game_quit then
		love.event.quit(0)
	end

	if key == input_player_reload then
		p.weapon.counter = p.weapon.reload
		for i = 1, 2 do
			playSound(reloadingStart)
		end
	end

	if key == input_player_interact then
		-- probably gonna have an array("table") of dropped items later in the future(tm to not break encoding)
		for i = 1, #gunPickUp do
			if hitReg(gunPickUp[i].hitbox, p.hitbox) then
				if not(gunPickUp[i].pickedUp) then
					-- name1 is the ground weapon name with Icon removed from it's name
					-- name2 is player weapon name but Icon concatenated
					-- temp1 is a new weapon with name1 and the equivalent stats of the ground item
					-- temp2 is the same as temp1 but for playear weapon
					local name1 = string.sub(gunPickUp[i].name, 1, - 5)
					local name2 = p.weapon.name .. "Icon"
					--local temp1 = createWeapon(name1, gunPickUp[i].damage, gunPickUp[i].gunCd, gunPickUp[i].speed, gunPickUp[i].range, gunPickUp[i].magazine, gunPickUp[i].currentAmmo, gunPickUp[i].reload, true, gunPickUp[i].mode, gunPickUp[i].stance, gunPickUp[i].rng)
					--local temp2 = createWeapon(name2, p.weapon.damage, p.weapon.gunCd, p.weapon.speed, p.weapon.range, p.weapon.magazine, p.weapon.currentAmmo, p.weapon.reload, false, p.weapon.mode, p.weapon.stance, p.weapon.rng)
					p.weapon.pickedUp = false
					p.weapon.name = name2
					p.weapon.refreshImage()
					p.weapon.counter = 0

					gunPickUp[i].pickedUp = true
					gunPickUp[i].name = name1
					gunPickUp[i].refreshImage()
					gunPickUp[i].counter = 0w

					local temp = gunPickUp[i]
					gunPickUp[i] = p.weapon
					p.weapon = temp

					p.updateStance()
				end
			end
		end
	end
end


-- press mouse 1 to shoot
function love.mousepressed(x, y, button, isTouch)
	if not pause then
		if cd > p.weapon.gunCd and p.shoot <= 0 and p.weapon.counter <= 0 then
			if button == input_player_shoot then
				if p.weapon.mode == 1 then
					fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range, p.weapon.rng, p.weapon.length)
					--fire(e.x, e.y, e.rotation, e.name, e.weapon.speed, p.weapon.range)
					cd = 0
				end
			end
		end
		if button == input_player_secondary and p.abilityCD <= 0 then
			ability(p)
		end
	end

	if gameState == "menu" then
		gameState = "game"
		love.graphics.setNewFont(40)
	end
end
