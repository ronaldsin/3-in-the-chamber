function Monster(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local monster = {}

	monster.name = name

	-- sprites
	monster.idle = createAnimation("MarineIdle", 4, 3, 2, 2, 1, 256, 256)
	monster.legs = createAnimation("MarineLegs", 14, 20, 4, 4, 1, 256, 256)

	--monster.weapon = createWeapon("Pathfinder", 10, 0.33, 2000, 500, 6, true, 1, 1, 0)

	-- x and y coord's
	monster.x = 1906
	monster.y = 1854
	monster.width = monster.idle.frame_width
	monster.height = monster.idle.frame_height

	monster.hitbox = createHitbox(monster.x, monster.y, monster.width, monster.height)

	-- stats
	monster.speed = 250
	monster.health = 100
	monster.maxHealth = 100
	monster.power = 100
	monster.armor = 0

	monster.lost = true

	-- the rotation of the sprite in radians
	monster.rotation = 0

	monster.moving = false
	monster.movingTimer = 0.1
	monster.movingCounter = 0

	monster.patience = 0.5
	monster.patienceCounter = 0

	monster.bleedCounter = 3
	monster.bleed = false
	monster.bleedDmg = 0
	monster.timer = 0

	-- movement and shooting
	function monster.update(dt)

		dot(dt)

		ai(monster, dt)

		monster.patienceCounter = monster.patienceCounter + dt
		monster.movingCounter = monster.movingCounter + dt

		monster.hitbox.update(monster.x, monster.y)

		--monster.weapon.update(monster.x, monster.y, monster.rotation)
		if monster.moving then
			monster.legs.update(dt)

		else
			monster.legs.idle()
		end

		monster.idle.update(dt)

		monster.hitReg(dt)

		-- update rotation
		monster.rotate()

	end


	function monster.hitReg(dt)

		-- bullet hit reg (does not work rn)
		for i, v in ipairs(bullets) do
			local extraDmg = 0
			if hitReg(monster.hitbox, v.hitbox) then
				if not(monster.name == v.name) then
					if v.weaponName == "Pride" and monster.health >= monster.maxHealth * 0.75 then
						extraDmg = v.dmg * 0.2
						print("Prejudice")
					end

					if v.weaponName == "Hackslasher" then
						monster.bleedCounter = 0
						monster.bleed = true
						monster.bleedDmg = v.dmg * 0.45
					end

					monster.takeDmg(v.dmg + extraDmg)
					extraDmg = 0
					setCursor("resources/Hitmarker.png")
					hit = true
					table.remove(bullets, i)
				end
			end
		end

	end


	function dot(dt)

		if monster.bleedCounter < 3 and monster.timer > 1 then
			monster.timer = 0
			monster.bleedCounter = monster.bleedCounter + 1
			print("bleed")
			monster.takeDmg(monster.bleedDmg)
		end

		if monster.bleedTimer == 3 then
			monster.bleed = false
		end

		if monster.timer > 1 then
			monster.timer = 0
		end

		if monster.bleed then
			monster.timer = monster.timer + dt
		end

	end


	function monster.takeDmg(dmg)

		monster.health = monster.health - dmg
		print("Health:" .. monster.health)
		playSound(oof)

	end


	function monster.goToNode(index, dt)

		if monster.movingCounter > monster.movingTimer then
			monster.moving = false
		end

		if checkWallCollision(monster.hitbox) then
			monster.lost = true
			monster.movingCounter = -3
			monster.x = monster.lx
			monster.y = monster.ly

		else
			monster.lx = monster.x
			monster.ly = monster.y
		end

		if monster.movingCounter < 0 then
			monster.speed = - monster.speed

		else
			monster.speed = math.abs(monster.speed )
		end

		if distanceF(monster.x, monster.y, pathNodes[index].x, pathNodes[index].y) > 20 then
			if distanceF(monster.x, 0, pathNodes[index].x, 0) > 5 then
				if pathNodes[index].x > monster.x then
					if not (checkWallCollisionRight(monster.hitbox, monster.speed * dt)) then
						monster.x = monster.x + monster.speed * dt
						monster.moving = true
					end

				elseif pathNodes[index].x < monster.x then
					if not (checkWallCollisionLeft(monster.hitbox, monster.speed * dt)) then
						monster.x = monster.x - monster.speed * dt
						monster.moving = true
					end
				end

			end

			if distanceF(0, monster.y, 0, pathNodes[index].y) > 5 then
				if pathNodes[index].y > monster.y then
					if not (checkWallCollisionBottom(monster.hitbox, monster.speed * dt)) then
						monster.y = monster.y + monster.speed * dt
						monster.moving = true
					end

				elseif pathNodes[index].y < monster.y then
					if not (checkWallCollisionTop(monster.hitbox, monster.speed * dt)) then
						monster.y = monster.y - monster.speed * dt
						monster.moving = true
					end
				end

			end

			if monster.movingTimer >= 0 then
				monster.movingCounter = 0
			end

			return true

		else
			if p.x > monster.x then
				monster.x = monster.x + monster.speed * dt
				monster.moving = true

			elseif p.x < monster.x then
				monster.x = monster.x - monster.speed * dt
				monster.moving = true
			end

			if p.y > monster.y then
				monster.y = monster.y + monster.speed * dt
				monster.moving = true

			elseif p.y < monster.y then
				monster.y = monster.y - monster.speed * dt
				monster.moving = true
			end

			return false
		end

	end


	-- drawing to screen
	function monster.draw()

		if monster.health <= 0 then
			love.graphics.setColor(1, 0, 0)
		end

		monster.legs.draw(monster.x, monster.y, monster.rotation)
		monster.idle.draw(monster.x, monster.y, monster.rotation)
		--monster.weapon.draw(monster.x, monster.y, monster.rotation)

		monster.hitbox.draw()

		--monster.weapon.draw()

		love.graphics.setColor(1, 1, 1 )

	end


	-- rotate monster model to mouse
	function monster.rotate()

		monster.rotation = (math.atan2(love.mouse.getY() - monster.y, love.mouse.getX() - monster.x) + (math.pi / 2))

	end

	return monster

end
