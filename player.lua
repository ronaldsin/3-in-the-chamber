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

	player.weapon = createWeapon("Pathfinder", 10, 0.33, 2000, 500, 6, true, 0)

	player.damage = 10
	player.invincibleAfterHit = .5 --seconds of invincibiliy after being hit

	-- x and y coord's
	player.x = 100
	player.y = 100
	player.width = player.idle.frame_width
	player.height = player.idle.frame_height

	-- stats
	player.speed = 300
	player.health = 100
	player.power = 100
	player.armor = 0

	--status effects
	player.shoot = 0 -- 0<= means able to shoot
	player.invincible = 0 -- 0<= means not invincible
	player.moveControl = 0 --0<= means can move normally
	player.directionLock = 0 -- 0->neutral, 1->up, 2->right, 3->down, 4->left

	--ability
	player.abilityCD = 0 --time in seconds for abiliity to go off CD
	player.ability = "roll"

	-- direction lock for forced movement
	player.xLock = 0
	player.yLock = 0

	-- the rotation of the sprite in radians
	player.rotation = 0

	-- movement and shooting
	function player.update(dt)
		g.update(dt)
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

		--ability updates
		if(player.abilityCD > 0) then
			player.abilityCD = player.abilityCD - dt
			--print("abilityCD" .. player.abilityCD .. "\n")
		end
	end

	function player.hitReg(dt)
		-- bullet hit reg (does not work rn)
		for i, v in ipairs(bullets) do
			if hitReg(player.x - player.width / hitboxScale, player.x + player.width / hitboxScale, player.y - player.height / hitboxScale, player.y + player.height / hitboxScale, v.x - v.width / hitboxScale, v.x + v.width / hitboxScale, v.y - v.height / hitboxScale, v.y + v.height / hitboxScale) then
				if not(player.name == v.name) then
					print(player.name)
					if(player.invincible <= 0) then
						player.invincible = player.invincibleAfterHit
						player.health = player.health - player.damage
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

		if displayHitbox then -- I dont know how the math here works i monkeyed it out at like 6am i no longer rember
			love.graphics.rectangle("line", player.x - player.width / (hitboxScale * 2), player.y - player.height / (hitboxScale * 2), player.width / hitboxScale, player.height / hitboxScale)
		end

		love.graphics.setColor(1, 1, 1 )
	end

	-- rotate player model to mouse
	function player.rotate()
		player.rotation = (math.atan2(love.mouse.getY() - player.y, love.mouse.getX() - player.x) + (math.pi / 2))
	end

	return player
end
