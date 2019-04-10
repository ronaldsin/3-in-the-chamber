function ability(player)
	if (player.ability == "roll") then
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
	end
end
