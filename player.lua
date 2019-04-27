function Player(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local player = {}

	player.name = name

	player.moving = false

	-- createAnimation(name, frames, fps, r, c, iframe, fheight, fwidth)
	player.idle = createAnimation("PonytailIdle", 4, 2, 2, 2, 1, 256, 256)
	player.legs = createAnimation("PonytailLegs", 14, 10, 4, 4, 1, 256, 256)

	player.stances = {}

	table.insert(player.stances, createAnimation("PonytailIdle", 4, 3, 2, 2, 1, 256, 256))
	table.insert(player.stances, createAnimation("Ponytail_AssaultRifle", 4, 3, 2, 2, 1, 256, 256))

	player.weapon = createWeapon("Pathfinder", 40, 0.33, 450, 400, 6, 6, 2, true, 1, 1, 30, 100)

	player.damage = 10
	player.invincibleAfterHit = .5 --seconds of invincibiliy after being hit

	-- x and y coord's
	player.x = 973
	player.y = 1091
	player.width = player.idle.frame_width
	player.height = player.idle.frame_height

	player.hitbox = createHitbox(player.x, player.y, player.width, player.height)

	-- stats
	player.speed = 600 -- default 300
	player.health = 100
	player.power = 100
	player.armor = 0

	-- status effects
	player.shoot = 0 -- 0<= means able to shoot
	player.invincible = 0 -- 0<= means not invincible
	player.moveControl = 0 --0<= means can move normally
	player.directionLock = 0 -- 0->neutral, 1->up, 2->right, 3->down, 4->left

	-- flat Damage Over Time
	player.flatDOT = 0 --amount of damage
	player.flatDOTchunk = 0 -- amount DOT does each interval
	player.flatDOTtimerReset = 3 --seconds for damage to apply
	player.flatDOTtimer = 0

	-- ability
	player.abilityCD = 0 --time in seconds for abiliity to go off CD
	player.abilities = {}

	table.insert(player.abilities, "roll")
	table.insert(player.abilities, "bulletTime")
	table.insert(player.abilities, "slowTime")

	player.abilityNumber = 1
	player.ability = player.abilities[player.abilityNumber]

	-- direction lock for forced movement
	player.xLock = 0
	player.yLock = 0

	-- the rotation of the sprite in radians
	player.rotation = 0

	player.ly = player.y
	player.lx = player.x

	-- toggle "bullet time" ability
	player.bulletTime = false
	player.slowTime = false
	player.ricochet = false

	player.tmp = true

	cnIndex = 1

	-- movement and shooting
	function player.update(dt)

		player.playerNodeUpdate()

		player.hitbox.update(player.x, player.y)

		player.weapon.update(player.x, player.y, player.rotation, dt)

		if p.moving then
			player.legs.update(dt)
		else
			player.legs.idle()
		end

		player.idle.update(dt)

		player.hitReg(dt)

		-- update rotation
		player.rotate()

		--status updates --note, status duration and "time" hard coded
		player.statusAbilityUpdate(dt)
		player.temp = true

		for i, v in ipairs(walls) do
			if lineIntersection(player.x, e.x, v.left, v.right, player.y, e.y, v.top, v.top) or
			lineIntersection(player.x, e.x, v.right, v.right, player.y, e.y, v.top, v.bottom) or
			lineIntersection(player.x, e.x, v.left, v.right, player.y, e.y, v.bottom, v.bottom) or
			lineIntersection(player.x, e.x, v.left, v.left, player.y, e.y, v.top, v.bottom) then
				player.temp = false
			end

		end
	end

	function player.updateStance()
		player.idle = player.stances[player.weapon.stance]

	end

	function player.statusAbilityUpdate(dt)
		--status updates
		if(player.shoot > 0) then
			player.shoot = player.shoot - dt
			--print("shoot" .. player.shoot .. "\n")
		end

		if(player.invincible > 0) then
			player.invincible = player.invincible - dt
			--print("invincible" .. player.invincible .. "\n")
		end

		if(player.moveControl > 0) then
			player.moveControl = player.moveControl - dt
			--print("moveControl" .. moveControl .. "\n")
		end

		if(player.flatDOT > 0) then
			player.flatDOTtimer = player.flatDOTtimer - dt
			if (player.flatDOTtimer < 0) then
				player.flatDOTtimer = player.flatDOTtimerReset
				if (player.flatDOTchunk > player.flatDOT) then
					player.health = player.health - player.flatDOT
					player.flatDOT = 0
					--print("health" .. player.health .. "\n")
				else
					player.health = player.health - player.flatDOTchunk
					player.flatDOT = player.flatDOT - player.flatDOTchunk
					--print("health" .. player.health .. "\n")
				end
			end
		end

		--ability updates
		if(player.abilityCD > 0) then
			player.abilityCD = player.abilityCD - dt
			--print("abilityCD" .. player.abilityCD .. "\n")
		end
	end

	function player.hitReg(dt)
		-- bullet hit reg (does not work rn)
		for i, v in ipairs(bullets) do
			if hitReg(player.hitbox, v.hitbox) then
				if not(player.name == v.name) then
					if(player.invincible <= 0) then
						player.invincible = player.invincibleAfterHit
						player.health = player.health - e.weapon.damage
						hit = true
						setCursor("resources/Hitmarker.png")
						playSound(oof)
					end
					table.remove(bullets, i)

				end
			end
		end
	end


	-- drawing to screen
	function player.draw()

		if player.health <= 0 then
			love.graphics.setColor(1, 0, 0)
		end

		player.legs.draw(player.x, player.y, player.rotation)
		player.idle.draw(player.x, player.y, player.rotation)
		player.weapon.draw(player.x, player.y, player.rotation)

		player.hitbox.draw()

		player.weapon.draw()

		if player.temp then
			love.graphics.print("los", player.x, player.y)
		end

		love.graphics.line(player.x, player.y, e.x, e.y)

		love.graphics.setColor(1, 1, 1 )
	end

	-- rotate player model to mouse
	function player.rotate()
		player.rotation = (math.atan2(camera.getMouseY() - player.y, camera.getMouseX() - player.x) + (math.pi / 2))
	end

	function player.playerNodeUpdate()
		pathNodes[1].x = player.x
		pathNodes[1].y = player.y

		--find closest
		if not (cnIndex == findClosestNode(player.x, player.y, 2)) then
			if e.patienceCounter > e.patience then
				e.lost = true
				e.patienceCounter = 0
			end
			cnIndex = findClosestNode(player.x, player.y, 2)
		end

		cnIndex = findClosestNode(player.x, player.y, 2)


		--update connection
		for i = 1, #pathNodes, 1 do
			if (adjMat[1][i] == 1) then
				adjMat[1][i] = 0
				adjMat[i][1] = 0
			end
			if(i == cnIndex) then
				adjMat[1][i] = 1
				adjMat[i][1] = 1
			end
		end

	end

	return player
end
