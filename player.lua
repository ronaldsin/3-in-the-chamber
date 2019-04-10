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
	player.legs = createAnimation("PonytailLegs", 3, 10, 2, 2, 1, 256, 256)

	player.stances = {}

	table.insert(player.stances, createAnimation("PonytailIdle", 4, 3, 2, 2, 1, 256, 256))
	table.insert(player.stances, createAnimation("Ponytail_AssaultRifle", 4, 3, 2, 2, 1, 256, 256))

	player.weapon = createWeapon("Pathfinder", 40, 0.33, 2000, 400, 6, 6, 1, true, 1, 1, 1, 0)

	player.damage = 10
	player.invincibleAfterHit = .5 --seconds of invincibiliy after being hit

	-- x and y coord's
	player.x = 100
	player.y = 100
	player.width = player.idle.frame_width
	player.height = player.idle.frame_height

	player.hitbox = createHitbox(player.x, player.y, player.width, player.height)

	-- stats
	player.speed = 500 -- default 300
	player.health = 100
	player.power = 100
	player.armor = 0

	--status effects
	player.shoot = 0 -- 0<= means able to shoot
	player.invincible = 0 -- 0<= means not invincible
	player.moveControl = 0 --0<= means can move normally
	player.directionLock = 0 -- 0->neutral, 1->up, 2->right, 3->down, 4->left

	--flat Damage Over Time
	player.flatDOT = 0		--amount of damage
	player.flatDOTchunk = 0 -- amount DOT does each interval
	player.flatDOTtimerReset = 3 --seconds for damage to apply
	player.flatDOTtimer = 0

	--ability
	player.abilityCD = 0 --time in seconds for abiliity to go off CD
	player.ability = "bulletTime"

	-- direction lock for forced movement
	player.xLock = 0
	player.yLock = 0

	-- toggle "bullet time" ability
	player.bulletTime = false

	-- the rotation of the sprite in radians
	player.rotation = 0

	-- movement and shooting
	function player.update(dt)

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
			--print("moveControl" .. player.moveControl .. "\n")
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

		love.graphics.setColor(1, 1, 1 )
	end

	-- rotate player model to mouse
	function player.rotate()
		player.rotation = (math.atan2(love.mouse.getY() - player.y, love.mouse.getX() - player.x) + (math.pi / 2))
	end

	return player
end
