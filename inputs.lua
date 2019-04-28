
function keyboardDown(dt)
	-- player wasd movement

	p.moving = false
	if(p.moveControl <= 0) then

		if love.keyboard.isDown(input_player_down) then
			if not (checkWallCollisionBottom(p.hitbox, p.speed * dt)) then
				p.y = p.y + p.speed * dt
				p.moving = true

			else
				love.audio.play(oof)
			end
		end
		if love.keyboard.isDown(input_player_right) then
			if not (checkWallCollisionRight(p.hitbox, p.speed * dt)) then
				p.x = p.x + p.speed * dt
				p.moving = true
			else
				love.audio.play(oof)
			end
		end

		if love.keyboard.isDown(input_player_up) then
			if not (checkWallCollisionTop(p.hitbox, p.speed * dt)) then
				p.y = p.y - p.speed * dt
				p.moving = true
			else
				love.audio.play(oof)
			end
		end
		if love.keyboard.isDown(input_player_left) then
			if not (checkWallCollisionLeft(p.hitbox, p.speed * dt)) then
				p.x = p.x - p.speed * dt
				p.moving = true
			else
				love.audio.play(oof)
			end
		end

		p.update(dt)

	else
		--force movement

		if p.xLock > 0 then
			if not (checkWallCollisionLeft(p.hitbox, 2 * p.speed * dt)) then
				p.x = p.x - 2 * p.speed * dt * p.xLock --HARDCODED 2, speedboost
				p.moving = true
			end
		else
			if not (checkWallCollisionRight(p.hitbox, 2 * p.speed * dt)) then
				p.x = p.x - 2 * p.speed * dt * p.xLock --HARDCODED 2, speedboost
				p.moving = true
			end
		end

		if p.yLock > 0 then
			if not (checkWallCollisionTop(p.hitbox, 2 * p.speed * dt)) then
				p.y = p.y - 2 * p.speed * dt * p.yLock --HARDCODED 2, speedboost
				p.moving = true
			end
		else
			if not (checkWallCollisionBottom(p.hitbox, 2 * p.speed * dt)) then
				p.y = p.y - 2 * p.speed * dt * p.yLock --HARDCODED 2, speedboost
				p.moving = true
			end
		end

		p.weapon.update(p.x, p.y, p.rotation, dt)
	end

	if love.mouse.isDown(input_player_shoot, dt) then

		if p.weapon.name == "Strikeout" and p.weapon.spoolUpCounter <= 2 then --cd 0.38/s   spread 160/s
			p.weapon.spoolUpCounter = p.weapon.spoolUpCounter + dt / 2
			p.weapon.gunCd = p.weapon.ogGunCd - (p.weapon.spoolUpCounter * 0.05)
			print(p.weapon.spoolUpCounter)
		end

		if cd >= p.weapon.gunCd and p.shoot <= 0 and p.weapon.counter <= 0 then
			if p.weapon.mode == 2 then
				local crit = 0
				if p.weapon.name == "Frontliner" then
					local critChance = rng:random(0, 100)

					if critChance <= 20 then
						crit = 0.5 * p.weapon.damage
						print("crit")
					end
				end

				fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range, math.abs(p.weapon.rng - (p.weapon.spoolUpCounter * 45)), p.weapon.length, p.weapon.damage + crit, p.weapon.name)
				crit = 0
				cd = 0
			end
		end

	end
end

function love.mousereleased(x, y, button)
	if button == input_player_shoot then
		p.weapon.spoolUpCounter = 0
		p.weapon.gunCd = p.weapon.ogGunCd
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
		print("X: " .. camera.getMouseX())
		print("Y: " .. camera.getMouseY())
		pause = not pause
	end

	if key == input_player_abilitySwap then
		-- if p.ability == "roll" then
		-- 	p.ability = "bulletTime"
		-- else
		-- 	p.ability = "roll"
		-- end

		if p.abilityNumber < #p.abilities then
			p.abilityNumber = p.abilityNumber + 1
		else
			p.abilityNumber = 1

		end

		p.ability = p.abilities[p.abilityNumber]
	end

	if key == input_debug_resetHealth then
		e.health = 100
	end

	if key == input_game_quit then
		love.event.quit(0)
	end

	if key == input_player_reload then
		if p.weapon.currentAmmo < p.weapon.magazine then
			if p.weapon.counter <= 0 then
				p.weapon.counter = p.weapon.reload
				for i = 1, 2 do
					playSound(reloadingStart)
				end
			end
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
					p.weapon.update(gunPickUp[i].x, gunPickUp[i].y)

					p.weapon.pickedUp = false
					p.weapon.name = name2
					p.weapon.refreshImage()
					p.weapon.counter = 0

					gunPickUp[i].pickedUp = true
					gunPickUp[i].name = name1
					gunPickUp[i].refreshImage()
					gunPickUp[i].counter = 0

					local temp = gunPickUp[i]
					gunPickUp[i] = p.weapon
					gunPickUp[i].r = 0
					p.weapon = temp

					p.updateStance()
				end
			end
		end
		if hitReg(chests.hitbox, p.hitbox) then
			if chests.opened == false then
				chests.open()
			end
		end
	end
end


-- press mouse 1 to shoot
function love.mousepressed(x, y, button, isTouch, dt)
	if not pause then
		if cd > p.weapon.gunCd and p.shoot <= 0 and p.weapon.counter <= 0 then
			if button == input_player_shoot then
				if p.weapon.mode == 1 then
					fire(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range, p.weapon.rng, p.weapon.length, p.weapon.damage, p.weapon.name)
					--fire(e.x, e.y, e.rotation, e.name, e.weapon.speed, p.weapon.range)
					cd = 0
				end
			end
		end
		if button == input_player_secondary and p.abilityCD <= 0 then
			ability(p, dt)
		end
	end

	if gameState == "menu" then
		gameState = "game"
		love.graphics.setNewFont(40)
	end
end
