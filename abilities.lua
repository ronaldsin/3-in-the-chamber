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
				print("bullet")
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

	end
end
