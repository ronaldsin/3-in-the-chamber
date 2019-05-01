function ability(player)

	pa = player.ability

	if (pa == "roll") then -- moves player a short distance while invincible and unable to shoot
		--status
		player.invincible = .4 -- status' in seconds
		player.shoot = .4
		player.moveControl = .4

		--get direction of roll PLEASE change
		p.xLock = 0
		p.yLock = 0

		if love.keyboard.isDown(input_player_left) then
			p.xLock = 1

		elseif love.keyboard.isDown(input_player_right) then
			p.xLock = -1
		end


		if love.keyboard.isDown(input_player_down) then
			p.yLock = -1

		elseif love.keyboard.isDown(input_player_up) then
			p.yLock = 1
		end

		--ability cooldown
		player.abilityCD = 0

	elseif (pa == "bulletTime") then -- activate to freeze bullets, re-activate to continue moving them
		--toggle
		player.bulletTime = not(player.bulletTime)

		--bullets
		for i, v in ipairs(bullets) do
			if(v.name == player.name) then
				if(player.bulletTime == true) then
					v.speed = 0
					v.xVel = 0
					v.yVel = 0

				else
					v.speed = v.OGspeed
					v.xVel = v.OGxVel
					v.yVel = v.OGyVel
				end
			end
		end

		--ability cooldown
		player.abilityCD = 0

	elseif (pa == "slowTime") then
		player.slowTime = not(player.slowTime)
		player.abilityCD = 0

	elseif (pa == "BTD") then
		player.BTD = not(player.BTD)

		if player.BTD then
			returnX = player.x
			returnY = player.y

		else
			player.x = returnX
			player.y = returnY
		end

		player.abilityCD = 0

	elseif (pa == "50m") then
		player.fm = not(player.fm)

		if distanceF(player.x, player.y, e.x, e.y) < 200 then
			e.takeDmg(20)
		end

		player.abilityCD = 0

	elseif (pa == "clone" and clone_counter == 0) then
		player.clone = true
		c.moveControl = 1
		c.invincible = 1
		c.x = player.x
		c.y = player.y
		c.updateStance()

	elseif (pa == "shield") then
		player.shield = not(player.shield)

	end

end
