function Monster(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local monster = {}

	monster.name = name

	-- sprites
	monster.idle = createAnimation("MarineIdle", 4, 3, 2, 2, 1, 256, 256)
	monster.legs = createAnimation("MarineLegs", 14, 30, 4, 4, 1, 256, 256)

	--monster.weapon = createWeapon("Pathfinder", 10, 0.33, 2000, 500, 6, true, 1, 1, 0)



	-- x and y coord's
	monster.x = 1906
	monster.y = 1854
	monster.width = monster.idle.frame_width
	monster.height = monster.idle.frame_height

	monster.hitbox = createHitbox(monster.x, monster.y, monster.width, monster.height)

	-- stats
	monster.speed = 300
	monster.health = 100
	monster.power = 100
	monster.armor = 0

	-- the rotation of the sprite in radians
	monster.rotation = 0

	monster.moving = false


	-- movement and shooting
	function monster.update(dt)

		monster.ai(dt)

		monster.hitbox.update(monster.x, monster.y)

		--monster.weapon.update(monster.x, monster.y, monster.rotation)

		if e.moving then
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
			if hitReg(monster.hitbox, v.hitbox) then
				if not(monster.name == v.name) then
					monster.health = monster.health - p.weapon.damage
					print(monster.health)
					hit = true
					setCursor("resources/Hitmarker.png")
					playSound(oof)
					table.remove(bullets, i)

				end
			end
		end
	end

	function monster.ai(dt)
		local index = findClosestNode()

		if pathNodes[index].x > monster.x then
			monster.x = monster.x + monster.speed * dt
			monster.moving = true
		elseif pathNodes[index].x < monster.x then
			monster.x = monster.x - monster.speed * dt
			monster.moving = true
		end

		if pathNodes[index].y > monster.y then
			monster.y = monster.y + monster.speed * dt
			monster.moving = true
		elseif pathNodes[index].y < monster.y then
			monster.y = monster.y - monster.speed * dt
			monster.moving = true
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

	function monster.basicMove()

	end

	return monster
end
